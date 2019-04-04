//
//  MD5Tool.h
//  MD5加密
//
//  Created by 侯宝伟 on 2019/3/22.
//  Copyright © 2019 zhunjiee. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MD5Tool : NSObject

/**
 MD5加密，32位，小写

 @param str 要加密的字符串
 @return 加密后的字符串
 */
+ (NSString *)MD5ForLower32Bate:(NSString *)str;

/**
 MD5加密，32位，大写
 
 @param str 要加密的字符串
 @return 加密后的字符串
 */
+ (NSString *)MD5ForUpper32Bate:(NSString *)str;

/**
 MD5加密，16位，小写
 
 @param str 要加密的字符串
 @return 加密后的字符串
 */
+ (NSString *)MD5ForLower16Bate:(NSString *)str;

/**
 MD5加密，16位，大写
 
 @param str 要加密的字符串
 @return 加密后的字符串
 */
+ (NSString *)MD5ForUpper16Bate:(NSString *)str;

@end

NS_ASSUME_NONNULL_END
