//
//  NSObject+performSelector.m
//  10-NSInvocation基本使用
//
//  Created by 侯宝伟 on 15/9/17.
//  Copyright (c) 2015年 ZHUNJIEE. All rights reserved.
//

#import "NSObject+performSelector.h"

@implementation NSObject (performSelector)

- (id)performSelector:(SEL)aSelector withObjects:(NSArray *)objects{
    // 1. 创建签名对象
    NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:aSelector];
    
    // 判断传入的方法是否存在,不存在则签名对象为nil
    if (signature == nil) {
        // 传入的方法不存在
        NSString *info = [NSString stringWithFormat:@" -[%@ %@]:  unrecognized selector sent to instance", [self class], NSStringFromSelector(aSelector)];
        
        @throw [[NSException alloc] initWithName:@"出错啦:" reason:info userInfo:nil];
    }
    
    // 2. 创建一个NSInvocation对象
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    
    // 3. 保存方法所属的对象
    invocation.target = self;
    
    // 4. 保存方法名称
    invocation.selector = aSelector;
    
    // 5. 设置参数
    // 参数个数
    NSUInteger arguments = signature.numberOfArguments - 2;
    // 参数值个数
    NSUInteger objectsCount = objects.count;
    // 谁少就遍历谁
    NSUInteger count = MIN(arguments, objectsCount);
    
    for (int i = 0; i < count; i++) {
        NSObject *obj = objects[i];
        
        // 处理数组参数中NSNull问题
        if ([obj isKindOfClass:[NSNull class]]) {
            obj = nil;
        }
        
        [invocation setArgument:&obj atIndex:i + 2];
    }
    
    // 6. 调用invoke方法
    [invocation invoke];
        
    
    // 7. 返回值问题处理
    id result = nil;
    // 判断当前方法是否有返回值
    if (signature.methodReturnLength != 0) {
        // 获取返回值
        [invocation getReturnValue:&result];
    }
    
    return result;
}
@end
