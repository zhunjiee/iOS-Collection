//
//  ViewController.m
//  PGPickerView
//
//  Created by zl on 2019/6/1.
//  Copyright © 2019 ZHUNJIEE. All rights reserved.
//

#import "ViewController.h"
#import "PGPickerViewController.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    PGPickerViewController *vc = [[PGPickerViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}
- (IBAction)buttonDidClick:(UIButton *)sender {
    PGPickerViewController *vc = [[PGPickerViewController alloc] init];
    vc.isShadeBackground = YES;
    vc.headerTitle = @"选择车型";
    
    NSArray *datas1 = @[@"北京", @"上海", @"天津", @"重庆", @"四川", @"贵州", @"云南", @"西藏", @"河南", @"湖北"];
    vc.dataSourceArray = [NSMutableArray arrayWithObjects:datas1, nil];

    [self presentViewController:vc animated:YES completion:nil];
    
    // 设置数据
    vc.confirmButtonMonitor = ^(NSString *selString) {
        [sender setTitle:selString forState:UIControlStateNormal];
    };
}


@end
