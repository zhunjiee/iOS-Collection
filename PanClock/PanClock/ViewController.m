//
//  ViewController.m
//  PanClock
//
//  Created by Houge on 2021/3/2.
//

#import "ViewController.h"

#define BWColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

@interface ViewController ()
@property (strong, nonatomic) UIView *clockView;
@property (strong, nonatomic) UIView *hourView;
@property (strong, nonatomic) UIView *minuteView;
@property (strong, nonatomic) UIView *secondView;
@end

@implementation ViewController

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
}

- (void)initView {
    self.view.backgroundColor = [UIColor orangeColor];
    
    self.clockView.center = self.view.center;
    
    self.hourView.transform = CGAffineTransformMakeRotation(-M_PI_2);
    self.minuteView.transform = CGAffineTransformMakeRotation(-M_PI_2);
    self.secondView.transform = CGAffineTransformMakeRotation(-M_PI_2);
}

#pragma mark - 事件监听

- (void)panAction:(UIPanGestureRecognizer *)pan {
    UIView *clockView = pan.view.superview;
    // 返回在父视图中的原始坐标点
    CGPoint tranP = [pan locationInView:clockView];
    // 转换成标准直角坐标系
    CGFloat x = tranP.x - 0.5 * clockView.frame.size.width;
    CGFloat y = 0;
    if (y <= 0.5 * clockView.frame.size.height) {
        y = 0.5 * clockView.frame.size.height - tranP.y;
    } else {
        y = tranP.y - clockView.frame.size.height;
    }
    NSLog(@"x = %f, y = %f", x, y);
    // 计算角度
    double angle = atan2(y, x);
    // 旋转
    pan.view.transform = CGAffineTransformMakeRotation(-angle);
}


#pragma mark - 懒加载
- (UIView *)clockView {
    if (!_clockView) {
        _clockView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 400, 400)];
        _clockView.backgroundColor = BWColor(135, 206, 250);
        _clockView.layer.cornerRadius = _clockView.frame.size.width * 0.5;
        _clockView.layer.masksToBounds = YES;
        [_clockView addSubview:self.hourView];
        [_clockView addSubview:self.minuteView];
        [_clockView addSubview:self.secondView];
        [self.view addSubview:_clockView];
    }
    return _clockView;
}

- (UIView *)hourView {
    if (!_hourView) {
        _hourView = [[UIView alloc] initWithFrame:CGRectMake(0, (self.clockView.frame.size.width -16) * 0.5, self.clockView.frame.size.width * 0.3, 16)];
        _hourView.backgroundColor = BWColor(105, 105, 105);
        _hourView.layer.position = self.clockView.center;
        _hourView.layer.anchorPoint = CGPointMake(0.0, 0.5);
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
        [_hourView addGestureRecognizer:pan];
    }
    return _hourView;
}

- (UIView *)minuteView {
    if (!_minuteView) {
        _minuteView = [[UIView alloc] initWithFrame:CGRectMake(0, (self.clockView.frame.size.width -8) * 0.5, self.clockView.frame.size.width * 0.4, 8)];
        _minuteView.backgroundColor = BWColor(144, 238, 144);
        _minuteView.layer.position = self.clockView.center;
        _minuteView.layer.anchorPoint = CGPointMake(0.0, 0.5);
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
        [_minuteView addGestureRecognizer:pan];
    }
    return _minuteView;
}

- (UIView *)secondView {
    if (!_secondView) {
        _secondView = [[UIView alloc] initWithFrame:CGRectMake(0, (self.clockView.frame.size.width -4) * 0.5, self.clockView.frame.size.width * 0.5, 4)];
        _secondView.backgroundColor = BWColor(148, 0, 211);
        _secondView.layer.position = self.clockView.center;
        _secondView.layer.anchorPoint = CGPointMake(0.0, 0.5);
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
        [_secondView addGestureRecognizer:pan];
    }
    return _secondView;
}

@end
