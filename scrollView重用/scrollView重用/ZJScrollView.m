//
//  ZJScrollView.m
//  scrollView重用
//
//  Created by 侯宝伟 on 15/11/14.
//  Copyright © 2015年 ZHUNJIEE. All rights reserved.
//

#import "ZJScrollView.h"

#define kImageViewCount 3

@interface ZJScrollView () <UIScrollViewDelegate>
/** 滚动视图 */
@property (nonatomic, weak) UIScrollView *scrollView;
@end

@implementation ZJScrollView
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
        for (int i = 0; i < kImageViewCount; i++) {
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
    self.scrollView.contentSize = CGSizeMake(kImageViewCount * self.bounds.size.width, 0);
    
    // 设置imageView的frame
    for (int i = 0; i < kImageViewCount; i++) {
        UIImageView *imageView = self.scrollView.subviews[i];
        
        imageView.frame = CGRectMake(i * self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height);
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
    
}

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
    self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // 找出最中间的那个图片控件
    NSInteger page = 0;
    CGFloat minDistance = MAXFLOAT;
    for (int i = 0; i < self.scrollView.subviews.count; i++) {
        UIImageView *imageView = self.scrollView.subviews[i];
        CGFloat distance = 0;
        
        distance = ABS(imageView.frame.origin.x - scrollView.contentOffset.x);
        
        if (distance < minDistance) {
            minDistance = distance;
            page = imageView.tag;
        }
    }
    self.pageControl.currentPage = page;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self updateContent];
}
@end
