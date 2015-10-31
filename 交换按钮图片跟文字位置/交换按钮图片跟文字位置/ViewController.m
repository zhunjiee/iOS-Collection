//
//  ViewController.m
//  交换按钮图片跟文字位置
//
//  Created by 侯宝伟 on 15/10/31.
//  Copyright © 2015年 ZHUNJIEE. All rights reserved.
//

#import "ViewController.h"
#import "ZJButton.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNormalButton];
    
    [self setupExchangeButton];
    
}

- (void)setupNormalButton{
    // 正常按钮图片在左边，文字在右边
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"我是正常按钮" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [button setImage:[UIImage imageNamed:@"success"] forState:UIControlStateNormal];
    [button sizeToFit];
    button.center = CGPointMake(100, 100);
    [self.view addSubview:button];
}

- (void)setupExchangeButton{
    // 正常按钮图片在左边，文字在右边
    ZJButton *button = [ZJButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"我是交换位置按钮" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [button setImage:[UIImage imageNamed:@"error"] forState:UIControlStateNormal];
    [button sizeToFit];
    button.center = CGPointMake(200, 200);
    [self.view addSubview:button];
}

@end
