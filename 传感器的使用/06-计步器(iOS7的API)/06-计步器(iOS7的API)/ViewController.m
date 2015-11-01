//
//  ViewController.m
//  06-计步器(iOS7的API)
//
//  Created by xiaomage on 15/10/30.
//  Copyright © 2015年 xiaomage. All rights reserved.
//

#import "ViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *stepLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.判断计步器是否可用
    if (![CMStepCounter isStepCountingAvailable]) {
        NSLog(@"计步器不可用");
        return;
    }
    
    // 2.创建计步器对象
    CMStepCounter *stepCounter = [[CMStepCounter alloc] init];
    
    // 3.开始计步
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [stepCounter startStepCountingUpdatesToQueue:queue updateOn:5 withHandler:^(NSInteger numberOfSteps, NSDate * _Nonnull timestamp, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error);
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.stepLabel.text = [NSString stringWithFormat:@"您一共了%ld步", numberOfSteps];
        });
        
//        self.stepLabel performSelectorOnMainThread:<#(nonnull SEL)#> withObject:<#(nullable id)#> waitUntilDone:<#(BOOL)#> modes:<#(nullable NSArray<NSString *> *)#>
    }];
}

@end
