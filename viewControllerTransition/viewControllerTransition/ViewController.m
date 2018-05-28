//
//  ViewController.m
//  viewControllerTransition
//
//  Created by cai on 2018/5/28.
//  Copyright © 2018年 cai. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)jump:(id)sender {
    UIViewController * controller = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"PresentViewController"];
    controller.transitioningDelegate = self;
    [self presentViewController:controller animated:YES completion:nil];
}


@end
