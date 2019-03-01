//
//  MYManageViewController.m
//  APP框架搭建
//
//  Created by 侯宝伟 on 2019/3/1.
//  Copyright © 2019 zhunjiee. All rights reserved.
//

#import "MYManageViewController.h"
#import "MYSearchViewController.h"
#import "MYMessageViewController.h"

@interface MYManageViewController ()

@end

@implementation MYManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    
    self.navigationItem.title = @"渠道助手";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(searchBarDidClick) normalImage:@"nav_search_btn_h" lightImage:nil];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(messageButtonDidClick) normalImage:@"nav_xiaoxi_btn_h" lightImage:nil];
}

#pragma mark - 监控方法
- (void)searchBarDidClick {
    MYSearchViewController *searchVC = [[MYSearchViewController alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];
}
- (void)messageButtonDidClick {
    MYMessageViewController *messageVC = [[MYMessageViewController alloc] init];
    [self.navigationController pushViewController:messageVC animated:YES];
}

@end
