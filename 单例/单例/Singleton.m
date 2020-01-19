//
//  Singleton.m
//  单例
//
//  Created by Houge on 2020/1/12.
//  Copyright © 2020 ZHUNJIEE. All rights reserved.
//

#import "Singleton.h"

@implementation Singleton
static id _insatnce;

+(instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _insatnce = [[self alloc] init];
    });
    return _insatnce;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _insatnce = [super allocWithZone:zone];
    });
    return _insatnce;
}

- (id)copyWithZone:(NSZone *)zone {
    return _insatnce;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return _insatnce;
}

@end
