//
//  SharedBgMusic.m
//  BackgroundMusic
//
//  Created by zl on 2019/7/25.
//  Copyright © 2019 ZHUNJIEE. All rights reserved.
//

#import "SharedBgMusic.h"
#import <AVFoundation/AVFoundation.h>

@interface SharedBgMusic ()
@property (strong, nonatomic) AVAudioPlayer *player;
@end

@implementation SharedBgMusic
static id _instance;

+(instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (id)copyWithZone:(NSZone *)zone {
    return _instance;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return _instance;
}



// -----------
- (instancetype)init {
    if (self = [super init]) {
        [self setupMusic];
    }
    return self;
}

- (void)setupMusic {
    NSURL *voiceUrl = [[NSBundle mainBundle] URLForResource:@"haveorder.mp3" withExtension:nil];
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:voiceUrl error:nil];
    player.volume = 1;
    // 设置为负数单曲循环
    player.numberOfLoops = 0;
    [player prepareToPlay];
    self.player = player;
}

- (void)playMusic {
    if (!self.player) {
        [self setupMusic];
    }
    [self.player play];
}

- (void)pauseMusic {
    [self.player pause];
}

- (void)stopMusic {
    [self.player stop];
    self.player = nil;
}
@end
