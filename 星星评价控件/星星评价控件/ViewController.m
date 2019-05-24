//
//  ViewController.m
//  星星评价控件
//
//  Created by zl on 2019/5/24.
//  Copyright © 2019 ZHUNJIEE. All rights reserved.
//

#import "ViewController.h"
#import "StarRateView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    StarRateView *starView = [[StarRateView alloc] initWithFrame:CGRectMake(0, 100, 200, 40) finish:^(CGFloat currentScore) {
        NSLog(@"%f", currentScore);
    }];
    [self.view addSubview:starView];
}


@end
