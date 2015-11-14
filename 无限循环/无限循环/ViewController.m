//
//  ViewController.m
//  无限循环
//
//  Created by 侯宝伟 on 15/11/12.
//  Copyright © 2015年 ZHUNJIEE. All rights reserved.
//

#import "ViewController.h"
#import "ZJInfiniteScrollView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    ZJInfiniteScrollView *scrollView = [[ZJInfiniteScrollView alloc] init];
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
    //    scrollView.scrollDirectionPortrait = YES;
    [self.view addSubview:scrollView];
}

@end
