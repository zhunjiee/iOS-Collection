//
//  UIView+RoundedCorners.h
//  MengTianXia
//
//  Created by zl on 2019/8/9.
//  Copyright © 2019 qttx. All rights reserved.
//
// 可定制剪裁单个圆角的分类

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (RoundedCorners)

/**
 剪裁圆角(只能剪裁,不能改变位置和大小)

 @param corners 需要剪裁的角      可同时取多个值 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 @param radii 圆角大小(半径)
 */
- (void)clipRoundedCorners:(UIRectCorner)corners withRadii:(CGSize)radii;

/**
 剪裁圆角, 并能改变view的位置及大小

 @param corners 需要剪裁的角
 @param radii 剪裁圆角大小
 @param rect 设置view的位置及大小
 */
- (void)clipRoundedCorners:(UIRectCorner)corners withRadii:(CGSize)radii withRect:(CGRect)rect;

@end

NS_ASSUME_NONNULL_END
