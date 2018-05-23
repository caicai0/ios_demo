//
//  ViewController.m
//  la_demo
//
//  Created by 李玉峰 on 2018/4/2.
//  Copyright © 2018年 李玉峰. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *codeLbl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.codeLbl.text = NSLocalizedString(@"demoString",nil);
    self.codeLbl.text = NSLocalizedStringFromTable(@"demoString", @"eng", nil);
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
