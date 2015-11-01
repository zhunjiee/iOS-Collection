//
//  ViewController.m
//  03-加速计信息的获取(新API)
//
//  Created by xiaomage on 15/10/30.
//  Copyright © 2015年 xiaomage. All rights reserved.
//

#import "ViewController.h"
#import <CoreMotion/CoreMotion.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()

/** 运动管理者 */
@property (nonatomic, strong) CMMotionManager *mgr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // pull方式
    // 1.判断加速计是否可用
    if (!self.mgr.isAccelerometerAvailable) {
        NSLog(@"加速计坏了,请更换手机");
        return;
    }
    
    // 2.开始采样
    [self.mgr startAccelerometerUpdates];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CMAcceleration acceleration = self.mgr.accelerometerData.acceleration;
    NSLog(@"x:%f y:%f z:%f", acceleration.x, acceleration.y, acceleration.z);
}

- (void)pushAccelerometer
{
    // push方式
    // 1.创建运动管理者
    // CMMotionManager *mgr = [[CMMotionManager alloc] init];
    
    // 2.判断加速计是否可用
    if (!self.mgr.isAccelerometerAvailable) {
        NSLog(@"加速计坏了,请更换手机");
        return;
    }
    
    // 3.设置采样间隔
    self.mgr.accelerometerUpdateInterval = 1.0;
    
    // 4.开始采样
    [self.mgr startAccelerometerUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
        // 1.判断获取的过程中是否有错误
        if (error) {
            NSLog(@"%@", error);
            return;
        }
        
        // 2.获取加速计的数值
        CMAcceleration acceleration = accelerometerData.acceleration;
        NSLog(@"x:%f y:%f z:%f", acceleration.x, acceleration.y, acceleration.z);
    }];
}

#pragma mark - 懒加载代码
- (CMMotionManager *)mgr
{
    if (_mgr == nil) {
        self.mgr = [[CMMotionManager alloc] init];
    }
    return _mgr;
}

@end
