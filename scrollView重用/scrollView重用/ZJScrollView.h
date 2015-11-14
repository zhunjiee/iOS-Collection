//
//  ZJScrollView.h
//  scrollView重用
//
//  Created by 侯宝伟 on 15/11/14.
//  Copyright © 2015年 ZHUNJIEE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJScrollView : UIView
/** 存放图片的数组 */
@property (nonatomic, strong) NSArray *imagesArray;
/** 页码视图 */
@property (nonatomic, weak, readonly) UIPageControl *pageControl;
@end
