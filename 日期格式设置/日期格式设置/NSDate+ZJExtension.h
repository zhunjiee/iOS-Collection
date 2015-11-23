//
//  NSDate+ZJExtension.h
//  日期格式设置
//
//  Created by 侯宝伟 on 15/11/14.
//  Copyright © 2015年 ZHUNJIEE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (ZJExtension)
- (BOOL)isToday;

- (BOOL)isYesterday;

- (BOOL)isTomorrow;

- (BOOL)isThisYear;
@end
