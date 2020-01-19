//
//  BWTCPManager.h
//  Socket
//
//  Created by Houge on 2020/1/7.
//  Copyright © 2020 ZHUNJIEE. All rights reserved.
//
// https://www.jianshu.com/p/c96fd87371d6

#import <Foundation/Foundation.h>
#import <GCDAsyncSocket.h>

NS_ASSUME_NONNULL_BEGIN

#define IS_OPEN_DEBUG  0  //配置是否打印调试信息 1:打印信息 0:关闭打印信息
//tcp 服务端 IP、PORT 配置
#define TCP_HOST_IP @"172.20.20.105"
#define TCP_PORT 6969

//发送消息必须和后台商议，给每条发送的消息加上头部，字段如下，可以自定义扩展（为了解决tcp接收端数据粘包问题）
static NSString * const  kHeadMessageType = @"type";
static NSString * const  kHeadMessageSize = @"size";

//发送的消息类型,根据项目实际需求进行扩展
typedef NS_ENUM(NSUInteger, BWTcpSendMessageType) {
    BWTcpSendMessageText,     //文本
    BWTcpSendMessagePicture,  //图片
};

//回调闭包
typedef void(^ResponseBlock)(NSData * responseData,BWTcpSendMessageType type);


//tcp连接成功和失败代理
@protocol BWTCPManagerDelegate <NSObject>

@required
-(void)tcpConnectedSuccess; //连接成功
-(void)tcpconnectedFailure; //连接失败
//收到tcp服务器主动发送的消息
-(void)recieveServerActiveReport:(NSData*)reportData MessageType:(BWTcpSendMessageType)type;

@end


@interface BWTCPManager : NSObject

@property (nonatomic,weak) id<BWTCPManagerDelegate> delegate;//代理

+(instancetype)shareInstance;//单例
//连接tcp服务器
-(void)connectTcpServer;
//tcp重连接
-(void)reConnectTcpServer;
//断开tcp连接
-(void)disConnectTcpServer;
//tcp连接状态
-(BOOL)isTcpConnected;
//发送消息及后台是否回复当前消息,如果发送消息后台没有应答当前消息，请配置isAnser = NO;
-(void)sendData:(NSData*)data MessageType:(BWTcpSendMessageType)messageType  Response:(ResponseBlock)block IsServerAnswer:(BOOL)isAnser;

@end


@interface BlockModel :NSObject<NSCopying>
@property (nonatomic,strong) NSDate * timeStamp;
@property (nonatomic,copy) ResponseBlock block;
@end

NS_ASSUME_NONNULL_END
