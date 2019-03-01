//
//  UIBarButtonItem+MYExtension.h
//  APP框架搭建
//
//  Created by 侯宝伟 on 2019/3/1.
//  Copyright © 2019 zhunjiee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (MYExtension)
/**
 *  自定义导航栏的barButtonItem按钮
 *
 *  @param target     目标对象
 *  @param action     执行方法
 *  @param image      普通图片
 *  @param lightImage 高亮图片
 *
 *  @return 自定义按钮
 */
+ (instancetype)itemWithTarget:(nonnull id)target action:(nonnull SEL)action normalImage:(nullable NSString *)image lightImage:(nullable NSString *)lightImage;

+ (instancetype)itemWithTarget:(nonnull id)target action:(nonnull SEL)action normalImage:(nullable NSString *)image selImage:(nullable NSString *)selImage;
@end

NS_ASSUME_NONNULL_END
