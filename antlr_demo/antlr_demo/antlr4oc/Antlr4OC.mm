//
//  Antlr4OC.m
//  antlr_demo
//
//  Created by 李玉峰 on 2018/3/21.
//  Copyright © 2018年 李玉峰. All rights reserved.
//

#import "Antlr4OC.h"
#import "antlr4-runtime.h"

@implementation Antlr4OC

- (instancetype)init
{
    self = [super init];
    if (self) {
        antlr4::ANTLRInputStream *inputStream = new antlr4::ANTLRInputStream("select * from x;");
        antlr4::Lexer
    }
    return self;
}

@end
