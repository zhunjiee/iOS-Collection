//
//  UIView+RoundedCorners.m
//  MengTianXia
//
//  Created by zl on 2019/8/9.
//  Copyright © 2019 qttx. All rights reserved.
//

#import "UIView+RoundedCorners.h"

@implementation UIView (RoundedCorners)

- (void)clipRoundedCorners:(UIRectCorner)corners withRadii:(CGSize)radii {
    UIBezierPath *rounded = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:radii];
    CAShapeLayer *shape = [CAShapeLayer layer];
    shape.path = rounded.CGPath;
    self.layer.mask = shape;
}

- (void)clipRoundedCorners:(UIRectCorner)corners withRadii:(CGSize)radii withRect:(CGRect)rect {
    UIBezierPath *rounded = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radii];
    CAShapeLayer *shape = [CAShapeLayer layer];
    shape.path = rounded.CGPath;
    self.layer.mask = shape;
}

@end
