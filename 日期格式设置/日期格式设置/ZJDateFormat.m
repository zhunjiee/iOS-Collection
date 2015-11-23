//
//  ZJDateFormat.m
//  日期格式设置
//
//  Created by 侯宝伟 on 15/11/14.
//  Copyright © 2015年 ZHUNJIEE. All rights reserved.
//

#import "ZJDateFormat.h"
#import "NSDate+ZJExtension.h"

@implementation ZJDateFormat

// 重写create_at的getter方法 设置时间格式

/** 兼容iOS8.0以前 */
- (NSString *)created_at{
    // 服务器返回日期
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *createAtDate = [fmt dateFromString:_created_at];
    
    if (createAtDate.isThisYear) { // 今年
        if (createAtDate.isToday) { // 今天
            // 获取当前系统时间
            NSDate *nowDate = [NSDate date];
            // 日历对象
            NSCalendar *calendar = [NSCalendar currentCalendar];
            
            NSCalendarUnit unit = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
            
            NSDateComponents *cmps = [calendar components:unit fromDate:createAtDate toDate:nowDate options:0];
            
            if (cmps.hour >= 1) { // 时间间隔 >= 1个小时
                return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            }else if (cmps.minute >= 1){
                return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            }else{
                return @"刚刚";
            }
        }else if (createAtDate.isYesterday){ // 昨天
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:createAtDate];
        }else{ // 其他
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:createAtDate];
        }
        
    }else{ // 非今年
        return _created_at;
    }
    
}


/** iOS8.0开始的返回时间处理 */
- (NSString *)created_at8{
    // 服务器返回日期
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *createAtDate = [fmt dateFromString:_created_at];
    
    // 获取当前系统时间
    NSDate *nowDate = [NSDate date];
    // 日历对象
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // 年
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:nowDate];
    NSInteger createdAtYear = [calendar component:NSCalendarUnitYear fromDate:createAtDate];
    
    if (nowYear == createdAtYear) { // 今年
        if ([calendar isDateInToday:createAtDate]) { // 今天
            
            NSCalendarUnit unit = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
            
            NSDateComponents *cmps = [calendar components:unit fromDate:createAtDate toDate:nowDate options:0];
            
            if (cmps.hour >= 1) { // 时间间隔 >= 1个小时
                return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            }else if (cmps.minute >= 1){
                return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            }else{
                return @"刚刚";
            }
        }else if (createAtDate.isYesterday){ // 昨天
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:createAtDate];
        }else{ // 其他
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:createAtDate];
        }
        
    }else{ // 非今年
        return _created_at;
    }
    
}
@end
