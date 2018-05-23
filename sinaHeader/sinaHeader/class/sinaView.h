//
//  sinaView.h
//  sinaHeader
//
//  Created by 李玉峰 on 2018/3/28.
//  Copyright © 2018年 李玉峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface sinaView : UIView

@property (nonatomic ,assign)NSInteger currentIndex;

- (void)addHeaderView:(UIView *)headerView;
- (void)addTableView:(UITableView *)tableView;

@end
