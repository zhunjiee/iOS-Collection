//
//  ViewController.m
//  05-摇一摇
//
//  Created by xiaomage on 15/10/30.
//  Copyright © 2015年 xiaomage. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSLog(@"开始摇一摇");
}

@end
