//
//  BWClearCachesCell.m
//  BWClearCaches
//
//  Created by 侯宝伟 on 15/10/13.
//  Copyright © 2015年 ZHUNJIEE. All rights reserved.
//

#import "BWClearCachesCell.h"
#import "NSString+Extension.h"

@interface BWClearCachesCell ()
/** 圈圈 */
@property (nonatomic, weak) UIActivityIndicatorView *loadingView;
@end

@implementation BWClearCachesCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 创建圈圈
        UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [loadingView startAnimating];
        self.loadingView = loadingView;
        
        self.textLabel.text = @"清除缓存";
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        [self getCachesSize];
    }
    return self;
}


- (void)getCachesSize{
    // 创建异步线程计算图片缓存
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSString *file = [caches stringByAppendingString:@"default/com.hackemist.SDWebImageCache.default"];
        
        NSString *fileSize = [file fileSizeString];
        
        NSString *text = [NSString stringWithFormat:@"清除缓存(%@)", fileSize];
        
        // 回到主线程设置文字
        dispatch_async(dispatch_get_main_queue(), ^{
            self.textLabel.text = text;
            
            // 删除圈圈
            [self.loadingView removeFromSuperview];
        });
    });
    
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.textLabel sizeToFit];
    CGRect tempFrame = self.textLabel.frame;
    tempFrame.size.height = self.contentView.bounds.size.height;
    self.textLabel.frame = tempFrame;
    
}

- (void)reset{
    self.textLabel.text = @"清除缓存(0B)";
}
@end
