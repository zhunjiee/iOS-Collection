//
//  Singleton.h
//  单例
//
//  Created by Houge on 2020/1/12.
//  Copyright © 2020 ZHUNJIEE. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Singleton : NSObject
+(instancetype)shareInstance;
@end

NS_ASSUME_NONNULL_END
