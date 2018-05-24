//
//  ViewController.m
//  animationDemo
//
//  Created by cai on 2018/5/24.
//  Copyright © 2018年 cai. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<CAAnimationDelegate>
@property (nonatomic, strong)UIImageView * imageview;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)clicke:(id)sender {
    UIImageView * imageView = [[UIImageView alloc]init];
    self.imageview = imageView;
    imageView.backgroundColor = [UIColor redColor];
    imageView.frame = CGRectMake(100, 100, 100, 100);
    imageView.transform = CGAffineTransformMakeRotation(M_PI_4);
    [self.view addSubview:imageView];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.duration = 2;
    animation.repeatCount = 1;
    animation.beginTime =CACurrentMediaTime() + 1;// 1秒后执行
    animation.fromValue = [NSValue valueWithCGPoint:imageView.layer.position]; // 起始帧
    
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(imageView.layer.position.x, -100)]; // 终了帧
    
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    animation.delegate = self;
    
    // 视图添加动画
    
    [imageView.layer addAnimation:animation forKey:@"move-layer"];
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [self.imageview removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
