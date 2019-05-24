//
//  UIView+Extension.m
//  交换按钮图片跟文字位置
//
//  Created by 侯宝伟 on 15/10/31.
//  Copyright © 2015年 ZHUNJIEE. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)
- (void)setWidth:(CGFloat)width{
    CGRect tempFrame = self.frame;
    tempFrame.size.width = width;
    self.frame = tempFrame;
}
- (CGFloat)width{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height{
    CGRect tempFrame = self.frame;
    tempFrame.size.height = height;
    self.frame = tempFrame;
}
- (CGFloat)height{
    return self.frame.size.height;
}

- (void)setX:(CGFloat)x{
    CGRect tempFrame = self.frame;
    tempFrame.origin.x = x;
    self.frame = tempFrame;
}
- (CGFloat)x{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y{
    CGRect tempFrame = self.frame;
    tempFrame.origin.y = y;
    self.frame = tempFrame;
}
- (CGFloat)y{
    return self.frame.origin.y;
}
@end
