//
//  NSString+Extension.m
//  BWClearCaches
//
//  Created by 侯宝伟 on 15/10/13.
//  Copyright © 2015年 ZHUNJIEE. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

// 获取文件的大小
- (unsigned long long)fileSize{
    // 创建fileManager
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // 判断文件是否存在
    BOOL isDirectory = NO;
    BOOL exist = [fileManager fileExistsAtPath:self isDirectory:&isDirectory];
    // 如果不存在直接返回0
    if (exist == NO) return 0;
    
    // 是文件夹再遍历
    if (isDirectory) {
        unsigned long long size = 0;
        
        // 通过遍历器获取文件夹下所有子文件
        NSDirectoryEnumerator *dirEnum = [fileManager enumeratorAtPath:self];
        for (NSString *subpath in dirEnum) {
            // 拼接获取每个文件的全路径
            NSString *fullpath = [self stringByAppendingString:subpath];
            
            NSDictionary *attrs = [fileManager attributesOfItemAtPath:fullpath error:nil];
            
            if ([attrs[NSFileType] isEqualToString:NSFileTypeDirectory]) continue;
            
            size += [attrs[NSFileSize] integerValue];
        }
        return size;
    }
    
    // 是文件直接返回大小
    return [[fileManager attributesOfItemAtPath:self error:nil][NSFileSize] integerValue];
}

- (NSString *)fileSizeString{
    unsigned long long fileSize = [self fileSize];
    float unit = 1000.0;
    
    if (fileSize >= pow(unit, 3)) {
        return [NSString stringWithFormat:@"%.2fGB", fileSize / pow(unit, 3)];
    }else if (fileSize >= pow(unit, 2)){
        return [NSString stringWithFormat:@"%.2fMB", fileSize / pow(unit, 2)];
    }else if (fileSize >= unit){
        return [NSString stringWithFormat:@"%.2fKB", fileSize / unit];
    }else{
        return [NSString stringWithFormat:@"%zdB", fileSize];
    }

}
@end
