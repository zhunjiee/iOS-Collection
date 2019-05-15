//
//  UIImage+Circle.m
//  圆角图片
//
//  Created by 侯宝伟 on 2019/5/15.
//  Copyright © 2019 ZHUNJIEE. All rights reserved.
//

#import "UIImage+Circle.h"

@implementation UIImage (Circle)
- (UIImage *)circleImage {
    //  1. 开启一个基于位图的图形上下文
    UIGraphicsBeginImageContext(self.size);
    
    // 2. 获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 3. 画圆
    CGRect rect = {CGPointZero, self.size};
    CGContextAddEllipseInRect(context, rect);
    
    // 4. 剪裁
    CGContextClip(context);
    
    // 5. 将图片画到圆上
    [self drawInRect:rect];
    
    // 6. 取出画好的图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 7. 关闭e位图上下文
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)clipImageWithCornerRadius:(CGFloat)radius {
    UIGraphicsBeginImageContext(self.size);
    CGRect rect = {CGPointZero, self.size};
    // 画圆角并剪裁
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius] addClip];
    // 将图片画到圆上
    [self drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
