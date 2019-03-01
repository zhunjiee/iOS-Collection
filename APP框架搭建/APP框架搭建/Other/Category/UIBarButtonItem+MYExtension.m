//
//  UIBarButtonItem+MYExtension.m
//  APP框架搭建
//
//  Created by 侯宝伟 on 2019/3/1.
//  Copyright © 2019 zhunjiee. All rights reserved.
//

#import "UIBarButtonItem+MYExtension.h"

@implementation UIBarButtonItem (MYExtension)
+ (instancetype)itemWithTarget:(nonnull id)target action:(nonnull SEL)action normalImage:(nullable NSString *)image lightImage:(nullable NSString *)lightImage {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (image.length != 0) {
        [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    }
    if (lightImage.length != 0) {
        [button setImage:[UIImage imageNamed:lightImage] forState:UIControlStateHighlighted];
    }
    
    // 一定要设置尺寸啊亲
    [button sizeToFit];
    
    // 监听按钮点击
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[self alloc] initWithCustomView:button];
}

+ (instancetype)itemWithTarget:(nonnull id)target action:(nonnull SEL)action normalImage:(nullable NSString *)image selImage:(nullable NSString *)selImage {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (image.length != 0) {
        [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    }
    if (selImage.length != 0) {
        [button setImage:[UIImage imageNamed:selImage] forState:UIControlStateSelected];
    }
    
    // 一定要设置尺寸啊亲
    [button sizeToFit];
    
    // 监听按钮点击
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[self alloc] initWithCustomView:button];
}

@end
