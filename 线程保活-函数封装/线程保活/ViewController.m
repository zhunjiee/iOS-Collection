//
//  ViewController.m
//  线程保活
//
//  Created by 侯宝伟 on 2019/3/6.
//  Copyright © 2019 zhunjiee. All rights reserved.
//

#import "ViewController.h"
#import "ZJPermenantThread.h"

@interface ViewController ()
@property (nonatomic, strong) ZJPermenantThread *thread;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.thread = [[ZJPermenantThread alloc] init];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.thread executeTask:^{
        NSLog(@"%s  %@", __func__, [NSThread currentThread]);
    }];
}


- (IBAction)stop {
    [self.thread stop];
}

- (void)dealloc {
    NSLog(@"%s", __func__);

    [self stop];
}
@end
