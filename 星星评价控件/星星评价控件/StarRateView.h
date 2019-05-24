//
//  StarRateView.h
//  星星评价控件
//
//  Created by zl on 2019/5/24.
//  Copyright © 2019 ZHUNJIEE. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StarRateView;

NS_ASSUME_NONNULL_BEGIN

typedef void(^finishBlock)(CGFloat currentScore);

typedef NS_ENUM(NSInteger, RateStyle) {
    WholeStar = 0, //只能整星评论
    HalfStar = 1,  //允许半星评论
    IncompleteStar = 2  //允许不完整星评论
};

@protocol XHStarRateViewDelegate <NSObject>

-(void)starRateView:(StarRateView *)starRateView currentScore:(CGFloat)currentScore;

@end


@interface StarRateView : UIView
@property (nonatomic,assign)BOOL isAnimation;       //是否动画显示，默认NO
@property (nonatomic,assign)RateStyle rateStyle;    //评分样式    默认是WholeStar
@property (nonatomic, weak) id<XHStarRateViewDelegate>delegate;

// 直接展示星星评分,不可点击
-(instancetype)initWithFrame:(CGRect)frame currentStarCount:(NSInteger)count;
// 可以进行用户交互的
-(instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars rateStyle:(RateStyle)rateStyle isAnination:(BOOL)isAnimation delegate:(id)delegate;


-(instancetype)initWithFrame:(CGRect)frame finish:(finishBlock)finish;
-(instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars rateStyle:(RateStyle)rateStyle isAnination:(BOOL)isAnimation finish:(finishBlock)finish;
@end

NS_ASSUME_NONNULL_END
