//
//  UIView+MYExtension.m
//  APP框架搭建
//
//  Created by 侯宝伟 on 2019/3/1.
//  Copyright © 2019 zhunjiee. All rights reserved.
//

#import "UIView+MYExtension.h"

@implementation UIView (MYExtension)
/**
 *  从xib中加载控件
 */
+ (instancetype)viewFromXib{
    // 从xib加载控件
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}


/* 不能直接修改结构体成员的属性 */
- (void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
- (CGFloat)x{
    return self.frame.origin.x;
}


- (void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
- (CGFloat)y{
    return self.frame.origin.y;
}

-(void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
- (CGFloat)width{
    return self.frame.size.width;
}

-(void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
- (CGFloat)height{
    return self.frame.size.height;
}


- (void)setCenterX:(CGFloat)centerX{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}
- (CGFloat)centerX{
    return self.center.x;
}


- (void)setCenterY:(CGFloat)centerY{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}
- (CGFloat)centerY{
    return self.center.y;
}

- (void)setTop:(CGFloat)top{
    self.y = top;
}
- (CGFloat)top{
    return CGRectGetMinY(self.frame);
}

- (void)setBottom:(CGFloat)bottom{
    CGRect tempFrame = self.frame;
    tempFrame.origin.y = bottom - tempFrame.size.height;
    self.frame = tempFrame;
}
- (CGFloat)bottom{
    return CGRectGetMaxY(self.frame);
}

- (void)setLeft:(CGFloat)left{
    self.x = left;
}
- (CGFloat)left{
    return CGRectGetMinX(self.frame);
}

- (void)setRight:(CGFloat)right{
    CGRect tempFrame = self.frame;
    tempFrame.origin.x = right - tempFrame.size.width;
    self.frame = tempFrame;
}
- (CGFloat)right{
    return CGRectGetMaxX(self.frame);
}

@end
