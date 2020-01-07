//
//  ViewController.m
//  Socket
//
//  Created by zl on 2019/11/27.
//  Copyright © 2019 ZHUNJIEE. All rights reserved.
//

#import "ViewController.h"
#import <GCDAsyncSocket.h>

@interface ViewController () <GCDAsyncSocketDelegate>
/** 客户端Socket */
@property (nonatomic, strong) GCDAsyncSocket *clientSocket;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 1. 连接服务器
       // 1.1 创建客户端Socket对象
       GCDAsyncSocket *clientSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_global_queue(0, 0)];
       // 1.2 连接
       NSError *error = nil;
       [clientSocket connectToHost:@"121.40.165.18" onPort:8800 error:&error];
       if (error) {
           NSLog(@"%@", error);
           //
       }
       self.clientSocket = clientSocket;
}


#pragma mark - GCDAsyncSocketDelegate

// 2. 监听数据读取
/**
 *  连接到服务器后调用
 */
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port{
    NSLog(@"与服务器连接成功,建立了通信连接");
    
#warning 客户端连接成功后,要监听数据读取
    [sock readDataWithTimeout:-1 tag:0];
}

/**
 *  与服务器断开连接时调用
 */
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err{
    NSLog(@"与服务器断开连接 %@", err);
}

/**
 *  接收数据
 */
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@ %@", str, [NSThread currentThread]);
    
    // 准备读取下次的数据
    [sock readDataWithTimeout:-1 tag:0];
}

- (IBAction)sendBtnDidClick:(UIButton *)sender {
    // 发送
    [self.clientSocket writeData:[@"123" dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:0];
}

@end
