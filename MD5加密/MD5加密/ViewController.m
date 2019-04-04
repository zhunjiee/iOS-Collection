//
//  ViewController.m
//  MD5加密
//
//  Created by 侯宝伟 on 2019/3/22.
//  Copyright © 2019 zhunjiee. All rights reserved.
//

#import "ViewController.h"
#import "MD5Tool.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // MD5加密不可逆
    NSLog(@"“hello”经过 MD5 32位小写加密：%@", [MD5Tool MD5ForLower32Bate:@"hello"]);
    NSLog(@"“hello”经过 MD5 16位大写加密：%@", [MD5Tool MD5ForUpper16Bate:@"hello"]);
    
    // 但是这是不安全的，相对来说比较容易破解：https://www.cmd5.com/
    // 传统方法是加盐（Salt）：在明文的固定位置插入位数足够多、足够复杂的随机串，然后再进行MD5。
    NSString *salt = @"fdsfjf)*&*JRhuhew7HUH^&udn&&86&*";
    NSString *str = @"123456";    // md5 加密
    str = [str stringByAppendingString:salt];
    
    str = [MD5Tool MD5ForLower32Bate:str];
    
    NSLog(@"加盐加密后的结果：%@",str);
}


@end
