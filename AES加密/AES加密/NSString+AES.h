//
//  NSString+AES.h
//  AES加密
//
//  Created by 侯宝伟 on 2019/3/23.
//  Copyright © 2019 zhunjiee. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (AES)
/**< 加密方法 */
- (NSString*)aci_encryptWithAES;

/**< 解密方法 */
- (NSString*)aci_decryptWithAES;
@end

NS_ASSUME_NONNULL_END
