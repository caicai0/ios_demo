//
//  CAIPatch.m
//  CAIJSPatch
//
//  Created by liyufeng on 2017/3/6.
//  Copyright © 2017年 liyufeng. All rights reserved.
//

#import "CAIPatch.h"
#import "JPEngine.h"

@interface CAIPatch()

@property (nonatomic, strong)NSString * loadingVersion;//正在下载的版本号

@end

@implementation CAIPatch

static CAIPatch * sharePatch;

+ (instancetype)sharePatch{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharePatch = [[CAIPatch alloc]init];
    });
    return sharePatch;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [JPEngine startEngine];
        self.remoteUrl = @"https://github.com/caicai0/ios_patch/blob/master";
    }
    return self;
}

- (void)start{
    NSUserDefaults * df = [[NSUserDefaults alloc]initWithSuiteName:@"cai_ios_patch"];
    NSString * build = [df stringForKey:@"build"];
    NSString * version = [df stringForKey:@"version"];
    NSString * js = [df stringForKey:@"js"];
    NSDictionary *appInfo = [NSBundle mainBundle].infoDictionary;
    NSString * appbuild = appInfo[@"CFBundleVersion"];
    if (build && version && js && [appbuild isEqualToString:build]) {
        [JPEngine evaluateScript:js];
    }
    
    [self loadVersion];
}

- (void)loadVersion{
    NSDictionary *appInfo = [NSBundle mainBundle].infoDictionary;
    NSString * repo = self.remoteUrl;
    NSString * bundleIdentifer = appInfo[@"CFBundleIdentifier"];
    NSString * buildN = appInfo[@"CFBundleVersion"];
    NSString * urlString = [NSString stringWithFormat:@"%@/%@/%@.version?raw=true",repo,bundleIdentifer,buildN];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLSessionTask *task = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error && data) {
            NSString * version = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            if (version && version.length) {
                NSUserDefaults * df = [[NSUserDefaults alloc]initWithSuiteName:@"cai_ios_patch"];
                NSString * localVersion = [df stringForKey:@"version"];
                if (localVersion && [localVersion isKindOfClass:[NSString class]] && [localVersion isEqualToString:version]) {
                    //不用下载
                }else{
                    //下载脚本
                    self.loadingVersion = version;
                    [self loadJs];
                }
            }
        }
    }];
    [task resume];
}

- (void)loadJs{
    NSDictionary *appInfo = [NSBundle mainBundle].infoDictionary;
    NSString * repo = self.remoteUrl;
    NSString * bundleIdentifer = appInfo[@"CFBundleIdentifier"];
    NSString * buildN = appInfo[@"CFBundleVersion"];
    NSString * urlString = [NSString stringWithFormat:@"%@/%@/%@.js?raw=true",repo,bundleIdentifer,buildN];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLSessionTask *task = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error && data) {
            NSString * jsString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            [self updateLocalJs:jsString];
        }
    }];
    
    // 启动任务
    [task resume];
}

- (void)updateLocalJs:(NSString *)jsString{
    if (jsString) {
        if (jsString.length) {
            NSUserDefaults * df = [[NSUserDefaults alloc]initWithSuiteName:@"cai_ios_patch"];
            NSDictionary *appInfo = [NSBundle mainBundle].infoDictionary;
            NSString * appbuild = appInfo[@"CFBundleVersion"];
            [df setObject:appbuild forKey:@"build"];
            [df setObject:self.loadingVersion forKey:@"version"];
            [df setObject:jsString forKey:@"js"];
            [df synchronize];
        }else{
            NSUserDefaults * df = [[NSUserDefaults alloc]initWithSuiteName:@"cai_ios_patch"];
            NSDictionary *appInfo = [NSBundle mainBundle].infoDictionary;
            NSString * appbuild = appInfo[@"CFBundleVersion"];
            [df setObject:appbuild forKey:@"build"];
            [df setObject:self.loadingVersion forKey:@"version"];
            [df removeObjectForKey:@"js"];
            [df synchronize];
        }
    }
}

@end
