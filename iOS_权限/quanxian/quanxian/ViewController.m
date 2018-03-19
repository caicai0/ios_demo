//
//  ViewController.m
//  quanxian
//
//  Created by 李玉峰 on 2018/3/19.
//  Copyright © 2018年 李玉峰. All rights reserved.
//

#import "ViewController.h"
#import <UserNotifications/UserNotifications.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //获取权限
    if ([UIApplication sharedApplication].isRegisteredForRemoteNotifications) {
        [[UIApplication sharedApplication] currentUserNotificationSettings];
    }else{
        NSLog(@"no");
    }
    
    if ([[UIApplication sharedApplication] currentUserNotificationSettings]) {
        [[UNUserNotificationCenter currentNotificationCenter]getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            UNNotificationSetting * notificationSetting = settings.notificationCenterSetting;
            NSLog(@"%d",notificationSetting);
        }];
    }
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]]){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
