//
//  ZJInfiniteScrollView.h
//  无限循环
//
//  Created by 侯宝伟 on 15/11/12.
//  Copyright © 2015年 ZHUNJIEE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJInfiniteScrollView : UIView
/** 存放图片的数组 */
@property (nonatomic, strong) NSArray *imagesArray;
/** 页码视图 */
@property (nonatomic, weak, readonly) UIPageControl *pageControl;
/** 滚动视图的方向 */
@property (nonatomic, assign, getter=isScrollDirectionPortrait) BOOL scrollDirectionPortrait; // 默认水平方向
@end
