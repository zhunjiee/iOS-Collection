//
//  UIImage+CircleImage.h
//  03-微博个人详情页
//
//  Created by 侯宝伟 on 13/12/2.
//  Copyright © 2013年 ZHUNJIEE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CircleImage)
// 根据颜色生成一张尺寸为1*1的相同颜色图片
+ (UIImage *)imageWithColor:(UIColor *)color;
@end
