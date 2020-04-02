//
//  NSObject+YCAlert.m
//  ychat
//
//  Created by 孙俊 on 2017/12/17.
//  Copyright © 2017年 Sun. All rights reserved.
//

#import "NSObject+YCAlert.h"
#import "UIViewController+YCRootVC.h"

@implementation NSObject (YCAlert)

+ (UIAlertController *)showAlertViewWithTitle:(NSString *)title message:(NSString *)message confirmTitle:(NSString *)confirmTitle {
    
    return [self showAlertViewWithTitle:title message:message confirmTitle:confirmTitle confirmAction:nil];
}
+ (UIAlertController *)showAlertViewWithTitle:(NSString *)title message:(NSString *)message confirmTitle:(NSString *)confirmTitle confirmAction:(void(^)(void))confirmAction {
    
    return [self showAlertViewWithTitle:title message:message confirmTitle:confirmTitle cancelTitle:nil confirmAction:confirmAction cancelAction:NULL];
}
+ (UIAlertController *)showAlertViewWithTitle:(NSString *)title message:(NSString *)message confirmTitle:(NSString *)confirmTitle cancelTitle:(NSString *)cancelTitle confirmAction:(void(^)(void))confirmAction cancelAction:(void(^)(void))cancelAction {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    /// 左边按钮
    if(cancelTitle.length > 0){
        UIAlertAction *cancel= [UIAlertAction actionWithTitle:cancelTitle?cancelTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { !cancelAction?:cancelAction(); }];
        [alertController addAction:cancel];
    }
    
    if (confirmTitle.length > 0) {
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:confirmTitle?confirmTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { !confirmAction?:confirmAction();}];
        [alertController addAction:confirm];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIViewController currentViewController] presentViewController:alertController animated:YES completion:NULL];
    });
    return alertController;
}

- (void)showInputAlertViewWithTitle:(NSString *)title message:(NSString *)message defaultText:(NSString *)defaultText textfieldTarget:(id)target textfieldAction:(SEL)action confirmTitle:(NSString *)confirmTitle cancelTitle:(NSString *)cancelTitle confirmAction:(void(^)(NSString *remark))confirmAction {
    {
        //提示框添加文本输入框
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                       message:message
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action) {
                                                             //响应事件
                                                             //得到文本信息
                                                             UITextField *userNameTextField = alert.textFields.firstObject;
                                                             

                                                             
                                                             !confirmAction?:confirmAction(userNameTextField.text);
                                                         }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel
                                                             handler:^(UIAlertAction * action) {
                                                                 //响应事件
                                                                 NSLog(@"action = %@", alert.textFields);
                                                             }];
        [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.placeholder = @"收款方可见，最多10个字";
            textField.text = defaultText;
            textField.clearButtonMode = UITextFieldViewModeWhileEditing;
            [textField addTarget:target action:action forControlEvents:UIControlEventEditingChanged];
        }];
        
        [alert addAction:cancelAction];
        [alert addAction:okAction];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[UIViewController currentViewController] presentViewController:alert animated:YES completion:NULL];
        });
    }
}

@end
