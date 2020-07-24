//
//  HttpRequest.h
//  AFNetworking封装
//
//  Created by 侯宝伟 on 2019/3/30.
//  Copyright © 2019 zhunjiee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "UploadParam.h"

NS_ASSUME_NONNULL_BEGIN

// 自定义错误类型
#define CustomErrorCode @"CustomErrorCode"

// 网络请求类型
typedef NS_ENUM(NSUInteger, HttpRequestType) {
    HttpRequestTypeGet = 0,     // GET 请求
    HttpRequestTypePost = 1    // POST 请求
};
typedef void (^SuccessBlock)(id _Nullable responseObject);
typedef void (^FailureBlock)(NSString * _Nullable errorCode, NSString * _Nullable errorText);
typedef void (^ProgressBlock)(NSProgress * _Nullable progress);


@interface HttpRequest : NSObject

@property (strong, nonatomic) AFHTTPSessionManager *manager;

+ (instancetype)sharedInstance;

/**
 *  发送get请求
 *
 *  @param URLString  请求的网址字符串
 *  @param parameters 请求的参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
- (void)getWithURLString:(NSString *)URLString
              parameters:(nullable id)parameters
                 success:(SuccessBlock)success
                 failure:(FailureBlock)failure;

/**
 *  发送post请求
 *
 *  @param URLString  请求的网址字符串
 *  @param parameters 请求的参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
- (void)postWithURLString:(NSString *)URLString
               parameters:(nullable id)parameters
                  success:(SuccessBlock)success
                  failure:(FailureBlock)failure;

/**
 *  发送 get/post 网络请求
 *
 *  @param URLString   请求的网址字符串
 *  @param parameters  请求的参数
 *  @param type        请求的类型
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
- (void)requestWithURLString:(NSString *)URLString
                  parameters:(nullable id)parameters
                        type:(HttpRequestType)type
                     success:(SuccessBlock)success
                     failure:(FailureBlock)failure;


/**
 *  上传图片
 *
 *  @param URLString   上传图片的网址字符串
 *  @param parameters  上传图片的参数
 *  @param uploadParams 上传图片的信息
 *  @param success     上传成功的回调
 *  @param failure     上传失败的回调
 */
- (void)uploadWithURLString:(NSString *)URLString
                 parameters:(nullable id)parameters
                uploadParam:(NSArray <UploadParam *> *)uploadParams
                    progress:(ProgressBlock)progress
                    success:(SuccessBlock)success
                    failure:(FailureBlock)failure;

/**
 *  下载数据
 *
 *  @param URLString   下载数据的网址
 *  @param downloadFilePath  存放数据的目录
 *  @param progress  下载数据的进度
 *  @param success     下载成功的回调
 *  @param failure     下载失败的回调
 */
- (void)downLoadWithURLString:(NSString *)URLString
             downloadFilePath:(NSString *)downloadFilePath
                     progress:(ProgressBlock)progress
                      success:(SuccessBlock)success
                      failure:(FailureBlock)failure;

/**
 判断网络状态
 
 @param block 网络状态回调
 */
- (void)setReachabilityStatusChangeBlock:(void(^)(AFNetworkReachabilityStatus status))block;

/**
 停止监测网络状态
 */
- (void)stopMonitoring;

@end

NS_ASSUME_NONNULL_END
