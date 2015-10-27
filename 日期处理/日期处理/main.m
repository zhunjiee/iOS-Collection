//
//  main.m
//  日期处理
//
//  Created by 侯宝伟 on 15/10/18.
//  Copyright © 2015年 ZHUNJIEE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BWDate.h"
#import "BWCalendar.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        BWDate *date = [[BWDate alloc] init];
        
        [date date_interval];
        [date fmt_date_to_string];
        [date fmt_string_to_date3];
        
        
        
        BWCalendar *calendar = [[BWCalendar alloc] init];
        
        [calendar date_interval];
        
        
        
    }
    return 0;
}
