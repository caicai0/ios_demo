//
//  sinaView.m
//  sinaHeader
//
//  Created by 李玉峰 on 2018/3/28.
//  Copyright © 2018年 李玉峰. All rights reserved.
//

#import "sinaView.h"

@interface sinaView()

@property (strong, nonatomic)UIScrollView * scrollView;
@property (strong, nonatomic)NSArray * tableViews;
@property (strong, nonatomic)UIView * headerView;

@end

@implementation sinaView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:self.scrollView];
    }
    return self;
}

- (void)addHeaderView:(UIView *)headerView{
    self.headerView = headerView;
    [self addSubview:headerView];
}
- (void)addTableView:(UITableView *)tableView{
    tableView.frame = CGRectMake(self.tableViews.count * self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height);
    [self.scrollView addSubview:tableView];
}

@end
