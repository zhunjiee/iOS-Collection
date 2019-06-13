//
//  SVProgressHUD+HBW.m
//  SVProgressHUD使用
//
//  Created by zl on 2019/6/13.
//  Copyright © 2019 ZHUNJIEE. All rights reserved.
//

#import "SVProgressHUD+HBW.h"

@implementation SVProgressHUD (HBW)
+ (void)load {
    // 黑色背景
    [self setDefaultStyle:SVProgressHUDStyleDark];
    // 黑色蒙版
    [self setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    // 设置自动消失时间
    [self setMinimumDismissTimeInterval:1.0];
}

+ (void)showText:(nullable NSString*)text {
    [self showImage:[UIImage imageNamed:@""] status:text];
}
@end
