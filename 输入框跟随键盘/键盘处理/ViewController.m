//
//  ViewController.m
//  键盘处理
//
//  Created by 侯宝伟 on 15/10/27.
//  Copyright © 2015年 ZHUNJIEE. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottom;
@property (weak, nonatomic) IBOutlet UIView *inputView;
/** 监听者 */
//@property (nonatomic, strong) id observer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    // 注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
/*
    self.observer = [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillChangeFrameNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        // 获得键盘的frame
        CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        // 修改工具条底部约束
        self.bottom.constant = [UIScreen mainScreen].bounds.size.height - frame.origin.y;
        
        // 获得键盘弹出或隐藏时间
        CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        
        // 添加动画
        [UIView animateWithDuration:duration animations:^{
            [self.view layoutIfNeeded];
        }];

    }];
 */
}

/**
 *  通知一定要手动移除
 */
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
//    [[NSNotificationCenter defaultCenter] removeObserver:self.observer];
}


#pragma mark - 监听方法
/**
 *  键盘工具条处理：constant方式
 */
- (void)keyboardWillChangeFrame:(NSNotification *)note{
    // 获得键盘的frame
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 修改工具条底部约束
    self.bottom.constant = [UIScreen mainScreen].bounds.size.height - frame.origin.y;
    
    // 获得键盘弹出或隐藏时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 添加动画
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

/**
 *  键盘工具条处理：transform方式
 */
- (void)keyboardWillChangeFrame1:(NSNotification *)note{
    // 获得键盘
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 计算键盘移动的范围
    CGFloat transformY = frame.origin.y - [UIScreen mainScreen].bounds.size.height;
    
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 添加动画
    [UIView animateWithDuration:duration animations:^{
        self.inputView.transform = CGAffineTransformMakeTranslation(0, transformY);
    }];
}



/**
 *  点击屏幕任意位置退出键盘
 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
@end
