//
//  ViewController.m
//  button
//
//  Created by 侯宝伟 on 15/11/4.
//  Copyright © 2015年 ZHUNJIEE. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"check_box_outline_blank_72px_1181751_easyicon.net"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"check_box_72px_1181750_easyicon.net"] forState:UIControlStateSelected];
    [button sizeToFit];
    [self.view addSubview:button];
    
    button.center = CGPointMake(100, 100);
    
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)buttonClick:(UIButton *)button{
    
    button.selected = !button.isSelected;
}

@end
