//
//  ZJPermenantThread-C.m
//  线程保活
//
//  Created by 侯宝伟 on 2019/3/6.
//  Copyright © 2019 zhunjiee. All rights reserved.
//

#import "ZJPermenantThread_C.h"
@interface ZJPermenantThread_C ()
@property (nonatomic, strong) NSThread *innerThread;
@end

@implementation ZJPermenantThread_C
#pragma mark - public methods
- (instancetype)init {
    if (self = [super init]) {
        // 创建线程
        self.innerThread = [[NSThread alloc] initWithBlock:^{
            NSLog(@"begin---");
            // 创建上下文（要初始化一下结构体）
            CFRunLoopSourceContext context = {0};
            // 创建 source
            CFRunLoopSourceRef source = CFRunLoopSourceCreate(kCFAllocatorDefault, 0, &context);
            // 添加 source
            CFRunLoopAddSource(CFRunLoopGetCurrent(), source, kCFRunLoopDefaultMode);
            // 销毁 source
            CFRelease(source);
            // 启动
            CFRunLoopRunInMode(kCFRunLoopDefaultMode, 1.0e10, false); // 最后一个参数：处理完 source 后是否退出
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
    CFRunLoopStop(CFRunLoopGetCurrent());
    self.innerThread = nil;
}
@end
