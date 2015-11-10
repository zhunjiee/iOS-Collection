//
//  main.m
//  runtime
//
//  Created by 侯宝伟 on 15/11/7.
//  Copyright © 2015年 ZHUNJIEE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Student.h"
#import <objc/runtime.h>

// 获取所有的Ivar实例变量的名称和类型
void testCopyIvarList(){
    unsigned int count = 0;
    Ivar *ivarList = class_copyIvarList([Student class], &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivarList[i];
        NSLog(@"%s -- %s", ivar_getName(ivar), ivar_getTypeEncoding(ivar));
    }
    
    free(ivarList);
}

// 获取所有@property声明的属性的名称
void testCopyPropertyList(){
    unsigned int count = 0;
    objc_property_t *propertyList = class_copyPropertyList([Student class], &count);
    for (int i = 0; i < count; i++) {
        objc_property_t property = propertyList[i];
        NSLog(@"%s ** %s", property_getName(property), property_getAttributes(property));
    }
    free(propertyList);
}

int main(int argc, const char * argv[]) {
    testCopyIvarList();
    testCopyPropertyList();
    return 0;
}


