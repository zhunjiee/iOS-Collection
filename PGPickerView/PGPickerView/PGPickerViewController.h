//
//  PGPickerViewController.h
//  PGPickerView
//
//  Created by zl on 2019/6/1.
//  Copyright © 2019 ZHUNJIEE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PGPickerView.h>

NS_ASSUME_NONNULL_BEGIN

@interface PGPickerViewController : UIViewController
@property (nonatomic, strong) PGPickerView *pickerView;

@property (nonatomic, assign) BOOL isShadeBackground;   // 键盘上面的空白部分是否显示为黑色背景

@property (nonatomic, weak) NSString *headerTitle;
@property (nonatomic, strong) UIColor *headerViewBackgroundColor;
@property (nonatomic, assign) CGFloat headerHeight;

// 数据源,请传二维数组
@property (strong, nonatomic) NSMutableArray *dataSourceArray;

@property (nonatomic, copy) void (^cancelButtonMonitor)(void);
@property (nonatomic, copy) void (^confirmButtonMonitor)(NSString *selString);
@end

NS_ASSUME_NONNULL_END
