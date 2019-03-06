//
//  ZJPermenantThread-C.h
//  线程保活
//
//  Created by 侯宝伟 on 2019/3/6.
//  Copyright © 2019 zhunjiee. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ZJPermenantThreadTask)(void);

@interface ZJPermenantThread_C : NSObject
/**
 在当前子线程执行任务
 
 @param task 任务
 */
- (void)executeTask:(ZJPermenantThreadTask)task;

/**
 结束线程
 */
- (void)stop;
@end

NS_ASSUME_NONNULL_END
