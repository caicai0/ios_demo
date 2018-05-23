//
//  ViewController.m
//  LFliveDemo
//
//  Created by 李玉峰 on 2018/4/26.
//  Copyright © 2018年 cai. All rights reserved.
//

#import "ViewController.h"
#import "EncodeAndPush.h"
#import "LFVideoCapture.h"
#import "LFAudioCapture.h"

@interface ViewController ()<LFVideoCaptureDelegate,LFAudioCaptureDelegate,LFLiveSessionDelegate>

@property (nonatomic, strong)EncodeAndPush * session;
@property (nonatomic, strong)LFVideoCapture * capture;
@property (nonatomic, strong)LFAudioCapture * audioCapture;
@property (nonatomic, strong)LFLiveAudioConfiguration *audioConfiguration;
@property (nonatomic, strong)LFLiveVideoConfiguration *videoConfiguration;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.videoConfiguration = [LFLiveVideoConfiguration defaultConfiguration];
    self.audioConfiguration = [LFLiveAudioConfiguration defaultConfiguration];
    
    self.session = [[EncodeAndPush alloc]initWithAudioConfiguration:self.audioConfiguration videoConfiguration:self.videoConfiguration];
    self.session.delegate = self;
    
    self.capture = [[LFVideoCapture alloc]initWithVideoConfiguration:self.videoConfiguration];
    self.capture.delegate = self;
    self.capture.preView = self.view;
    self.capture.captureDevicePosition = AVCaptureDevicePositionBack;
    self.capture.running = YES;
    
    self.audioCapture = [[LFAudioCapture alloc]initWithAudioConfiguration:self.audioConfiguration];
    self.audioCapture.delegate = self;
    self.audioCapture.running = YES;
    
    LFLiveStreamInfo * info = [[LFLiveStreamInfo alloc]init];
    info.url = @"rtmp://js.live-send.acg.tv/live-js/?streamname=live_17085791_7973265&key=efd2188d51df8a8d4ea173da9d6e39e7";
    [self.session startLive:info];
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - LFVideoCaptureDelegate

- (void)captureOutput:(nullable LFVideoCapture *)capture pixelBuffer:(nullable CVPixelBufferRef)pixelBuffer{
    [self.session capturePixelBuffer:pixelBuffer];
}

#pragma mark - LFAudioCaptureDelegate

- (void)captureOutput:(nullable LFAudioCapture *)capture audioData:(nullable NSData*)audioData{
    [self.session captureAudioData:audioData];
}

#pragma mark -
- (void)liveSession:(nullable EncodeAndPush *)session liveStateDidChange:(LFLiveState)state{
    NSLog(@"%@,%ld",session,state);
    if (state == 2) {
        session.running = YES;
    }
}
- (void)liveSession:(nullable EncodeAndPush *)session debugInfo:(nullable LFLiveDebug *)debugInfo{
    NSLog(@"%@,%@",session,debugInfo);
}
- (void)liveSession:(nullable EncodeAndPush *)session errorCode:(LFLiveSocketErrorCode)errorCode{
    NSLog(@"%@,%ld",session,errorCode);
}

@end
