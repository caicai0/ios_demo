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
    
    if (@available(iOS 10.0, *)) {
        [[UNUserNotificationCenter currentNotificationCenter]getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            UNNotificationSetting notificationSetting = settings.notificationCenterSetting;
            if (notificationSetting == UNNotificationSettingEnabled) {
                
            }else if(notificationSetting == UNNotificationSettingDisabled){
                
            }else{//UNNotificationSettingNotSupported
                
            }
        }];
    } else {
        if (@available(iOS 8.0, *)) {
            if([[UIApplication sharedApplication] currentUserNotificationSettings].types == UIUserNotificationTypeNone){
                
            }else{
                
            }
        }else{
            if ([[UIApplication sharedApplication] enabledRemoteNotificationTypes]  == UIRemoteNotificationTypeNone){
                
            }else{
                
            }
        }
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
