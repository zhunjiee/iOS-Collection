//
//  UIViewController+YCRootVC.m
//  ychat
//
//  Created by 孙俊 on 2017/12/16.
//  Copyright © 2017年 Sun. All rights reserved.
//

#import "UIViewController+YCRootVC.h"

@implementation UIViewController (YCRootVC)

+ (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

+ (UIViewController *)currentViewController {
    
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

@end
