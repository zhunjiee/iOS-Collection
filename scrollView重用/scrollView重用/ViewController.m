//
//  ViewController.m
//  scrollView重用
//
//  Created by 侯宝伟 on 15/11/14.
//  Copyright © 2015年 ZHUNJIEE. All rights reserved.
//

#import "ViewController.h"
#import "ZJScrollView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ZJScrollView *scrollView = [[ZJScrollView alloc] init];
    scrollView.frame = CGRectMake(30, 50, 300, 130);
    scrollView.imagesArray = @[
                               [UIImage imageNamed:@"img_00"],
                               [UIImage imageNamed:@"img_01"],
                               [UIImage imageNamed:@"img_02"],
                               [UIImage imageNamed:@"img_03"],
                               [UIImage imageNamed:@"img_04"]
                               ];
    scrollView.pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    scrollView.pageControl.pageIndicatorTintColor = [UIColor grayColor];

    [self.view addSubview:scrollView];
}

@end
