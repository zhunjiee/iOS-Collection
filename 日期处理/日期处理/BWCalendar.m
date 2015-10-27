//
//  BWCalendar.m
//  日期处理
//
//  Created by 侯宝伟 on 15/10/18.
//  Copyright © 2015年 ZHUNJIEE. All rights reserved.
//

#import "BWCalendar.h"

@implementation BWCalendar

- (void)date_interval{
    NSString *myDate = @"2013-10-28 10:45:23";
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [formatter dateFromString:myDate];
    
    NSDate *now = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    

    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    NSDateComponents *components = [calendar components:unit fromDate:date toDate:now options:0];
    
    NSLog(@"%@", components);
}
@end
