//
//  MD5Tool.m
//  MD5加密
//
//  Created by 侯宝伟 on 2019/3/22.
//  Copyright © 2019 zhunjiee. All rights reserved.
//

#import "MD5Tool.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation MD5Tool
#pragma mark - 32位，小写
+ (NSString *)MD5ForLower32Bate:(NSString *)str {
    // UTF-8转码
    const char *input = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02x", result[i]];
    }
    return digest;
}

#pragma mark - 32位，大写
+ (NSString *)MD5ForUpper32Bate:(NSString *)str {
    // UTF-8转码
    const char *input = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02X", result[i]];
    }
    return digest;
}

#pragma mark - 16位，小写
+ (NSString *)MD5ForLower16Bate:(NSString *)str {
    NSString *md5Str = [self MD5ForLower32Bate:str];
    NSString *string;
    for (int i = 0; i < 24; i++) {
        string = [md5Str substringWithRange:NSMakeRange(8, 16)];
    }
    return string;
}

#pragma mark - 16位，大写
+ (NSString *)MD5ForUpper16Bate:(NSString *)str {
    NSString *md5Str = [self MD5ForUpper32Bate:str];
    NSString *string;
    for (int i = 0; i < 24; i++) {
        string = [md5Str substringWithRange:NSMakeRange(8, 16)];
    }
    return string;
}
@end
