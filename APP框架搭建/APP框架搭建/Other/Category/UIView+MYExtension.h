//
//  UIView+MYExtension.h
//  APP框架搭建
//
//  Created by 侯宝伟 on 2019/3/1.
//  Copyright © 2019 zhunjiee. All rights reserved.
//



NS_ASSUME_NONNULL_BEGIN

@interface UIView (MYExtension)
@property(nonatomic, assign) CGFloat x;
@property(nonatomic, assign) CGFloat y;
@property(nonatomic, assign) CGFloat width;
@property(nonatomic, assign) CGFloat height;
@property(nonatomic, assign) CGFloat centerX;
@property(nonatomic, assign) CGFloat centerY;


/** 控件上部边线的位置(minY的位置) */
@property (nonatomic, assign) CGFloat top;
/** 控件底部边线的位置(maxY的位置) */
@property (nonatomic, assign) CGFloat bottom;
/** 控件左部边线的位置(minX的位置) */
@property (nonatomic, assign) CGFloat left;
/** 控件右部边线的位置(maxX的位置) */
@property (nonatomic, assign) CGFloat right;


/**
 *  从xib中加载控件(xib必须和类名一致)
 *
 *  @return xib路径
 */
+ (instancetype)viewFromXib;
@end

NS_ASSUME_NONNULL_END
