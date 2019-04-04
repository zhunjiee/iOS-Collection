//
//  ViewController.m
//  AES加密
//
//  Created by 侯宝伟 on 2019/3/24.
//  Copyright © 2019 zhunjiee. All rights reserved.
//

#import "ViewController.h"
#import "AESTool.h"
#import "NSString+AES.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //    NSLog(@"”hello“经过 AES 加密：%@", [AESTool encryptStringWithString:@"hello" key:@"123"]);
    //    NSLog(@"解密后：%@", [AESTool decryptStringWithString:@"0c4277c1e2f7423ea13510186743c680" key:@"123"]);
    
    NSString *str = @"hello";
    NSLog(@"加密：%@", [str aci_encryptWithAES]);
    NSString *decryptStr = @"RNS/CtEotZVMlE5EsrEQ9A==";
    NSLog(@"解密：%@", [decryptStr aci_decryptWithAES]);
    
    
    
    NSLog(@"base64编码：%@", [self encodeBase64:@"HelloWorld"]);
    NSLog(@"base64解码：%@", [self decodeBase64:@"SGVsbG9Xb3JsZA=="]);
}



#pragma mark - Base64编码练习
// 1>ASCII码是8个二进制位一编码
// 2>Base64编码是6个二进制位一编码,所以转换成字符串后会比ASCII内容要多

// base64编码
- (NSString *)encodeBase64:(NSString *)str {
    // 先将 str 转为 data
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSData *base64Data = [data base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSString *baseStr = [[NSString alloc] initWithData:base64Data encoding:NSUTF8StringEncoding];
    return baseStr;
}
- (NSString *)decodeBase64:(NSString *)base64Str {
    NSData *data = [[NSData alloc] initWithBase64EncodedString:base64Str options:NSUTF8StringEncoding];
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return str;
}
@end
