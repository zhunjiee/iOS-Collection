//
//  BWVideoPlayer.m
//  ProjectShortVideo
//
//  Created by Houge on 2020/4/3.
//  Copyright © 2020 QTTX. All rights reserved.
//

#import "BWVideoPlayer.h"
#import <Masonry/Masonry.h>

@interface BWVideoPlayer ()
@property (strong, nonatomic) PLPlayer *player;             // 播放器
@property (assign, nonatomic) BOOL isNeedResume;            // 是否需要继续播放
@property (nonatomic, strong) NSTimer *playTimer;           // 定时器
@property (assign, nonatomic) BWVideoPlayerStatus status;   // 播放状态
@property (assign, nonatomic) BOOL isPlaying;               // 是否正在播放
@property (assign, nonatomic) float totalSeconds;           // 播放时长,用于计算播放进度
@end


@implementation BWVideoPlayer

#pragma mark - 初始化

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addNotificationObserver];
    }
    return self;
}

- (void)dealloc {
    [self removeTimer];
    [self removeNotificationObserver];
}

/// 创建播放器
/// @param url 视频地址
- (void)setupPlayerWithUrl:(NSString *)url {
    // 创建新的播放器实例可以避免切换视频后出现上一个视频画面的bug
    // 播放器设置
    PLPlayerOption *option = [PLPlayerOption defaultOption];
    PLPlayFormat format = kPLPLAY_FORMAT_UnKnown;
    NSString *urlStr = url.lowercaseString;
    if ([urlStr hasSuffix:@"mp4"]) {
        format = kPLPLAY_FORMAT_MP4;
    } else if ([urlStr hasPrefix:@"rtmp:"]) {
        format = kPLPLAY_FORMAT_FLV;
    } else if ([urlStr hasSuffix:@".mp3"]) {
        format = kPLPLAY_FORMAT_MP3;
    } else if ([urlStr hasSuffix:@".m3u8"]) {
        format = kPLPLAY_FORMAT_M3U8;
    }
    [option setOptionValue:@(format) forKey:PLPlayerOptionKeyVideoPreferFormat];
    [option setOptionValue:@(kPLLogNone) forKey:PLPlayerOptionKeyLogLevel];
    
    // 播放器
    self.player = [PLPlayer playerWithURL:[NSURL URLWithString:url] option:option];
    self.player.delegateQueue = dispatch_get_main_queue();
    self.player.launchView.contentMode = UIViewContentModeScaleAspectFit;
    self.player.playerView.contentMode = UIViewContentModeScaleAspectFit;
    self.player.delegate = self;
    self.player.loopPlay = YES;   // 涉及播放时长重复上传问题,所以不循环播放,播放完成后手动再开启播放
}


#pragma mark - 公共方法

- (BOOL)playVideoWithView:(UIView *)playView videoUrl:(NSString *)videoUrl launchImageUrl:(NSString *)launchImgUrl {
    // 销毁旧播放器
    if (self.player) {
        [self stopPlay];
    }
    // 创建新播放器
    [self setupPlayerWithUrl:videoUrl];

    // 添加播放器视图
    [playView insertSubview:self.player.playerView atIndex:0];
    [self.player.playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(playView);
    }];
    // 添加启动图, 只在播放第一帧的时候显示, 正常还是黑屏, 不好用
//    [self.player.launchView sd_setImageWithURL:[NSURL URLWithString:launchImgUrl] placeholderImage:[UIImage imageNamed:@"img_video_loading"]];

    return [self startPlay];
}


- (BOOL)playAudioWithUrl:(NSString *)audioUrl {
    // 销毁旧播放器
    if (self.player) {
        [self stopPlay];
    }
    // 创建新播放器
    [self setupPlayerWithUrl:audioUrl];

    return [self startPlay];
}

- (BOOL)startPlay {
    
    BOOL result = [self.player play];
    if (result) {
        [self addTimer];
    }
    return result;
}

- (void)pausePlay {
    if (self.player.isPlaying) {
        [self.player pause];
        [self pauseTimer];
    }
}

- (void)resumePlay {
    if (!self.player.isPlaying) {
        [self.player resume];
        [self resumeTimer];
    }
}

- (void)resetPlay {
    [self.player seekTo:kCMTimeZero];
}

- (void)stopPlay {
    // 停止播放
    [self.player stop];
    [self.player.playerView removeFromSuperview];
    self.player.launchView.image = nil;
    [self removeTimer];
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];    // 取消屏幕常亮
}

- (BOOL)isPlaying {
    return self.player.isPlaying;
}


#pragma mark - 私有方法

/// 改变播放状态
- (void)playerStatusChanged:(BWVideoPlayerStatus)status {
    self.status = status;
    if ([self.delegate respondsToSelector:@selector(player:statusChanged:)]) {
        [self.delegate player:self statusChanged:status];
    }
}


