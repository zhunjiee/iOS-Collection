//
//  BWDate.m
//  日期处理
//
//  Created by 侯宝伟 on 13/10/18.
//  Copyright © 2013年 ZHUNJIEE. All rights reserved.
//

#import "BWDate.h"

@implementation BWDate

/**
 *  计算时间间隔
 */
- (void)date_interval{
    NSString *myDate = @"2015-10-18 10:45:23";
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSDate *date = [formatter dateFromString:myDate];
    
    // 获取系统当前时间
    NSDate *now = [NSDate date];
    
    // 计算时间间隔
    NSTimeInterval interval = [now timeIntervalSinceDate:date];
    
    NSLog(@"%f", interval);
}


/**
 *  字符串 转 日期
 */
- (void)fmt_string_to_date{
    NSString *string = @"2015-10-18 10:45:23";
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSDate *date = [formatter dateFromString:string];
    
    NSLog(@"%@", date);
}

/**
 *  字符串 转 日期
 *  解析 欧美格式 日期字符串
 */
- (void)fmt_string_to_date2{
    // 服务器返回的时间字符串
    NSString *string = @"Tue May 31 17:46:55 +0800 2011";
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    formatter.dateFormat = @"EEE MMM dd HH:mm:ss ZZZZ yyyy";
    
    NSDate *date = [formatter dateFromString:string];
    
    NSLog(@"%@", date);
}

/**
 *  timestamp -> NSDate
 *  解析 时间戳
 */
- (void)fmt_string_to_date3{
    // 时间戳: 从1970年1月1日开始经历的毫秒数
    NSInteger timestamp = 1445164401875.157959;
    
    // 获取系统当前的时间戳
    //    NSTimeInterval nowTimestamp = [[NSDate date] timeIntervalSince1970] * 1000.0;
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp/1000.0];
    
    NSLog(@"%@", date);
}


/**
 *  日期 转 字符串
 */
- (void)fmt_date_to_string{
    // 获取系统当前时间
    NSDate *now = [NSDate date];
    
    // 创建一个日期格式化对象
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // 设置日期格式
    formatter.dateFormat = @"yyy-MM-dd HH:mm:ss";
    
    // Date -> NSString
    NSString *nowString = [formatter stringFromDate:now];
    
    NSLog(@"%@", nowString);
}

@end
