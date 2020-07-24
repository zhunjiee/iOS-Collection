//
//  HttpRequest.m
//  AFNetworking封装
//
//  Created by 侯宝伟 on 2019/3/30.
//  Copyright © 2019 zhunjiee. All rights reserved.
//

#import "HttpRequest.h"

@implementation HttpRequest

#pragma mark - 初始化(单例)

static id _instance = nil;
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}
- (id)copyWithZone:(NSZone *)zone {
    return _instance;
}
-(id)mutableCopyWithZone:(NSZone *)zone {
    return _instance;
}
- (instancetype)init {
    if (self = [super init]) {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.operationQueue.maxConcurrentOperationCount = 5;       // 最大并发数
        manager.requestSerializer.timeoutInterval = 60;     // 请求超时时间
        self.manager = manager;
    }
    return self;
}


#pragma mark - GET请求
- (void)getWithURLString:(NSString *)URLString
              parameters:(id)parameters
                 success:(SuccessBlock)success
                 failure:(FailureBlock)failure {
    // 判断url字符串是否为空
    if (URLString.length == 0) {
        failure(CustomErrorCode, @"传入的url为空");
        return;
    }
    // 拼接url
    NSString *url = [NSString stringWithFormat:@"%@%@", API_Base_Url, URLString];
    // 创建 请求头 字典
    NSDictionary *headerDict = [NSDictionary dictionaryWithObject:BWCheckString([BWUserDefaults getToken]) forKey:@"token"];

    NSLog(@"url = %@", url);
    NSLog(@"parameters = %@", parameters);
    BWeakSelf;
    [self.manager GET:url parameters:parameters headers:headerDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 请求成功
        [weakSelf handleResponseObject:responseObject success:success failure:failure];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 请求失败
        failure(CustomErrorCode, @"网络连接错误~");
        NSLog(@"error: %@", error);
    }];
}


#pragma mark - POST请求
- (void)postWithURLString:(NSString *)URLString
               parameters:(id)parameters
                  success:(SuccessBlock)success
                  failure:(FailureBlock)failure {
    // 判断url字符串是否为空
    if (URLString.length == 0) {
        failure(CustomErrorCode, @"传入的url为空");
        return;
    }
    // 拼接url
    NSString *url = [NSString stringWithFormat:@"%@%@", API_Base_Url, URLString];
    // 创建 请求头 字典
    NSDictionary *headerDict = [NSDictionary dictionaryWithObject:BWCheckString([BWUserDefaults getToken]) forKey:@"token"];
    
    NSLog(@"url = %@", url);
    NSLog(@"parameters = %@", parameters);
    BWeakSelf;
    [self.manager POST:url parameters:parameters headers:headerDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 请求成功
        [weakSelf handleResponseObject:responseObject success:success failure:failure];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 请求失败
        failure(CustomErrorCode, @"网络连接错误~");
        NSLog(@"error: %@", error);
    }];
}

/// 服务器返回结果统一处理方法
/// @param responseObject 返回结果
- (void)handleResponseObject:(id)responseObject success:(SuccessBlock)success failure:(FailureBlock)failure {
    NSString *responseCode = [NSString stringWithFormat:@"%@", responseObject[@"code"]];
    if ([responseCode isEqualToString:@"1"]) {
        // 结果正确
        if ([[responseObject allKeys] containsObject:@"data"]) {
            if ([responseObject[@"data"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *dataDict = responseObject[@"data"];
                success(dataDict);
            } else if ([responseObject[@"data"] isKindOfClass:[NSArray class]]) {
                NSArray *dataArray = responseObject[@"data"];
                success(dataArray);
            } else {
                success(responseObject);
            }
        } else {
            success(responseObject);
        }
    } else if ([responseCode isEqualToString:@"-100"]) {
        //token失效 退出登录
        [BWUserDefaults saveLoginState:NO];
        failure(responseCode, @"登录过期, 请重新登录");
    } else {
        // 结果出错
        NSString *errorText = [NSString stringWithFormat:@"%@", responseObject[@"message"]];
        failure(responseCode, errorText);
    }
}


#pragma mark - POST/GET网络请求

- (void)requestWithURLString:(NSString *)URLString
                  parameters:(id)parameters
                        type:(HttpRequestType)type
                     success:(SuccessBlock)success
                     failure:(FailureBlock)failure {

    switch (type) {
        case HttpRequestTypeGet:
        {
            [self getWithURLString:URLString parameters:parameters success:success failure:failure];
        }
            break;
        case HttpRequestTypePost:
        {
            [self postWithURLString:URLString parameters:parameters success:success failure:failure];
        }
            break;
    }
}

#pragma mark - 上传文件

- (void)uploadWithURLString:(NSString *)URLString
                 parameters:(id)parameters
                uploadParam:(NSArray<UploadParam *> *)uploadParams
                   progress:(ProgressBlock)progress
                    success:(SuccessBlock)success
                    failure:(FailureBlock)failure {
    // 判断url字符串是否为空
    if (URLString.length == 0) {
        failure(CustomErrorCode, @"传入的url为空");
        return;
    }
    // 拼接url
    NSString *url = [NSString stringWithFormat:@"%@%@", API_Base_Url, URLString];
    // 创建 请求头 字典
    NSDictionary *headerDict = [NSDictionary dictionaryWithObject:BWCheckString([BWUserDefaults getToken]) forKey:@"token"];
    
    [self.manager POST:url parameters:parameters headers:headerDict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (UploadParam *uploadParam in uploadParams) {
            [formData appendPartWithFileData:uploadParam.data name:uploadParam.name fileName:uploadParam.filename mimeType:uploadParam.mimeType];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(CustomErrorCode, @"上传失败!!!");
        NSLog(@"error: %@", error);
    }];
}


#pragma mark - 下载数据
- (void)downLoadWithURLString:(NSString *)URLString
             downloadFilePath:(NSString *)downloadFilePath
                     progress:(ProgressBlock)progress
                      success:(SuccessBlock)success
                      failure:(FailureBlock)failure {
    
    NSString *url = [NSString stringWithFormat:@"%@%@", API_Base_Url, URLString];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    NSURLSessionDownloadTask *downLoadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        if (progress) {
            progress(downloadProgress);
        }
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        // 拼接缓存目录
        NSString *downloadPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:downloadFilePath ? downloadFilePath : @"Download"];
        // 打开文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        // 创建Download目录
        [fileManager createDirectoryAtPath:downloadPath withIntermediateDirectories:YES attributes:nil error:nil];
        // 拼接文件路径
        NSString *filePath = [downloadPath stringByAppendingPathComponent:response.suggestedFilename];
        // 返回文件位置的URL路径
        return [NSURL fileURLWithPath:filePath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        failure(CustomErrorCode, @"下载失败!!!");
        NSLog(@"error: %@", error);
    }];
    [downLoadTask resume];
}


#pragma mark - 网络状态监测
- (void)setReachabilityStatusChangeBlock:(void(^)(AFNetworkReachabilityStatus status))block {
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
                // 未知网络
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络");
                break;
                // 没有网络
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"没有网络");
                break;
                // 手机自带网络
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"当前使用的是2G/3G/4G网络");
                break;
                // WIFI
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"当前在WIFI网络下");
                break;
        }
        if (block) {
            block(status);
        }
    }];
}

- (void)stopMonitoring {
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager stopMonitoring];
}

@end
