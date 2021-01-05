//
//  BWVideoPlayer.h
//  ProjectShortVideo
//
//  Created by Houge on 2020/4/3.
//  Copyright © 2020 QTTX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <PLPlayerKit/PLPlayerKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, BWVideoPlayerStatus) {
    BWVideoPlayerStatusUnload,      // 未加载
    BWVideoPlayerStatusPreparing,   // 正在准备播放组件
    BWVideoPlayerStatusLoading,     // 加载中
    BWVideoPlayerStatusPlaying,     // 播放中
    BWVideoPlayerStatusPaused,      // 暂停
    BWVideoPlayerStatusEnded,       // 播放完成
    BWVideoPlayerStatusError        // 错误
};

@class BWVideoPlayer;
@protocol BWVideoPlayerDelegate <NSObject>
@optional

/// 播放状态改变
- (void)player:(BWVideoPlayer *)player statusChanged:(BWVideoPlayerStatus)status;

/// 播放进度
- (void)player:(BWVideoPlayer *)player currentTime:(float)currentTime totalTime:(float)totalTime progress:(float)progress;

/// 音视频渲染首帧回调通知
- (void)player:(BWVideoPlayer *)player firstRender:(PLPlayerFirstRenderType)firstRenderType;

@end


@interface BWVideoPlayer : NSObject <PLPlayerDelegate>

@property (weak, nonatomic) id<BWVideoPlayerDelegate> delegate;
@property (assign, nonatomic, readonly) BWVideoPlayerStatus status;     // 播放状态
@property (assign, nonatomic, readonly) BOOL isPlaying;                 // 是否正在播放
@property (nonatomic, assign, getter=isMute) BOOL mute;                 // 是否需要静音，默认值为NO

/// 根据指定url在指定视图上播放视频
/// @param playView 播放视图
/// @param videoUrl 视频地址
/// @param launchImgUrl 占位图地址
- (BOOL)playVideoWithView:(UIView *)playView videoUrl:(NSString *)videoUrl launchImageUrl:(NSString *)launchImgUrl;

/// 播放音频
/// @param audioUrl 音频url地址
- (BOOL)playAudioWithUrl:(NSString *)audioUrl;

/// 开始播放
- (BOOL)startPlay;
/// 暂停播放
- (void)pausePlay;
/// 恢复播放
- (void)resumePlay;
/// 重新播放
- (void)resetPlay;
/// 停止播放,销毁播放器
- (void)stopPlay;

@end

NS_ASSUME_NONNULL_END
