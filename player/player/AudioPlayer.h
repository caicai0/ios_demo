//
//  AudioPlayer.h
//  player
//
//  Created by 李玉峰 on 2018/4/13.
//  Copyright © 2018年 cai. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * AudioPlayerStopNotification;

@class AudioPlayer;

typedef NS_ENUM(NSUInteger, AudioPlayerState) {
    AudioPlayerStateFailed,     // 播放失败
    AudioPlayerStateBuffering,  // 缓冲中
    AudioPlayerStatePlaying,    // 播放中
    AudioPlayerStateStopped,    // 停止播放
    AudioPlayerStatePause       // 播放暂停
};

@protocol AudioPlayerDelegate <NSObject>

- (void)player:(AudioPlayer *)player didChangeState:(AudioPlayerState)state;
- (void)player:(AudioPlayer *)player updateCurrentTime:(NSTimeInterval)currentTime totalTime:(NSTimeInterval)totalTime;
- (void)player:(AudioPlayer *)player updateLoadedTime:(NSTimeInterval)loadedTime totalTime:(NSTimeInterval)totalTime;

@end



@interface AudioPlayer : NSObject

@property (nonatomic, assign)AudioPlayerState state;
@property (nonatomic, weak)id<AudioPlayerDelegate> delegate;

+ (instancetype)sharePlayer;

- (void)playURL:(NSURL *)url;
- (void)pause;
- (void)play;

@end
