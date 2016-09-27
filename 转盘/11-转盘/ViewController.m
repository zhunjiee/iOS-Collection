//
//  ViewController.m
//  11-转盘
//
//  Created by 侯宝伟 on 15/8/22.
//  Copyright (c) 2015年 ZHUNJIEE. All rights reserved.
//

#import "ViewController.h"
#import "ZJWheelView.h"

@interface ViewController ()

@property (nonatomic, weak) ZJWheelView *wheel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 加载xib到控制器窗口
    
    ZJWheelView *wheel = [ZJWheelView wheelView];
    
    wheel.center = self.view.center;
    
    [self.view addSubview:wheel];
    
    _wheel = wheel;
    
}



@end
