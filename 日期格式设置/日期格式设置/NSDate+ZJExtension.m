//
//  NSDate+ZJExtension.m
//  日期格式设置
//
//  Created by 侯宝伟 on 15/11/14.
//  Copyright © 2015年 ZHUNJIEE. All rights reserved.
//

#import "NSDate+ZJExtension.h"

@implementation NSDate (ZJExtension)
/**
 *  是否是今天
 */
- (BOOL)isToday{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    // 获取时间
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    return selfCmps.year == nowCmps.year && selfCmps.month == nowCmps.month && selfCmps.day == nowCmps.day;
}

/**
 *  是否是昨天
 */
- (BOOL)isYesterday{
    // 生成只有年月日的日期对象
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *selfString = [fmt stringFromDate:self];
    NSDate *selfDate = [fmt dateFromString:selfString];
    
    NSString *nowString = [fmt stringFromDate:[NSDate date]];
    NSDate *nowDate = [fmt dateFromString:nowString];
    
    // 比较时间差
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmps = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
    
    return cmps.year == 0 && cmps.month == 0 && cmps.day == 1;
}

/**
 *  是否是明天
 */
- (BOOL)isTomorrow{
    // 生成只有年月日的日期对象
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *selfString = [fmt stringFromDate:self];
    NSDate *selfDate = [fmt dateFromString:selfString];
    
    NSString *nowString = [fmt stringFromDate:[NSDate date]];
    NSDate *nowDate = [fmt dateFromString:nowString];
    
    // 比较时间差
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmps = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
    
    return cmps.year == 0 && cmps.month == 0 && cmps.day == -1;
}

/**
 *  是否是今年
 */
- (BOOL)isThisYear{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSInteger selfYear = [calendar component:NSCalendarUnitYear fromDate:self];
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    
    return selfYear == nowYear;
}
@end
