//
//  TabController.m
//  HotUpdate
//
//  Created by wukong on 15/12/18.
//  Copyright © 2015年 lhc. All rights reserved.
//

#import "TabController.h"
//#import <HotUpdateMudel/HotUpdateControl.h>
@interface TabController ()

@end

@implementation TabController

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSArray* arrFramework = [self getFilenamelistOfType:@"framework"  fromDirPath:documentDirectory];
        NSLog(@"%@",arrFramework);
        if (arrFramework.count==0) {
            NSArray * arrTitle = @[@"首页",@"广场",@"朋友圈",@"我的",@"设置"];
            NSMutableArray * arrVcs = @[].mutableCopy;
            for (int i=0; i<arrTitle.count; i++) {
                UIViewController * vcRoot = [[UIViewController alloc]init];
                vcRoot.title = arrTitle[i];
                vcRoot.view.backgroundColor = [UIColor whiteColor];
                UINavigationController * navi = [[UINavigationController alloc]initWithRootViewController:vcRoot];
                [arrVcs addObject:navi];
            }
            [self setViewControllers:arrVcs animated:YES];
            
        }else{
            
            NSString *bundlePath = [NSString stringWithFormat:@"%@/%@",documentDirectory,[arrFramework lastObject]];
            
            if (![[NSFileManager defaultManager] fileExistsAtPath:bundlePath]) {
                NSLog(@"file not exist ,now  return");
                return self;
            }
            NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
            
            if (!bundle || ![bundle load]) {
                NSLog(@"bundle load error");
            }
            
            Class loadClass = [bundle classNamed:@"HotUpdateControl"];
            if (!loadClass) {
                NSLog(@"get bundle class fail");
                return self;
            }
            NSObject *bundleObj = [loadClass new];
            NSArray * arrVc = [bundleObj performSelector:@selector(getVcs)];
            
            NSMutableArray * arrVcs = @[].mutableCopy;
            for (int i=0; i<arrVc.count; i++) {
                UIViewController * vcRoot =arrVc[i];
                vcRoot.view.backgroundColor = [UIColor whiteColor];
                UINavigationController * navi = [[UINavigationController alloc]initWithRootViewController:vcRoot];
                [arrVcs addObject:navi];
            }
            
            [self setViewControllers:arrVcs animated:YES];
            
        }
    }
    return self;
}

-(NSArray *) getFilenamelistOfType:(NSString *)type fromDirPath:(NSString *)dirPath
{
    NSArray *fileList = [[[NSFileManager defaultManager] contentsOfDirectoryAtPath:dirPath error:nil]
                         pathsMatchingExtensions:[NSArray arrayWithObject:type]];
    return fileList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


@end
