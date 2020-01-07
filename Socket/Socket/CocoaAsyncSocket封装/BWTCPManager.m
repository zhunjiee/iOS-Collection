//
//  BWTCPManager.m
//  Socket
//
//  Created by Houge on 2020/1/7.
//  Copyright © 2020 ZHUNJIEE. All rights reserved.
//

#import "BWTCPManager.h"

@implementation BlockModel
- (id)copyWithZone:(NSZone *)zone {
    return self;
}
@end

@interface BWTCPManager ()<GCDAsyncSocketDelegate>
{
    GCDAsyncSocket * gcdSocket;
    NSMutableArray * blockArr;
    NSDictionary * headDic;
}
@end

@implementation BWTCPManager

+(instancetype)shareInstance
{
    static BWTCPManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[BWTCPManager alloc] init];
    });
    return instance;
}

-(instancetype)init
{
    if (self = [super init]) {
      blockArr = [NSMutableArray array];
    }
    return self;
}

//连接tcp服务器
-(void)connectTcpServer
{
    if (gcdSocket&&[gcdSocket isConnected]) {
        return;
    }
    gcdSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    
    NSError * err;
    [gcdSocket connectToHost:TCP_HOST_IP onPort:TCP_PORT error:&err];
    if (err) {
#if IS_OPEN_DEBUG
        NSLog(@"tcp connect server error:%@",err);
#endif
    }
}

//断开tcp连接
-(void)disConnectTcpServer
{
    if (gcdSocket && [gcdSocket isConnected]) {
        [gcdSocket disconnect];
    }
}

//tcp重连接
-(void)reConnectTcpServer
{
    if (gcdSocket&&[gcdSocket isConnected]) {
        [self disConnectTcpServer];
    }
    [self connectTcpServer];
}

//tcp连接状态
-(BOOL)isTcpConnected
{
    if (gcdSocket && [gcdSocket isConnected]) {
        return YES;
    }
    return NO;
}

//发送数据，数据类型可以是文本，图片，语音，文件...根据实际需要进行扩展
-(void)sendData:(NSData *)data MessageType:(BWTcpSendMessageType)messageType Response:(ResponseBlock)block IsServerAnswer:(BOOL)isAnser
{
#if IS_OPEN_DEBUG
    if (messageType == BWTcpSendMessageText) {
        NSString * content = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"tcp发送一次文本内容:%@",content);
    }else if (messageType == ZWTcpSendMessagePicture)
    {
        NSLog(@"tcp发送一次图片内容:%@",data);
    }
#endif
    if (![self isTcpConnected]) {
        
#if IS_OPEN_DEBUG
        NSLog(@"tcp unconnected,message send failure");
#endif
        return;
    }
    
    /*  数据组包   */
    NSUInteger contentSize = data.length;
    NSMutableDictionary * headDic = [NSMutableDictionary dictionary];
    [headDic setObject:[NSNumber numberWithInt:messageType] forKey:kHeadMessageType];
    [headDic setObject:[NSString stringWithFormat:@"%lu",(unsigned long)contentSize] forKey:kHeadMessageSize];
    NSString * headStr = [self dictionaryToJson:headDic];
    NSData * headData = [headStr dataUsingEncoding:NSUTF8StringEncoding];
    //增加头部信息
    NSMutableData * contentData = [NSMutableData dataWithData:headData];
    //增加头部信息分界
    [contentData appendData:[GCDAsyncSocket CRLFData]];//CRLFData:\r\n(换行回车)，\r:回车，回到当前行的行首，\n:换行，换到当前行的下一行，不会回到行首
    //增加要发送的消息内容
    [contentData appendData:data];
    //发送消息
    [gcdSocket writeData:contentData withTimeout:-1 tag:0];
    
    if (isAnser) { //当前消息后台会应答才给block赋值，不然会影响下一次发送消息后台有应答的情况
        BlockModel * blockM = [[BlockModel alloc] init];
        blockM.timeStamp = [NSDate date];
        blockM.block = block;
        [blockArr addObject:blockM];
    }
}


#pragma mark -GCDAsyncSocketDelegate
//连接成功调用
-(void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port
{
#if IS_OPEN_DEBUG
    NSLog(@"tcp连接成功,host:%@,port:%d",host,port);
#endif
    
    if (_delegate && [_delegate respondsToSelector:@selector(tcpConnectedSuccess)]) {
        [_delegate tcpConnectedSuccess];
    }
    [gcdSocket readDataToData:[GCDAsyncSocket CRLFData] withTimeout:-1 tag:0];
}

//断开连接调用
-(void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err
{
#if IS_OPEN_DEBUG
    NSLog(@"断开连接，host:%@,port:%d,err:%@",sock.localHost,sock.localPort,err);
#endif
    
    if (_delegate && [_delegate respondsToSelector:@selector(tcpconnectedFailure)]) {
        [_delegate tcpconnectedFailure];
    }
    //清空缓存
    if (blockArr) {
        [blockArr removeAllObjects];
    }
}

//写成功回调
-(void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{
#if IS_OPEN_DEBUG
    NSLog(@"写成功回调,tag:%ld",tag);
#endif
}

//读成功回调
-(void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    //先读取当前数据包头部信息
    if (!headDic) {
#if IS_OPEN_DEBUG
        NSString * msg = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"tcp收到当前消息的head：%@",msg);
#endif
        
        NSError * error = nil;
        headDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
#if IS_OPEN_DEBUG
            NSLog(@"tcp获取当前数据包head失败：%@",error);
#endif
             return;
        }
        //获取数据包头部大小
        NSUInteger packetLength = [headDic[kHeadMessageSize] integerValue];
        //读到数据包的大小
        [sock readDataToLength:packetLength withTimeout:-1 tag:0];
        return;
    }
    
    //正式包的处理
    NSUInteger packetLength = [headDic[kHeadMessageSize] integerValue];
    
   //数据校验
    if (packetLength <= 0 || data.length != packetLength) {
#if IS_OPEN_DEBUG
        NSLog(@"tcp recieve message err:当前数据包大小不正确");
#endif
        return;
    }
    
    //数据回调
    BWTcpSendMessageType messageType = (BWTcpSendMessageType)[headDic[kHeadMessageType] integerValue];
    
#if IS_OPEN_DEBUG
    if (messageType == ZWTcpSendMessageText) {
        NSString * msg = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"tcp收到当前消息的body：%@",msg);
    }else if (messageType == ZWTcpSendMessagePicture){
        //如果图片很大，打印的二进制信息会不全，可以写入文件保存为png或者jpg查看收到的内容
        NSLog(@"tcp收到当前消息的body(图片)：%@",data);
    }
#endif
    
    //客户端发送消息，服务端响应
    if (blockArr.count > 0) {
        BlockModel * blockM = [blockArr[0] copy];
        [blockArr removeObjectAtIndex:0];
        blockM.block(data, messageType);
        
    }else
    {
        //接收服务器主动发送的消息
        if (_delegate && [_delegate respondsToSelector:@selector(recieveServerActiveReport: MessageType:)]) {
            [_delegate recieveServerActiveReport:data MessageType:messageType];
        }
    }
    
    //清空头部
    headDic = nil;
    [sock readDataToData:[GCDAsyncSocket CRLFData] withTimeout:-1 tag:0];
}

#pragma mark -工具方法

//字典转json字符串
-(NSString *)dictionaryToJson:(NSDictionary*)dic
{
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
