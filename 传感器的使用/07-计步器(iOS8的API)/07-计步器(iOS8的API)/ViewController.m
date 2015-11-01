//
//  ViewController.m
//  07-计步器(iOS8的API)
//
//  Created by xiaomage on 15/10/30.
//  Copyright © 2015年 xiaomage. All rights reserved.
//

#import "ViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface ViewController ()

/** 计步器对象 */
@property (nonatomic, strong) CMPedometer *pedometer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.判断计步器是否可用
    if (![CMPedometer isStepCountingAvailable]) {
        NSLog(@"计步器不可用");
        return;
    }
    
    // 2.创建计步器对象
    // CMPedometer *pedometer = [[CMPedometer alloc] init];
    
    // 3.开始计步
    /*
    [self.pedometer startPedometerUpdatesFromDate:[NSDate date] withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error);
            return;
        }
        
        NSLog(@"%@", pedometerData.numberOfSteps);
    }];
     */
    
    // 4.查询之前走了多少步
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSDate *fromDate = [fmt dateFromString:@"2015-10-22"];
    NSDate *toDate = [fmt dateFromString:@"2015-10-29"];
    [self.pedometer queryPedometerDataFromDate:fromDate toDate:toDate withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error);
            return;
        }
        
        NSLog(@"%@", pedometerData.numberOfSteps);
    }];
}

- (CMPedometer *)pedometer
{
    if (_pedometer == nil) {
        _pedometer = [[CMPedometer alloc] init];
    }
    return _pedometer;
}

@end
