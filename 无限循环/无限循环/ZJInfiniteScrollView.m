//
//  ZJInfiniteScrollView.m
//  无限循环
//
//  Created by 侯宝伟 on 15/11/12.
//  Copyright © 2015年 ZHUNJIEE. All rights reserved.
//

#import "ZJInfiniteScrollView.h"

static int const ImageViewCount = 3;

@interface ZJInfiniteScrollView () <UIScrollViewDelegate>
/** 滚动视图 */
@property (nonatomic, weak) UIScrollView *scrollView;
/** 定时器 */
@property (nonatomic, weak) NSTimer *timer;
@end

@implementation ZJInfiniteScrollView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        // 滚动视图
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.pagingEnabled = YES;
        scrollView.bounces = NO; // 控件遇到边框是否反弹
        scrollView.delegate = self;
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
        // 图片控件
        for (int i = 0; i < ImageViewCount; i++) {
            UIImageView *imageView = [[UIImageView alloc] init];
            [scrollView addSubview:imageView];
        }
        
        // 页码视图
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        [self addSubview:pageControl];
        _pageControl = pageControl;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    // 设置scrollView的frame
    self.scrollView.frame = self.bounds;
    
    // 设置scrollView的contentSize
    if (self.isScrollDirectionPortrait) { // 竖直方向
        self.scrollView.contentSize = CGSizeMake(0, ImageViewCount * self.bounds.size.height);
    }else{ // 水平方向
        self.scrollView.contentSize = CGSizeMake(ImageViewCount * self.bounds.size.width, 0);
    }
    
    // 设置imageView的frame
    for (int i = 0; i < ImageViewCount; i++) {
        UIImageView *imageView = self.scrollView.subviews[i];
        
        if (self.isScrollDirectionPortrait) {
            imageView.frame = CGRectMake(0, i * self.bounds.size.height, self.bounds.size.width, self.bounds.size.height);
        }else{
            imageView.frame = CGRectMake(i * self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height);
        }
    }
    
    // 设置pageControl的frame
    CGFloat pageW = 80;
    CGFloat pageH = 20;
    CGFloat pageX = self.scrollView.frame.size.width - pageW;
    CGFloat pageY = self.scrollView.frame.size.height - pageH;
    self.pageControl.frame = CGRectMake(pageX, pageY, pageW, pageH);
    
    [self updateContent];
}


- (void)setImagesArray:(NSArray *)imagesArray{
    _imagesArray = imagesArray;
    
    // 设置页码
    self.pageControl.numberOfPages = imagesArray.count;
    self.pageControl.currentPage = 0;
    
    // 设置内容
    [self updateContent];
    
    // 开始定时器
//    [self startTimer];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // 找出最中间的那个图片控件
    NSInteger page = 0;
    CGFloat minDistance = MAXFLOAT;
    for (int i = 0; i < self.scrollView.subviews.count; i++) {
        UIImageView *imageView = self.scrollView.subviews[i];
        CGFloat distance = 0;
        if (self.isScrollDirectionPortrait) {
            distance = ABS(imageView.frame.origin.y - scrollView.contentOffset.y);
        }else{
            distance = ABS(imageView.frame.origin.x - scrollView.contentOffset.x);
        }
        if (distance < minDistance) {
            minDistance = distance;
            page = imageView.tag;
        }
    }
    self.pageControl.currentPage = page;
}

//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//    [self stopTimer];
//}
//
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//    [self startTimer];
//}
//
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    [self updateContent];
//}
//
//- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
//    [self updateContent];
//}

#pragma mark - 内容更新
- (void)updateContent{
    
    // 设置图片
    for (int i = 0; i < self.scrollView.subviews.count; i++) {
        UIImageView *imageView = self.scrollView.subviews[i];
        
        NSInteger index = self.pageControl.currentPage;
        
        if (i == 0) {
            index--;
        }else if (i == 2){
            index++;
        }
        
        if (index < 0) {
            index = self.pageControl.numberOfPages - 1;
        }else if (index >= self.pageControl.numberOfPages) {
            index = 0;
        }
        
        imageView.tag = index;
        imageView.image = self.imagesArray[index];
    }
    
    // 设置偏移量在中间的位置
    if (self.isScrollDirectionPortrait) {
        self.scrollView.contentOffset = CGPointMake(0, self.scrollView.frame.size.height);
    }else{
        self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
    }
}

#pragma mark - 定时器相关
// 开启定时器
- (void)startTimer{
    NSTimer *timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(next) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
}

// 停止定时器
- (void)stopTimer{
    [self.timer invalidate];
    self.timer = nil;
}

// 下一张
- (void)next{
    if (self.isScrollDirectionPortrait) {
        [self.scrollView setContentOffset:CGPointMake(0, 2 * self.scrollView.frame.size.height) animated:YES];
    }else{
        [self.scrollView setContentOffset:CGPointMake(2 * self.scrollView.frame.size.width, 0) animated:YES];
    }
}
@end
