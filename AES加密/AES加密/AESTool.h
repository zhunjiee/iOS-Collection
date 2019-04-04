//
//  AESTool.h
//  AES加密
//
//  Created by 侯宝伟 on 2019/3/23.
//  Copyright © 2019 zhunjiee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>

NS_ASSUME_NONNULL_BEGIN

@interface AESTool : NSObject

// 对 NSData 进行加密
+ (NSData *)encryptDataWithData:(NSData *)data key:(NSString *)key;
// NSData 解密
+ (NSData *)decryptDataWithData:(NSData *)data key:(NSString *)key;

// 对 NSString 进行加密
+ (NSString *)encryptStringWithString:(NSString *)string key:(NSString *)key;
// NSString 解密
+ (NSString *)decryptStringWithString:(NSString *)string key:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
