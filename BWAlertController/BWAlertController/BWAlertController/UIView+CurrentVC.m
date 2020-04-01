//
//  UITableViewCell+CurrentVC.m
//  MengTianXia
//
//  Created by Houge on 2019/12/16.
//  Copyright © 2019 qttx. All rights reserved.
//

#import "UIView+CurrentVC.h"


@implementation UIView (CurrentVC)

/**
 获取当前显示的控制器

 @return 显示控制器
 */

- (UIViewController *)getCurrentViewController {
    UIResponder *next = self.nextResponder;
    do {
        //判断响应者是否为视图控制器
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = next.nextResponder;
    } while (next != nil);
    
    return nil;
}

@end
