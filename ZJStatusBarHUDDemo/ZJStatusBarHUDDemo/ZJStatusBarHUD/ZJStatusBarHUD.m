//
//  ZJStatusBarHUD.m
//  ZJStatusBarHUDDemo
//
//  Created by 侯宝伟 on 15/10/31.
//  Copyright © 2015年 ZHUNJIEE. All rights reserved.
//

#import "ZJStatusBarHUD.h"

@implementation ZJStatusBarHUD

static UIWindow *window_;
static NSTimer *timer_;

/** window出现和隐藏需要的时间 */
static CGFloat const ZJDuration = 0.25;
/** window隔多久后自动隐藏 */
static CGFloat const ZJTimeInterval = 2.0;

#pragma mark - 私有方法
+ (void)setupText:(NSString *)text image:(UIImage *)image{
    
    // 创建window
    window_ = [[UIWindow alloc] init];
    CGRect windowFrame = [UIApplication sharedApplication].statusBarFrame;
    window_.frame = windowFrame;
    window_.windowLevel = UIWindowLevelAlert;
    window_.hidden = NO;
    window_.backgroundColor = [UIColor blackColor];
    
    // 添加按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = window_.frame;
    [window_ addSubview:button];
    
    // 设置按钮数据
    [button setTitle:text forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateNormal];
    
    // 其他设置
//    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    // window出现动画
    CGRect beginWindowFrame = windowFrame;
    beginWindowFrame.origin.y = - beginWindowFrame.size.height;
    window_.frame = beginWindowFrame;
    
    [UIView animateWithDuration:ZJDuration animations:^{
        window_.frame = windowFrame;
    }];
    

    // 停止上次定时器
    [timer_ invalidate];
    
    // 开启定时器
    timer_ = [NSTimer scheduledTimerWithTimeInterval:ZJTimeInterval target:self selector:@selector(hide) userInfo:nil repeats:NO];
    

}


+(void)showSuccess:(NSString *)text{
    [self setupText:text image:[UIImage imageNamed:@"success"]];
}

+ (void)showError:(NSString *)text{
    [self setupText:text image:[UIImage imageNamed:@"error"]];
}

+ (void)hide{
    
    [UIView animateWithDuration:ZJDuration animations:^{
        CGRect beginWindowFrame = window_.frame;
        beginWindowFrame.origin.y = - beginWindowFrame.size.height;
        window_.frame = beginWindowFrame;
    }completion:^(BOOL finished) {
        window_ = nil;
    }];
}
@end
