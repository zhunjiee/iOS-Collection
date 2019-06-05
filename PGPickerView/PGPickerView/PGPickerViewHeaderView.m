//
//  PGPickerViewHeaderView.m
//  PGPickerView
//
//  Created by zl on 2019/6/1.
//  Copyright © 2019 ZHUNJIEE. All rights reserved.
//

#import "PGPickerViewHeaderView.h"

@interface PGPickerViewHeaderView ()
@property (nonatomic, weak) UIView *lineView;
@property (nonatomic, weak) UIButton *cancelButton;
@property (nonatomic, weak) UIButton *confirmButton;
@property (nonatomic, weak) UILabel *titleLabel;
@end

@implementation PGPickerViewHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupButtonAndTitle];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat lineViewHeight = 0.5;
    self.lineView.frame = CGRectMake(0, 0, self.bounds.size.width, lineViewHeight);
    CGFloat buttonWidth = 50;
    CGFloat buttonHeight = self.bounds.size.height;
    self.cancelButton.frame = CGRectMake(0, 0, buttonWidth, buttonHeight);
    self.confirmButton.frame = CGRectMake(self.bounds.size.width - buttonWidth, 0, buttonWidth, buttonHeight);
    self.titleLabel.frame = CGRectMake(buttonWidth, 0, self.bounds.size.width - buttonWidth * 2, buttonHeight);
}

/**
 创建 确定/取消 按钮, 标题
 */
- (void)setupButtonAndTitle {
    // 取消按钮
    self.cancelButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.cancelButton setTitleColor:[UIColor colorWithRed:155/255.0 green:155/255.0 blue:155/255.0 alpha:1.0] forState:UIControlStateNormal];
    [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelButton addTarget:self action:@selector(cancelButtonHandler) forControlEvents:UIControlEventTouchUpInside];
    
    // 确认按钮
    self.confirmButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.confirmButton setTitleColor:[UIColor colorWithRed:216/255.0 green:184/255.0 blue:101/255.0 alpha:1.0] forState:UIControlStateNormal];
    [self.confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    [self.confirmButton addTarget:self action:@selector(confirmButtonHandler) forControlEvents:UIControlEventTouchUpInside];
    
    self.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)setTitleLabelText:(NSString *)titleLabelText {
    self.titleLabel.text = titleLabelText;
}

/**
 点击取消按钮的回调
 */
- (void)cancelButtonHandler {
    if (self.cancelButtonHandlerBlock) {
        self.cancelButtonHandlerBlock();
    }
}

/**
 点击确认按钮的回调
 */
- (void)confirmButtonHandler {
    if (self.confirmButtonHandlerBlock) {
        self.confirmButtonHandlerBlock();
    }
}

#pragma mark - 懒加载
- (UIView *)lineView {
    if (!_lineView) {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:view];
        _lineView = view;
    }
    return _lineView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc]init];
        [self addSubview:label];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont boldSystemFontOfSize:17];
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UIButton *)confirmButton {
    if (!_confirmButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:button];
        _confirmButton = button;
    }
    return _confirmButton;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:button];
        _cancelButton = button;
    }
    return _cancelButton;
}
@end
