//
//  SharedBgMusic.h
//  BackgroundMusic
//
//  Created by zl on 2019/7/25.
//  Copyright © 2019 ZHUNJIEE. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SharedBgMusic : NSObject
+ (instancetype)sharedInstance;
- (void)playMusic;
- (void)pauseMusic;
- (void)stopMusic;
@end

NS_ASSUME_NONNULL_END
