//
//  ZJButton.m
//  交换按钮图片跟文字位置
//
//  Created by 侯宝伟 on 15/10/31.
//  Copyright © 2015年 ZHUNJIEE. All rights reserved.
//

#import "ZJButton.h"
#import "UIView+Extension.h"

@implementation ZJButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageW = self.height;
    CGFloat imageX = self.width - imageW;
    CGFloat imageY = 0;
    CGFloat imageH = imageW;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    return CGRectMake(0, 0, self.width - self.height, self.height);
}

@end