#pragma mark - 添加定时器,监听播放进度

- (void)addTimer {
    [self removeTimer];
    self.playTimer = [NSTimer timerWithTimeInterval:0.5f target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.playTimer forMode:NSRunLoopCommonModes];
}

/// 暂停定时器
- (void)pauseTimer {
    if (self.playTimer) {
        [self.playTimer setFireDate:[NSDate distantFuture]];
        self.totalSeconds = 0.0;
    }
}

/// 继续定时器
- (void)resumeTimer {
    if (self.playTimer) {
        [self.playTimer setFireDate:[NSDate distantPast]];
    }
}

- (void)removeTimer {
    if (self.playTimer) {
        [self.playTimer invalidate];
        self.playTimer = nil;
    }
}

- (void)timerAction {
    if (self.totalSeconds != 0) {
        float currentSeconds = CMTimeGetSeconds(self.player.currentTime);
        float progress = currentSeconds / self.totalSeconds;
        if ([self.delegate respondsToSelector:@selector(player:currentTime:totalTime:progress:)]) {
            [self.delegate player:self currentTime:currentSeconds totalTime:self.totalSeconds progress:progress];
        }
    }
    
//    if (CMTimeGetSeconds(self.player.totalDuration)) {
//        int duration = currentSeconds + .5;
//        int hour = duration / 3600;
//        int min  = (duration % 3600) / 60;
//        int sec  = duration % 60;
//    }
}

#pragma mark - PLPlayerDelegate

/// 播放器状态变更
- (void)player:(PLPlayer *)player statusDidChange:(PLPlayerStatus)state {
//    NSLog(@"播放器状态改变 ---------------- %ld", (long)state);
    switch (state) {
        // 未加载
        case PLPlayerStatusUnknow:{
            [self playerStatusChanged:BWVideoPlayerStatusUnload];
        }
            break;
        // 准备播放组件
        case PLPlayerStatusPreparing:{
            [self playerStatusChanged:BWVideoPlayerStatusPreparing];
        }
            break;
        // 加载中
        case PLPlayerStatusReady:{
            [self playerStatusChanged:BWVideoPlayerStatusLoading];
            self.totalSeconds = CMTimeGetSeconds(self.player.totalDuration);
        }
            break;
        case PLPlayerStatusOpen:{
            [self playerStatusChanged:BWVideoPlayerStatusLoading];
        }
            break;
        case PLPlayerStatusCaching:{
            [self playerStatusChanged:BWVideoPlayerStatusLoading];
        }
            break;
        // 正在播放
        case PLPlayerStatusPlaying:{
            [self playerStatusChanged:BWVideoPlayerStatusPlaying];
        }
            break;
        // 暂停
        case PLPlayerStatusPaused:{
            [self playerStatusChanged:BWVideoPlayerStatusPaused];
        }
            break;
        // 播放完成
        case PLPlayerStatusCompleted:{
            [self playerStatusChanged:BWVideoPlayerStatusEnded];
        }
            break;
        // 出错
        case PLPlayerStatusError:{
            [self playerStatusChanged:BWVideoPlayerStatusError];
        }
            break;
            
        default:{
            [self playerStatusChanged:BWVideoPlayerStatusUnload];
        }
            break;
    }
    
}

/// 音视频渲染首帧回调通知
- (void)player:(nonnull PLPlayer *)player firstRender:(PLPlayerFirstRenderType)firstRenderType {
    if ([self.delegate respondsToSelector:@selector(player:firstRender:)]) {
        [self.delegate player:self firstRender:firstRenderType];
    }
}

/// seekTo 完成的回调通知
- (void)player:(nonnull PLPlayer *)player seekToCompleted:(BOOL)isCompleted {
    if (isCompleted) {
        [self.player play];
    }
}

/// 即将开始进入后台播放任务
- (void)playerWillBeginBackgroundTask:(nonnull PLPlayer *)player {
    NSLog(@"即将开始进入后台播放任务");
}

/// 即将结束后台播放状态任务
- (void)playerWillEndBackgroundTask:(nonnull PLPlayer *)player {
    NSLog(@"即将结束后台播放状态任务");
}


#pragma mark - 通知监听

/// 监听APP退出后台及进入前台
- (void)addNotificationObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
}

/// 移除监听
- (void)removeNotificationObserver {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillEnterForegroundNotification object:nil];
}

/// APP进入后台
- (void)appDidEnterBackground:(NSNotification *)notification {
    if ([self.player isPlaying]) {
        [self pausePlay];
        self.isNeedResume = YES;
    }
}

/// APP即将进入前台
- (void)appWillEnterForeground:(NSNotification *)notification {
    if (self.isNeedResume) {
        self.isNeedResume = NO;
        
        [[AVAudioSession sharedInstance] setActive:YES error:nil];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self resumePlay];
        });
    }
}


@end
