//
//  NSString+fileSize.h
//  fileSize
//
//  Created by 侯宝伟 on 15/11/8.
//  Copyright © 2015年 ZHUNJIEE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (fileSize)

- (unsigned long long)fileSize;

- (NSString *)fileSizeString;
@end
