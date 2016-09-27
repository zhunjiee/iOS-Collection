//
//  ZJWheelView.m
//  11-转盘
//
//  Created by 侯宝伟 on 15/8/22.
//  Copyright (c) 2015年 ZHUNJIEE. All rights reserved.
//

#import "ZJWheelView.h"

@interface ZJWheelView ()

@property (weak, nonatomic) IBOutlet UIImageView *rotationView;
@property (nonatomic, weak) UIButton *selButton;
@end

@implementation ZJWheelView

+ (instancetype)wheelView{
    return [[NSBundle mainBundle] loadNibNamed:@"ZJWheelView" owner:nil options:nil].lastObject;
}


// 通过xib或storyboard加载时调用
- (void)awakeFromNib{
    _rotationView.userInteractionEnabled = YES;
    
    // 加载按钮
    for (int i = 0; i < 12; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [self setUpBtn:button index:i];
        
        // 监听点击事件
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
        
        [_rotationView addSubview:button];
    }

    
    // 加载添加到按钮上的星座图片
    
    
    // 计算裁剪范围
    
    // 裁剪图片
//    CGImageCreateWithImageInRect(<#CGImageRef image#>, <#CGRect rect#>)
    
    
    // 设置按钮的图片
}

// 设置转盘的12个按钮
- (void)setUpBtn:(UIButton *)button index:(NSInteger)i{
    // 锚点
    button.layer.anchorPoint = CGPointMake(0.5, 1);
    // 位置,默认是中心点,由anchorPoint决定
    button.layer.position = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
    // 尺寸
    button.bounds = CGRectMake(0, 0, 68, 143);
    [button setBackgroundImage:[UIImage imageNamed:@"LuckyRototeSelected"] forState:UIControlStateSelected];
    
    CGFloat angle = (i * 30) / 180.0 * M_PI;
    // 旋转按钮
    button.layer.transform = CATransform3DMakeRotation(angle, 0, 0, 1);
}




- (void)buttonClick:(UIButton *)button{
    // 取消上次选中按钮
    _selButton.selected = NO;
    // 选中按钮
    button.selected = YES;
    
    // 记录下当前选中的按钮
    _selButton = button;
}

@end
