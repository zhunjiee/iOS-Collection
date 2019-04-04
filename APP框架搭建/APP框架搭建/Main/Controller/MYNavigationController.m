//
//  MYNavigationController.m
//  APP框架搭建
//
//  Created by 侯宝伟 on 2019/3/1.
//  Copyright © 2019 zhunjiee. All rights reserved.
//

#import "MYNavigationController.h"

@interface MYNavigationController () <UIGestureRecognizerDelegate>

@end

@implementation MYNavigationController
+ (void)initialize {
    // 去除导航栏的毛玻璃效果
    UINavigationBar *bar = [UINavigationBar appearance];
    // 方式一：设置导航栏背景图片
//    [bar setBackgroundImage:[UIImage imageNamed:@"nav-background"] forBarMetrics:UIBarMetricsDefault];
    // 方式二：设置背景色
    bar.translucent = NO;
    
    // 设置标题文字
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
    [bar setTitleTextAttributes:attrs];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.interactivePopGestureRecognizer.delegate = self;
}


/**
 重写push方法实现页面跳转后的各种设置

 @param viewController 目的控制器
 @param animated 是否a带有动画效果
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 子页面隐藏底部TabBar按钮
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        // 自定义子页面的返回按钮样式
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setImage:[UIImage imageNamed:@"nav_back_btn_n"] forState:UIControlStateNormal];
        [backBtn setImage:[UIImage imageNamed:@"nav_back_btn_n"] forState:UIControlStateHighlighted];
//        [backBtn setTitle:@"返回" forState:UIControlStateNormal];
//        [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [backBtn setTitleColor:MYColor(251, 32, 37) forState:UIControlStateHighlighted];
//        backBtn.backgroundColor = [UIColor redColor];
        backBtn.contentEdgeInsets = UIEdgeInsetsMake(10, 0, 10, 30);
        [backBtn sizeToFit];
        [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)goBack {
    [self popViewControllerAnimated:YES];
}

#pragma mark - UIGestureRecognizerDelegate
// 启用手势返回
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return self.childViewControllers.count > 1;
}

@end
