//
//  ViewController.m
//  QiNiuVideoPlayer
//
//  Created by Houge on 2020/6/22.
//  Copyright © 2020 QTTX. All rights reserved.
//

#import "ViewController.h"
#import <PLPlayerKit/PLPlayerKit.h>
#import <Masonry/Masonry.h>

@interface ViewController ()<PLPlayerDelegate>
// 播放器
@property (strong, nonatomic) PLPlayer *player;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupPlayerWithUrl:@"http://ssj.qdunzi.cn/video/46/1592624012679.mp4"];
}

/// 创建播放器
/// @param url 视频地址
- (void)setupPlayerWithUrl:(NSString *)url {
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
    self.player.loopPlay = YES;
    
    // 添加播放器视图
    [self.view insertSubview:self.player.playerView atIndex:0];
    [self.player.playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    [self.player play];
}

/// 播放器状态变更
- (void)player:(PLPlayer *)player statusDidChange:(PLPlayerStatus)state {
    NSLog(@"播放器状态改变 ---------------- %ld", (long)state);
}

@end
