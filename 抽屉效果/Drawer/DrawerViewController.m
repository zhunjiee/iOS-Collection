//
//  DrawerViewController.m
//  Drawer
//
//  Created by 侯宝伟 on 15/10/6.
//  Copyright © 2015年 ZHUNJIEE. All rights reserved.
//

#import "DrawerViewController.h"

#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height
@interface DrawerViewController ()

@end

@implementation DrawerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 创建添加子视图
    [self setUpChildViews];
    
    // 添加手势
    [self addGestureRecognizer];
    
    // KVO监听frame的改变
    [self.mainView addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
}

/**
 *  监听到frame有新值时就会调用
 *
 *  作用: 控制显示哪个view
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if (self.mainView.frame.origin.x > 0) {
        self.rightView.hidden = YES;
    }else if (self.mainView.frame.origin.x < 0){
        self.rightView.hidden = NO;
    }
}

/**
 *  添加手势
 */
- (void)addGestureRecognizer{
    // 添加拖拽手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:pan];
    
    // 添加单击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.view addGestureRecognizer:tap];
}

/**
 *  点击屏幕时复位
 */
- (void)tap:(UITapGestureRecognizer *)tap{
    [UIView animateWithDuration:0.3 animations:^{
        self.mainView.frame = self.view.bounds;
    }];
}


#define targetRightX 240
#define targetLeftX -180
- (void)pan:(UIPanGestureRecognizer *)pan{
    // 获取手指偏移量
    CGFloat offsetX = [pan translationInView:self.mainView].x;
    
    // 修改mainView的frame
    self.mainView.frame = [self frameWithOffsetX:offsetX];
    
    // 复位
    [pan setTranslation:CGPointZero inView:self.mainView];
    
    // 手指抬起的时候定位
    if (pan.state == UIGestureRecognizerStateEnded) {
        
        CGFloat target = 0;
        
        if (self.mainView.frame.origin.x > ScreenW * 0.5) {
            target = targetRightX;
            
        }else if (CGRectGetMaxX(self.mainView.frame) < ScreenW * 0.5){
            target = targetLeftX;
        }
        
        // 计算偏移量
        CGFloat offsetX = target - self.mainView.frame.origin.x;
        // 通过动画定位到指定位置
        [UIView animateWithDuration:0.25 animations:^{
            self.mainView.frame = [self frameWithOffsetX:offsetX];
        }];
        
        
    }
}




#define maxY 100
- (CGRect)frameWithOffsetX:(CGFloat)offsetX{
    CGRect tempFrame = self.mainView.frame;
    
    CGFloat x = tempFrame.origin.x += offsetX;
    
    // 根据x计算新的frame
    CGFloat y = fabs((x / ScreenW) * maxY);
    
    CGFloat h = ScreenH - 2 * y;
    
    CGFloat scale = h / ScreenH;
    
    CGFloat w = scale * ScreenW;
    
    return CGRectMake(x, y, w, h);
}

/**
 *  创建子视图
 */
- (void)setUpChildViews{
    UIView *leftView = [[UIView alloc] initWithFrame:self.view.bounds];
    leftView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:leftView];
    _leftView = leftView;
    
    
    UIView *rightView = [[UIView alloc] initWithFrame:self.view.bounds];
    rightView.backgroundColor =[UIColor blueColor];
    [self.view addSubview:rightView];
    _rightView = rightView;
    
    
    UIView *mainView = [[UIView alloc] initWithFrame:self.view.bounds];
    mainView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:mainView];
    _mainView = mainView;
}

@end
