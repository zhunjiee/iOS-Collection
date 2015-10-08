//
//  DrawerViewController.h
//  Drawer
//
//  Created by 侯宝伟 on 15/10/6.
//  Copyright © 2015年 ZHUNJIEE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawerViewController : UIViewController

/** 左视图 */
@property (nonatomic, weak, readonly) UIView *leftView;
/** 右视图 */
@property (nonatomic, weak, readonly) UIView *rightView;
/** 主视图 */
@property (nonatomic, weak, readonly) UIView *mainView;

@end
