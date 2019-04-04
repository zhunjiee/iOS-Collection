//
//  AESTool.m
//  AES加密
//
//  Created by 侯宝伟 on 2019/3/23.
//  Copyright © 2019 zhunjiee. All rights reserved.
//

#import "AESTool.h"


@implementation AESTool
// 对 NSData 进行加密
+ (NSData *)encryptDataWithData:(NSData *)data key:(NSString *)key {
    char keyPtr[kCCKeySizeAES128 + 1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(key) encoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr,
                                          kCCBlockSizeAES128,
                                          NULL,
                                          [data bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesEncrypted);
    
    if(cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    free(buffer);
    return nil;
}

// NSData解密
+ (NSData *)decryptDataWithData:(NSData *)data key:(NSString *)key {
    char keyPtr[kCCKeySizeAES128 + 1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr,
                                          kCCBlockSizeAES128,
                                          NULL,
                                          [data bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesDecrypted);
    
    if(cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    free(buffer);
    return nil;
}


// 对 NSString 进行加密
+ (NSString *)encryptStringWithString:(NSString *)string key:(NSString *)key {
    const char *cStr = [string cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cStr length:[string length]];
    //对数据进行加密
    NSData *result = [self encryptDataWithData:data key:key];
    //转换为2进制字符串
    if(result && result.length > 0) {
        Byte *datas = (Byte *)[result bytes];
        NSMutableString *outPut = [NSMutableString stringWithCapacity:result.length];
        for(int i = 0 ; i < result.length ; i++) {
            [outPut appendFormat:@"%02x",datas[i]];
        }
        return outPut;
    }
    return nil;
}
// NSString 解密
+ (NSString *)decryptStringWithString:(NSString *)string key:(NSString *)key {
    NSMutableData *data = [NSMutableData dataWithCapacity:string.length/2.0];
    unsigned char whole_bytes;
    char byte_chars[3] = {'\0','\0','\0'};
    int i;
    for(i = 0 ; i < [string length]/2 ; i++) {
        byte_chars[0] = [string characterAtIndex:i * 2];
        byte_chars[1] = [string characterAtIndex:i * 2 + 1];
        whole_bytes = strtol(byte_chars, NULL, 16);
        [data appendBytes:&whole_bytes length:1];
    }
    
    NSData *result = [self decryptDataWithData:data key:key];
    if(result && result.length > 0) {
        return [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
    }
    return nil;
}

@end
