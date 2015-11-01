//
//  ViewController.m
//  04-陀螺仪信息的获取
//
//  Created by xiaomage on 15/10/30.
//  Copyright © 2015年 xiaomage. All rights reserved.
//

#import "ViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface ViewController ()

/** 运动管理者 */
@property (nonatomic, strong) CMMotionManager *mgr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // pull方式
    // 1.判断陀螺仪是否可用
    if (!self.mgr.isGyroAvailable) {
        NSLog(@"陀螺仪不可用,请更换手机");
        return;
    }
    
    // 2.开始采样
    [self.mgr startGyroUpdates];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CMRotationRate rate = self.mgr.gyroData.rotationRate;
    NSLog(@"x:%f y:%f z:%f", rate.x, rate.y ,rate.z);
}

- (void)pushGyro
{
    // push方式
    // 1.判断陀螺仪是否可用
    if (!self.mgr.isGyroAvailable) {
        NSLog(@"陀螺仪不可用,请更换手机");
        return;
    }
    
    // 2.设置采样间隔
    self.mgr.gyroUpdateInterval = 1.0 / 3;
    
    // 3.开始采样
    [self.mgr startGyroUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMGyroData * _Nullable gyroData, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error);
            return;
        }
        
        // 获取陀螺仪的数值
        CMRotationRate rate = gyroData.rotationRate;
        NSLog(@"x:%f y:%f z:%f", rate.x, rate.y ,rate.z);
    }];
}

- (CMMotionManager *)mgr
{
    if (_mgr == nil) {
        _mgr = [[CMMotionManager alloc] init];
    }
    return _mgr;
}

@end
