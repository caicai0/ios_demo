//
//  ViewController.m
//  player
//
//  Created by 李玉峰 on 2018/4/13.
//  Copyright © 2018年 cai. All rights reserved.
//

#import "ViewController.h"
#import "AudioPlayer.h"

@interface ViewController ()<AudioPlayerDelegate>

@property (nonatomic, strong)AudioPlayer * player;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UIProgressView *progress;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)first:(id)sender {
    NSString * mp3url = @"http://192.168.1.174:8080/xpg.mp3";
    NSURL * url = [NSURL URLWithString:mp3url];
    self.player = [AudioPlayer sharePlayer];
    [self.player playURL:url];
    self.player.delegate = self;
}

- (IBAction)pause:(id)sender {
    if (self.player.state == AudioPlayerStatePlaying) {
        [self.player pause];
    }else if(self.player.state == AudioPlayerStatePause){
        [self.player play];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)player:(AudioPlayer *)player didChangeState:(AudioPlayerState)state{
    if (state == AudioPlayerStateBuffering) {
        self.progress.progress = 0;
        self.slider.value = 0;
    }
}
- (void)player:(AudioPlayer *)player updateCurrentTime:(NSTimeInterval)currentTime totalTime:(NSTimeInterval)totalTime{
    if (totalTime!=0) {
        self.slider.value = currentTime/totalTime;
    }
}
- (void)player:(AudioPlayer *)player updateLoadedTime:(NSTimeInterval)loadedTime totalTime:(NSTimeInterval)totalTime{
    if (totalTime!=0) {
        self.progress.progress = loadedTime/totalTime;
    }
}

@end
