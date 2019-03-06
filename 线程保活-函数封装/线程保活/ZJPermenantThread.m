//
//  ZJPermenantThread.m
//  线程保活
//
//  Created by 侯宝伟 on 2019/3/6.
//  Copyright © 2019 zhunjiee. All rights reserved.
//

#import "ZJPermenantThread.h"

@interface ZJPermenantThread ()
@property (nonatomic, strong) NSThread *innerThread;
@property (nonatomic, assign, getter=isStopped) BOOL stopped;
@end

@implementation ZJPermenantThread
#pragma mark - public methods
- (instancetype)init {
    if (self = [super init]) {
        self.stopped = NO;
        __weak typeof(self) weakSelf = self;
        // 创建线程
        self.innerThread = [[NSThread alloc] initWithBlock:^{
            NSLog(@"begin---");
            // 创建 runloop，添加 sources 避免空 runloopr 退出
            [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
            while (weakSelf && !weakSelf.isStopped) {
                // 启动 runloop
                [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantPast]];
            }
            NSLog(@"end---");
        }];
        // 开启线程
        [self.innerThread start];
    }
    return self;
}

- (void)executeTask:(ZJPermenantThreadTask)task {
    if (!self.innerThread || !task)  return;
    [self performSelector:@selector(__executeTask:) onThread:self.innerThread withObject:task waitUntilDone:NO];
}

- (void)stop {
    if (!self.innerThread) return;
    [self performSelector:@selector(__stop) onThread:self.innerThread withObject:nil waitUntilDone:YES];
}
- (void)dealloc {
    NSLog(@"%s", __func__);
    [self stop];
}

#pragma mark - private methods
- (void)__executeTask:(ZJPermenantThreadTask)task {
    task();
}
- (void)__stop {
    self.stopped = YES;
    CFRunLoopStop(CFRunLoopGetCurrent());
    self.innerThread = nil;
}
@end
