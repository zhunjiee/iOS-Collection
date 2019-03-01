//
//  MYTabBarController.m
//  APP框架搭建
//
//  Created by 侯宝伟 on 2019/3/1.
//  Copyright © 2019 zhunjiee. All rights reserved.
//

#import "MYTabBarController.h"
#import "MYNavigationController.h"
#import "MYManageViewController.h"
#import "MYAccountViewController.h"
#import "MYMineViewController.h"

@interface MYTabBarController ()

@end

@implementation MYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置所有子控制器
    [self setUpAllChildViewController];
    // 统一设置item的文字
    [self setUpTabBarItemAttrs];
}

/**
 *  统一设置所有item的属性
 */
- (void)setUpTabBarItemAttrs {
    // 解决ios12.1 tabBar 中的图标及文字在pop时出现位置偏移动画的bug
    [[UITabBar appearance] setTranslucent:NO];
    
    // 通过appearance统一设置TabBar控制器的文字
    UITabBarItem *item = [UITabBarItem appearance];
    
    // 正常状态颜色
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    
    // 选中状态颜色
    NSMutableDictionary *selAttrs = [NSMutableDictionary dictionary];
    selAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    [item setTitleTextAttributes:selAttrs forState:UIControlStateSelected];
}

/**
 *  设置所有子控制器
 */
- (void)setUpAllChildViewController {
    MYManageViewController *manageVC = [[MYManageViewController alloc] init];
    [self setUpOneChildViewController:manageVC withImage:@"foot_guanli_btn_n" selImage:@"foot_guanli_btn_h" title:@"管理"];
    
    MYAccountViewController *accountVC = [[MYAccountViewController alloc] init];
    [self setUpOneChildViewController:accountVC withImage:@"foot_add_btn_n" selImage:@"foot_add_btn_h" title:@"开户"];
    
    MYAccountViewController *mineVC = [[MYAccountViewController alloc] init];
    [self setUpOneChildViewController:mineVC withImage:@"foot_geren_btn_n" selImage:@"foot_geren_btn_h" title:@"我的"];
}

/**
 *  设置单个子控制器
 */
- (void)setUpOneChildViewController:(UIViewController *)vc withImage:(NSString *)image selImage:(NSString *)selImage title:(NSString *)title {
    // 设置标题
    vc.tabBarItem.title = title;
    // 显示不被渲染的图片
    vc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 创建导航控制器
    MYNavigationController *nav = [[MYNavigationController alloc] initWithRootViewController:vc];
    
    [self addChildViewController:nav];
}

@end
