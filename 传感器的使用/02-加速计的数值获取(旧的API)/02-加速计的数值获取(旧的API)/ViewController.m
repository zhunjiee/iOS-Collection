//
//  ViewController.m
//  02-加速计的数值获取(旧的API)
//
//  Created by xiaomage on 15/10/30.
//  Copyright © 2015年 xiaomage. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIAccelerometerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.获取UIAccelerometer的单例
    UIAccelerometer *accelerometer = [UIAccelerometer sharedAccelerometer];
    
    // 2.设置代理
    accelerometer.delegate = self;
    
    // 3.设置采样间隔
    accelerometer.updateInterval = 1.0;
}

#pragma mark - 实现UIAccelerometer的代理方法
- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
    NSLog(@"x:%f y:%f z:%f", acceleration.x, acceleration.y, acceleration.z);
}

@end
