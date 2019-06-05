//
//  PGPickerViewController.m
//  PGPickerView
//
//  Created by zl on 2019/6/1.
//  Copyright © 2019 ZHUNJIEE. All rights reserved.
//

#import "PGPickerViewController.h"
#import "PGPickerViewHeaderView.h"

@interface PGPickerViewController ()<PGPickerViewDataSource, PGPickerViewDelegate>
@property (nonatomic, weak) UIView *contentView;    // 存headerView与pickerView
@property (weak, nonatomic) PGPickerViewHeaderView *headerView; // 头部确认/取消按钮视图
@property (nonatomic, weak) UIView *dismissView;    // 蒙版遮罩
@property (copy, nonatomic) NSString *selectedString;   // 选中信息
@end

@implementation PGPickerViewController
#pragma mark - 初始化
- (instancetype)init {
    if (self = [super init]) {
        // 保证present到PGPickerViewController控制器的时候上一个控制器不消失
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    [self setupDismissViewTapHandler];
    [self headerViewButtonHandler];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.dismissView.frame = self.view.bounds;
    self.contentView.backgroundColor = self.pickerView.backgroundColor;
    [self setupPickerStyle];
    [self.view bringSubviewToFront:self.contentView];
}

/**
 创建pickerView并设置frame
 */
- (void)setupPickerStyle {
    CGFloat bottom = 0;
    if (@available(iOS 11.0, *)) {
        bottom = self.view.safeAreaInsets.bottom;
    }
    CGFloat rowHeight = 44;
    CGFloat headerViewHeight = self.headerHeight;
    CGFloat contentViewHeight = rowHeight * 5 + headerViewHeight;
    
    CGFloat pickerViewHeight = contentViewHeight - headerViewHeight - bottom;
    CGRect contentViewFrame = CGRectMake(0,
                                         self.view.bounds.size.height - contentViewHeight,
                                         self.view.bounds.size.width,
                                         contentViewHeight);
    CGRect headerViewFrame = CGRectMake(0, 0, self.view.bounds.size.width, headerViewHeight);
    CGRect pickerViewFrame = CGRectMake(0,
                                        CGRectGetMaxY(headerViewFrame),
                                        self.view.bounds.size.width,
                                        pickerViewHeight);
    
    self.contentView.frame = CGRectMake(0,
                                        self.view.bounds.size.height,
                                        self.view.bounds.size.width,
                                        contentViewHeight);
    self.headerView.frame = headerViewFrame;
    self.pickerView.frame = pickerViewFrame;
    self.headerView.backgroundColor = self.headerViewBackgroundColor;
    [UIView animateWithDuration:0.2 animations:^{
        if (self.isShadeBackground) {
            self.dismissView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        }
        self.contentView.frame = contentViewFrame;
        self.headerView.frame = headerViewFrame;
        self.pickerView.frame = pickerViewFrame;
    }];
}

#pragma mark - 点击事件
/**
 设置点击遮罩视图事件
 */
- (void)setupDismissViewTapHandler {
    self.dismissView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissViewTapMonitor)];
    [self.dismissView addGestureRecognizer:tap];
}
/**
 点击遮罩视图退出键盘
 */
- (void)dismissViewTapMonitor {
    __weak typeof(self) weakSelf = self;
    
    [self dismissViewController];
    
    if (self.cancelButtonMonitor) {
        weakSelf.cancelButtonMonitor();
    }
}

/**
 头部视图按钮点击事件
 */
- (void)headerViewButtonHandler {
    __weak typeof(self) weakSelf = self;
    
    // 取消按钮点击事件
    self.headerView.cancelButtonHandlerBlock = ^{
        [weakSelf dismissViewController];
        
        if (weakSelf.cancelButtonMonitor) {
            weakSelf.cancelButtonMonitor();
        }
    };
    // 确认按钮点击事件
    self.headerView.confirmButtonHandlerBlock =^{
        [weakSelf dismissViewController];
        
        // 默认选中第一个
        if (weakSelf.dataSourceArray.count != 0 && weakSelf.selectedString.length == 0) {
            weakSelf.selectedString = weakSelf.dataSourceArray[0][0];
        }
        if (weakSelf.confirmButtonMonitor) {
            weakSelf.confirmButtonMonitor(weakSelf.selectedString);
        }
    };
}


/**
 退出picker界面
 */
- (void)dismissViewController {
    CGRect contentViewFrame = self.contentView.frame;
    contentViewFrame.origin.y = self.view.bounds.size.height;
    [UIView animateWithDuration:0.2 animations:^{
        self.dismissView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
        self.contentView.frame = contentViewFrame;
    }completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:false completion:nil];
    }];
}



#pragma UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(PGPickerView *)pickerView {
    return self.dataSourceArray.count;
}

- (NSInteger)pickerView:(PGPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSArray *compArray = self.dataSourceArray[component];
    return compArray.count;
}
#pragma UIPickerViewDelegate
- (nullable NSString *)pickerView:(PGPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSArray *compArray = self.dataSourceArray[component];
    return compArray[row];
}

- (void)pickerView:(PGPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.selectedString = self.dataSourceArray[component][row];
    NSLog(@"row = %ld component = %ld", row, component);
    NSLog(@"%@", self.dataSourceArray[component][row]);
}

#pragma mark - setter
- (void)setIsShadeBackground:(BOOL)isShadeBackground {
    _isShadeBackground = isShadeBackground;
    if (isShadeBackground) {
        self.dismissView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    }else {
        self.dismissView.backgroundColor = [UIColor clearColor];
    }
}

- (void)setHeaderTitle:(NSString *)headerTitle {
    _headerTitle = headerTitle;
    self.headerView.titleLabelText = _headerTitle;
}

#pragma mark - 懒加载
- (UIView *)contentView {
    if (!_contentView) {
        UIView *view = [[UIView alloc] init];
        [self.view addSubview:view];
        _contentView =view;
    }
    return _contentView;
}

- (PGPickerView *)pickerView {
    if (!_pickerView) {
        PGPickerView *pickerView = [[PGPickerView alloc] init];
        pickerView.backgroundColor = [UIColor whiteColor];
        pickerView.delegate = self;
        pickerView.dataSource = self;
        pickerView.type = PGPickerViewLineTypeline;
        pickerView.textColorOfSelectedRow = [UIColor colorWithRed:140/255.0 green:43/255.0 blue:44/255.0 alpha:1.0];
//        pickerView.lineBackgroundColor = [UIColor colorWithRed:140/255.0 green:43/255.0 blue:44/255.0 alpha:1.0];
        [self.contentView addSubview:pickerView];
        _pickerView = pickerView;
    }
    return _pickerView;
}

- (PGPickerViewHeaderView *)headerView {
    if (!_headerView) {
        PGPickerViewHeaderView *headerView = [[PGPickerViewHeaderView alloc] init];
        headerView.titleLabelText = self.headerTitle;
        [self.contentView addSubview:headerView];
        _headerView = headerView;
    }
    return _headerView;
}

- (UIView *)dismissView {
    if (!_dismissView) {
        UIView *view = [[UIView alloc]init];
        [self.view addSubview:view];
        _dismissView = view;
    }
    return _dismissView;
}

- (CGFloat)headerHeight {
    if (!_headerHeight) {
        _headerHeight = 60;
    }
    return _headerHeight;
}
@end
