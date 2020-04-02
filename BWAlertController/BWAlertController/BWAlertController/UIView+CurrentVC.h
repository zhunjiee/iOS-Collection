//
//  UITableViewCell+CurrentVC.h
//  MengTianXia
//
//  Created by Houge on 2019/12/16.
//  Copyright © 2019 qttx. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CurrentVC)

/// 获取当前视图所在的控制器
- (UIViewController *)getCurrentViewController;

@end

NS_ASSUME_NONNULL_END
