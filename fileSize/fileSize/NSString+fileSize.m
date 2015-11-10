//
//  NSString+fileSize.m
//  fileSize
//
//  Created by 侯宝伟 on 15/11/8.
//  Copyright © 2015年 ZHUNJIEE. All rights reserved.
//

#import "NSString+fileSize.h"

@implementation NSString (fileSize)

- (unsigned long long)fileSize{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    BOOL isDirectory = NO;
    BOOL exist = [fileManager fileExistsAtPath:self isDirectory:&isDirectory];
    
    // 1. 如果文件/文件夹不存在
    if (exist == 0) return 0;
    
    // 2. 如果是文件夹
    if (isDirectory) {
        unsigned long long size = 0;
        NSDirectoryEnumerator *enumerator = [fileManager enumeratorAtPath:self];
        for (NSString *subpath in enumerator) {
            NSString *fullSubpath = [self stringByAppendingPathComponent:subpath];
            NSDictionary *attrs = [fileManager attributesOfItemAtPath:fullSubpath error:nil];
            if ([attrs[NSFileType] isEqualToString:NSFileTypeDirectory]) continue;
            
            size += [attrs[NSFileSize] integerValue];
        }
        return size;
    }
    
    // 3. 如果是文件
    NSDictionary *attrs = [fileManager attributesOfItemAtPath:self error:nil];
    return [attrs[NSFileSize] integerValue];
}

- (NSString *)fileSizeString{
    unsigned long long fileSize = [self fileSize];
    CGFloat unit = 1000.0;
    if (fileSize >= pow(unit, 3)) {
        return [NSString stringWithFormat:@"%.1fGB", fileSize / pow(unit, 3)];
    }else if (fileSize >= pow(unit, 2)){
        return [NSString stringWithFormat:@"%.1fMB", fileSize / pow(unit, 2)];
    }else if (fileSize >= unit){
        return [NSString stringWithFormat:@"%.1fKB", fileSize / unit];
    }
    return [NSString stringWithFormat:@"%zdB", fileSize];
}
@end
