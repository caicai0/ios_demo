//
//  AudioPlayer.m
//  player
//
//  Created by 李玉峰 on 2018/4/13.
//  Copyright © 2018年 cai. All rights reserved.
//

#import "AudioPlayer.h"
#import <AVFoundation/AVFoundation.h>

NSString * AudioPlayerStopNotification = @"AudioPlayerStopNotification";

@interface AudioPlayer()

@property (nonatomic, strong)NSURL * mediaUrl;

@property (nonatomic, assign)NSTimeInterval currentTime;
@property (nonatomic, assign)NSTimeInterval loadedTime;
@property (nonatomic, assign)NSTimeInterval totalTime;


@property (nonatomic, strong)AVURLAsset * urlAsset;
@property (nonatomic, strong)AVPlayerItem * playerItem;
@property (nonatomic, strong)AVPlayer * player;
@property (nonatomic, strong) id timeObserve;

@end

@implementation AudioPlayer

+ (instancetype)sharePlayer{
    static AudioPlayer * share;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        share = [[AudioPlayer alloc]init];
    });
    return share;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)playURL:(NSURL *)url{
    [self resetPlayer];
    self.mediaUrl = url;
    [self configPlayer];
}

- (void)pause{
    if (self.state == AudioPlayerStatePlaying) {
        self.state = AudioPlayerStatePause;
    }
    [self.player pause];
}
- (void)play{
    if (self.state == AudioPlayerStatePause) {
        self.state = AudioPlayerStatePlaying;
    }
    [self.player play];
}

- (void)configPlayer{
    self.urlAsset = [AVURLAsset assetWithURL:self.mediaUrl];
    self.playerItem = [AVPlayerItem playerItemWithAsset:self.urlAsset];
    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
    [self createTimer];
    [self configureVolume];
    [self addNotifications];
    if ([self.mediaUrl.scheme isEqualToString:@"file"]) {
        self.state = AudioPlayerStatePlaying;
    } else {
        self.state = AudioPlayerStateBuffering;
    }
    [self play];
}

- (void)createTimer {
    __weak typeof(self) weakSelf = self;
    self.timeObserve = [self.player addPeriodicTimeObserverForInterval:CMTimeMakeWithSeconds(1, 1) queue:nil usingBlock:^(CMTime time){
        AVPlayerItem *currentItem = weakSelf.playerItem;
        NSArray *loadedRanges = currentItem.seekableTimeRanges;
        if (loadedRanges.count > 0 && currentItem.duration.timescale != 0) {
            NSInteger currentTime = (NSInteger)CMTimeGetSeconds([currentItem currentTime]);
            CGFloat totalTime     = (CGFloat)currentItem.duration.value / currentItem.duration.timescale;
            __strong typeof(weakSelf)strongSelf = weakSelf;
            strongSelf.currentTime = currentTime;
            if (strongSelf.delegate && [strongSelf.delegate respondsToSelector:@selector(player:updateCurrentTime:totalTime:)]) {
                [strongSelf.delegate player:strongSelf updateCurrentTime:currentTime totalTime:totalTime];
            }
        }
    }];
}

/**
 *  获取系统音量
 */
- (void)configureVolume {
    NSError *setCategoryError = nil;
    BOOL success = [[AVAudioSession sharedInstance]
                    setCategory: AVAudioSessionCategoryPlayback
                    error: &setCategoryError];
    
    if (!success) { /* handle the error in setCategoryError */ }
}

- (void)resetPlayer{
    if (self.timeObserve) {
        [self.player removeTimeObserver:self.timeObserve];
        self.timeObserve = nil;
    }
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [self.player pause];
    self.player = nil;
    self.currentTime = 0;
    self.loadedTime = 0;
    self.totalTime = 0;
}

- (void)addNotifications {
    // app退到后台
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidEnterBackground) name:NSExtensionHostWillResignActiveNotification object:nil];
    // app进入前台
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidEnterPlayground) name:NSExtensionHostDidBecomeActiveNotification object:nil];
    // 监听耳机插入和拔掉通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(audioRouteChangeListenerCallback:) name:AVAudioSessionRouteChangeNotification object:nil];
}

