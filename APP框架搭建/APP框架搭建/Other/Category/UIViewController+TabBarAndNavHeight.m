//
//  UIViewController+TabBarAndNavHeight.m
//  APP框架搭建
//
//  Created by 侯宝伟 on 2019/3/1.
//  Copyright © 2019 zhunjiee. All rights reserved.
//

#import "UIViewController+TabBarAndNavHeight.h"

@implementation UIViewController (TabBarAndNavHeight)
- (float)getStatusbarHeight {
    //状态栏高度
    return [[UIApplication sharedApplication] statusBarFrame].size.height;
}

- (float)getNavigationbarHeight {
    //导航栏高度+状态栏高度
    return self.navigationController.navigationBar.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height;
}

- (float)getTabbarHeight {
    //Tabbar高度
    return self.tabBarController.tabBar.bounds.size.height;
}

@end
