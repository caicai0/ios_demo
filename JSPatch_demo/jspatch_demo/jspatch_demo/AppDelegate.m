//
//  AppDelegate.m
//  JSPatch
//
//  Created by bang on 15/4/30.
//  Copyright (c) 2015年 bang. All rights reserved.
//

#import "AppDelegate.h"

#import "JPViewController.h"
#import <CAIJSPatch/CAIPatch.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [[CAIPatch sharePatch]start];
    
    return YES;
}

- (void)loadPatch{
    NSUserDefaults * df = [[NSUserDefaults alloc]initWithSuiteName:@"cai_ios_patch"];
    NSString * durl = [df stringForKey:@"url"];
    NSLog(@"dfurl:%@",durl);
    NSString * repo = @"https://github.com/caicai0/ios_patch/blob/master";
    NSString * bundleIdentifer = [NSBundle mainBundle].infoDictionary[@"CFBundleIdentifier"];
    NSString * buildN = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    NSString * url = [NSString stringWithFormat:@"%@/%@/%@.js?raw=true",repo,bundleIdentifer,buildN];
    NSLog(@"%@",url);
    [df setObject:url forKey:@"url"];
}

@end
