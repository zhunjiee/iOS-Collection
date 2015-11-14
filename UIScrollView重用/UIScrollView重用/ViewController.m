//
//  ViewController.m
//  UIScrollView重用
//
//  Created by 侯宝伟 on 15/11/13.
//  Copyright © 2015年 ZHUNJIEE. All rights reserved.
//

#import "ViewController.h"

#define kScreenW [[UIScreen mainScreen] bounds].size.width
#define kScreenH [[UIScreen mainScreen] bounds].size.height
#define kImageViewCount 3

#define BSRandomColor [UIColor colorWithRed:(arc4random_uniform(255)/255.0) green:(arc4random_uniform(255)/255.0) blue:(arc4random_uniform(255)/255.0) alpha:(arc4random_uniform(100)/100.0)];

@interface ViewController () <UIScrollViewDelegate>
/** 滚动视图 */
@property (nonatomic, weak) UIScrollView *scrollView;
/** 页码视图 */
@property (nonatomic, weak) UIPageControl *pageControl;

@property (nonatomic, weak) UIImageView *mainImageView;
@property (nonatomic, weak) UIImageView *leftImageView;
@property (nonatomic, weak) UIImageView *rightImageView;

/** 图片索引 */
@property (nonatomic, assign) NSInteger index;

/** 存放图片的数组 */
@property (nonatomic, strong) NSArray *imageArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageArray = @[
                        [UIImage imageNamed:@"1"],
                        [UIImage imageNamed:@"2"],
                        [UIImage imageNamed:@"3"],
                        [UIImage imageNamed:@"4"]
                        ];

    [self setUpScrollView];
    
    [self setUpDefaultInfo];
}

- (void)setUpScrollView{
    // scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.frame = CGRectMake(0, 0, kScreenW, kScreenH);
    scrollView.contentSize = CGSizeMake(kScreenW * kImageViewCount, 0);
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    scrollView.backgroundColor = [UIColor redColor];
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    // imageView
    [self setUpImageView];
    
    // pageControl
    [self setUpPageControl];
}

- (void)setUpImageView{
    UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:self.scrollView.frame];
    [self.scrollView addSubview:leftImageView];
    self.leftImageView = leftImageView;
    
    UIImageView *mainImageView = [[UIImageView alloc] initWithFrame:self.scrollView.frame];
    [self.scrollView addSubview:mainImageView];
    self.mainImageView = mainImageView;
    
    UIImageView *rightImageView = [[UIImageView alloc] initWithFrame:self.scrollView.frame];
    [self.scrollView addSubview:rightImageView];
    self.rightImageView = rightImageView;
}

- (void)setUpPageControl{
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = self.imageArray.count;
    CGFloat pageW = 80;
    CGFloat pageH = 20;
    CGFloat pageX = self.scrollView.frame.size.width - pageW;
    CGFloat pageY = self.scrollView.frame.size.height - pageH;
    pageControl.frame = CGRectMake(pageX, pageY, pageW, pageH);
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
}


- (void)setInfoByIndex:(NSInteger)index{
    NSInteger count = self.imageArray.count;
    NSLog(@"%zd", count);
    self.mainImageView.image = self.imageArray[index];
    self.leftImageView.image = self.imageArray[(index - 1 + count) % count];
    self.rightImageView.image = self.imageArray[(index + 1) % count];
    
    self.pageControl.currentPage = index;
}

- (void)setUpDefaultInfo{
    self.index = 0;
    [self setInfoByIndex:self.index];
}

- (void)reloadImage{
    NSInteger count = self.imageArray.count;
    CGPoint contentOffset = [self.scrollView contentOffset];
    NSLog(@"%f", contentOffset.x);
    if (contentOffset.x >= kScreenW) { // 向左滑动
        self.index = (self.index + 1) % count;
    }else if (contentOffset.x < kScreenW){ // 向右滑动
        self.index = (self.index - 1 + count) % count;
    }
    
    [self setInfoByIndex:self.index];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self reloadImage];
    
    self.scrollView.contentOffset = CGPointMake(kScreenW, 0);

    self.pageControl.currentPage = self.index;
}


@end
