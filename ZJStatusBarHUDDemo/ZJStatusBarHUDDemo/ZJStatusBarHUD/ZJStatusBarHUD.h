//
//  ZJStatusBarHUD.h
//  ZJStatusBarHUDDemo
//
//  Created by 侯宝伟 on 15/10/31.
//  Copyright © 2015年 ZHUNJIEE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface ZJStatusBarHUD : NSObject
/**
 *  显示成功信息
 */
+ (void)showSuccess:(NSString *)text;

/**
 *  显示失败信息
 */
+ (void)showError:(NSString *)text;

/**
 *  显示正在加载信息
 */
+ (void)showLoading:(NSString *)text;

/**
 *  隐藏指示器
 */
+ (void)hide;
@end
