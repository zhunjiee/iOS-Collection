//
//  ViewController.m
//  PushNotificationDemo
//
//  Created by 侯歌 on 2020/10/14.
//  Copyright © 2020 HouGe. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) UILabel *label;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.label];
    self.label.text = @"暂无通知";

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveRemotePushNotification:) name:RemotePushNotification object:nil];
}

- (void)receiveRemotePushNotification:(NSNotification *)noti {
    NSDictionary *userInfo = noti.userInfo;
    NSLog(@"收到推送通知:%@", userInfo);
    self.label.text = [self convertToJsonData:userInfo];
}


- (NSString *)convertToJsonData:(NSDictionary *)dict {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;

    if (!jsonData) {
        NSLog(@"%@",error);
    } else {
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }

    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};

    //去掉字符串中的空格
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};

    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];

    return mutStr;

}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:self.view.bounds];
    }
    return _label;
}


@end
