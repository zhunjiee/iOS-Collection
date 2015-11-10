//
//  Person.h
//  runtime
//
//  Created by 侯宝伟 on 15/11/7.
//  Copyright © 2015年 ZHUNJIEE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
{
    double _weight;
    
    @public
    double _money;
}
/** 年龄 */
@property (nonatomic, assign) NSUInteger age;
/** 名字 */
@property (nonatomic, copy)  NSString *name;
/** block */
@property (nonatomic, copy) void (^block)();
/** 注释 */
@property (nonatomic, assign, getter=isRich) BOOL rich;
@end
