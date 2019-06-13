//
//  ViewController.m
//  SVProgressHUD使用
//
//  Created by zl on 2019/6/13.
//  Copyright © 2019 ZHUNJIEE. All rights reserved.
//

#import "ViewController.h"
#import "SVProgressHUD+HBW.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (IBAction)buttonDidClick:(UIButton *)sender {
    [SVProgressHUD showText:@"正在加载中..."];
}

@end
