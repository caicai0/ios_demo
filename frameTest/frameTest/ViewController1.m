//
//  ViewController.m
//  frameTest
//
//  Created by liyufeng on 2017/2/23.
//  Copyright © 2017年 liyufeng. All rights reserved.
//

#import "ViewController1.h"

@interface ViewController1 ()

@end

@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSLog(@"%@",documentDirectory);
    NSArray* arrFramework = [self getFilenamelistOfType:@"framework"  fromDirPath:documentDirectory];
    
    NSString *bundlePath = [NSString stringWithFormat:@"%@/%@",documentDirectory,[arrFramework lastObject]];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:bundlePath]) {
        NSLog(@"file not exist ,now  return");
    }else{
        NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
        
        if (!bundle || ![bundle load]) {
            NSLog(@"bundle load error");
        }else{
            UIViewController *controller = [[UIStoryboard storyboardWithName:@"hotup" bundle:bundle]instantiateInitialViewController];
            
            [self presentViewController:controller animated:YES completion:^{
                NSLog(@"调用成功");
            }];
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSArray *) getFilenamelistOfType:(NSString *)type fromDirPath:(NSString *)dirPath
{
    NSArray *fileList = [[[NSFileManager defaultManager] contentsOfDirectoryAtPath:dirPath error:nil]
                         pathsMatchingExtensions:[NSArray arrayWithObject:type]];
    return fileList;
}


@end