- (void)setPlayerItem:(AVPlayerItem *)playerItem {
    if (_playerItem == playerItem) {return;}
    if (_playerItem) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:_playerItem];
        [_playerItem removeObserver:self forKeyPath:@"status"];
        [_playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
        [_playerItem removeObserver:self forKeyPath:@"playbackBufferEmpty"];
        [_playerItem removeObserver:self forKeyPath:@"playbackLikelyToKeepUp"];
    }
    _playerItem = playerItem;
    if (playerItem) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:playerItem];
        [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
        [playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
        [playerItem addObserver:self forKeyPath:@"playbackBufferEmpty" options:NSKeyValueObservingOptionNew context:nil];
        [playerItem addObserver:self forKeyPath:@"playbackLikelyToKeepUp" options:NSKeyValueObservingOptionNew context:nil];
    }
}

/**
 *  设置播放的状态
 *
 *  @param state ZFPlayerState
 */
- (void)setState:(AudioPlayerState)state {
    _state = state;
    NSLog(@"%ld",state);
    if (self.delegate && [self.delegate respondsToSelector:@selector(player:didChangeState:)]) {
        [self.delegate player:self didChangeState:state];
    }
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == self.player.currentItem) {
        if ([keyPath isEqualToString:@"status"]) {
            
            if (self.player.currentItem.status == AVPlayerItemStatusReadyToPlay) {
                self.totalTime = CMTimeGetSeconds(self.player.currentItem.duration);
                self.state = AudioPlayerStatePlaying;
            } else if (self.player.currentItem.status == AVPlayerItemStatusFailed) {
                self.state = AudioPlayerStateFailed;
            }
        } else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
            
            // 计算缓冲进度
            NSTimeInterval timeInterval = [self availableDuration];
            CMTime duration             = self.playerItem.duration;
            CGFloat totalDuration       = CMTimeGetSeconds(duration);
            self.loadedTime = timeInterval;
            if (self.delegate && [self.delegate respondsToSelector:@selector(player:updateLoadedTime:totalTime:)]) {
                [self.delegate player:self updateLoadedTime:timeInterval totalTime:totalDuration];
            }
        } else if ([keyPath isEqualToString:@"playbackBufferEmpty"]) {
            if (self.playerItem.playbackBufferEmpty) {
                self.state = AudioPlayerStateBuffering;
            }
        } else if ([keyPath isEqualToString:@"playbackLikelyToKeepUp"]) {
            if (self.playerItem.playbackLikelyToKeepUp && self.state == AudioPlayerStateBuffering){
                self.state = AudioPlayerStatePlaying;
            }
        }
    }
}

#pragma mark - 计算缓冲进度

/**
 *  计算缓冲进度
 *
 *  @return 缓冲进度
 */
- (NSTimeInterval)availableDuration {
    NSArray *loadedTimeRanges = [[_player currentItem] loadedTimeRanges];
    CMTimeRange timeRange     = [loadedTimeRanges.firstObject CMTimeRangeValue];// 获取缓冲区域
    float startSeconds        = CMTimeGetSeconds(timeRange.start);
    float durationSeconds     = CMTimeGetSeconds(timeRange.duration);
    NSTimeInterval result     = startSeconds + durationSeconds;// 计算缓冲总进度
    return result;
}

/**
 *  播放完了
 *
 *  @param notification 通知
 */
- (void)moviePlayDidEnd:(NSNotification *)notification {
    if (notification.object == self.playerItem) {
        self.state = AudioPlayerStateStopped;
        [[NSNotificationCenter defaultCenter]postNotificationName:AudioPlayerStopNotification object:nil];
    }
}

/**
 *  应用退到后台
 */
- (void)appDidEnterBackground {

}

/**
 *  应用进入前台
 */
- (void)appDidEnterPlayground {

}

/**
 *  耳机插入、拔出事件
 */
- (void)audioRouteChangeListenerCallback:(NSNotification*)notification {
    NSDictionary *interuptionDict = notification.userInfo;
    
    NSInteger routeChangeReason = [[interuptionDict valueForKey:AVAudioSessionRouteChangeReasonKey] integerValue];
    
    switch (routeChangeReason) {
            
        case AVAudioSessionRouteChangeReasonNewDeviceAvailable:
            // 耳机插入
            break;
            
        case AVAudioSessionRouteChangeReasonOldDeviceUnavailable: {
            // 耳机拔掉
            [self play];
        }
            break;
            
        case AVAudioSessionRouteChangeReasonCategoryChange:
            // called at start - also when other audio wants to play
            NSLog(@"AVAudioSessionRouteChangeReasonCategoryChange");
            break;
    }
}

@end
