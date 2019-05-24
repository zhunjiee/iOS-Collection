//
//  VerticalButton.m
//  交换按钮图片跟文字位置
//
//  Created by zl on 2019/5/24.
//  Copyright © 2019 ZHUNJIEE. All rights reserved.
//

#import "VerticalButton.h"
#import "UIView+Extension.h"

@implementation VerticalButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 调整图片位置
    self.imageView.y = 0;
    self.imageView.centerX = self.width * 0.5;
    
    // 调整文字位置
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.imageView.height;
}

// 去除高亮效果
- (void)setHighlighted:(BOOL)highlighted {
}

@end
