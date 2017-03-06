//
//  CAIPatch.h
//  CAIJSPatch
//
//  Created by liyufeng on 2017/3/6.
//  Copyright © 2017年 liyufeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CAIPatch : NSObject

@property (nonatomic, strong)NSString * remoteUrl;//github地址

+ (instancetype)sharePatch;
- (void)start;

@end
