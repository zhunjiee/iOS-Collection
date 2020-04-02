//
//  NSObject+YCAlert.h
//  ychat
//
//  Created by 孙俊 on 2017/12/17.
//  Copyright © 2017年 Sun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSObject (YCAlert)

/**
 弹出alertController，并且只有一个action按钮，切记只是警示作用，无事件处理
 
 @param title title
 @param message message
 @param confirmTitle confirmTitle 按钮的title
 */
+ (UIAlertController *)showAlertViewWithTitle:(NSString *)title
                                      message:(NSString *)message
                                 confirmTitle:(NSString *)confirmTitle;
/**
 弹出alertController，并且只有一个action按钮，有处理事件
 
 @param title title
 @param message message
 @param confirmTitle confirmTitle 按钮title
 @param confirmAction 按钮的点击事件处理
 */
+ (UIAlertController *)showAlertViewWithTitle:(NSString *)title
                                      message:(NSString *)message
                                 confirmTitle:(NSString *)confirmTitle
                                confirmAction:(void(^)(void))confirmAction;
/**
 弹出alertController，并且有两个个action按钮，分别有处理事件
 
 @param title title
 @param message Message
 @param confirmTitle 右边按钮的title
 @param cancelTitle 左边按钮的title
 @param confirmAction 右边按钮的点击事件
 @param cancelAction 左边按钮的点击事件
 */
+ (UIAlertController *)showAlertViewWithTitle:(NSString *)title
                                      message:(NSString *)message
                                 confirmTitle:(NSString *)confirmTitle
                                  cancelTitle:(NSString *)cancelTitle
                                confirmAction:(void(^)(void))confirmAction
                                 cancelAction:(void(^)(void))cancelAction;

/**
 * @brief 可输入的Alert
 */
+ (void)showInputAlertViewWithTitle:(NSString *)title
                            message:(NSString *)message
                        defaultText:(NSString *)defaultText
                    textfieldTarget:(id)target
                    textfieldAction:(SEL)action
                       confirmTitle:(NSString *)confirmTitle
                        cancelTitle:(NSString *)cancelTitle
                      confirmAction:(void(^)(NSString *remark))confirmAction;
@end
