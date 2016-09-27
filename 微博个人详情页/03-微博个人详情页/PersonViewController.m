//
//  PersonViewController.m
//  03-微博个人详情页
//
//  Created by 侯宝伟 on 13/8/15.
//  Copyright (c) 2013年 ZHUNJIEE. All rights reserved.
//

#import "PersonViewController.h"
#import "UIImage+CircleImage.h"

#define kHeaderViewH 200
#define kHeaderViewMinH 64
#define kTabBarViewH 44


@interface PersonViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
// tableView最开始的偏移量
@property (nonatomic, assign) CGFloat originOffsetY;
// 导航控制器标题
@property (nonatomic, weak) UILabel *titleLabel;
// 头部视图Y
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerViewYCons;
// 头部视图的高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerViewHCons;

@end

@implementation PersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 记录下tableView最开始的偏移量
    _originOffsetY = -(kHeaderViewH + kTabBarViewH);
    NSLog(@"%f", _originOffsetY);
    // 设置额外滚动的区域
    self.tableView.contentInset = UIEdgeInsetsMake(kTabBarViewH + kHeaderViewH, 0, 0, 0);
    // UIEdgeInsetsMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right):上左下右
    
    // 在iOS7之后,默认会给导航控制器里所有UIScrollView顶部都会添加额外的滚动区域64
    // 设置不需要自动调节额外的滚动区域
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 设置导航条内容
    [self setUpNav];
    
}

#pragma mark - scrollView代理方法
// 监听用户的滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // 获取当前最新的偏移量
    CGFloat offsetY = scrollView.contentOffset.y;
    NSLog(@"%f", offsetY);
    // 计算用户滚动了多少
    CGFloat delta = offsetY - _originOffsetY;
    NSLog(@"%f", delta);
    //方式一:修改头部视图的Y值
    //_headerViewYCons.constant =  - delta;
    
    // 方式二:修改头部视图的高度
    CGFloat headerH = kHeaderViewH - delta;
    if (headerH < kHeaderViewMinH) {
        headerH = kHeaderViewMinH;
    }
    _headerViewHCons.constant = headerH;
    
    
    
    
// 处理导航条
    // 计算当前的透明度
    CGFloat alpha = delta / (kHeaderViewH - kHeaderViewMinH);
    NSLog(@"%f", alpha);
    if (alpha > 1) {
        alpha = 0.99;
    }
    
    // 设置标题文字颜色
    self.titleLabel.textColor = [UIColor colorWithWhite:0 alpha:alpha];
    
    // 获取导航条颜色
    UIColor *navColor = [UIColor colorWithWhite:1 alpha:alpha];
    
    // 设置导航条背景图片
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:navColor] forBarMetrics:UIBarMetricsDefault];
}


#pragma mark - 设置导航条内容
- (void)setUpNav{
//    // 在ios7以后,默认会给导航控制器里所有的UIScView顶部都会添加额外的滚动区域64
//    // 设置不需要自动调节额外的滚动区域
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 1. 设置导航条透明
    // 传入空的图片
    // 必须传入UIBarMetricsDefault
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];    // 设置导航条阴影背景
    // 不设置的话会有一条线
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    // 2.设置导航条标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"微博个人详情页";
    // 设置标题默认颜色透明
    titleLabel.textColor = [UIColor colorWithWhite:0.0 alpha:0.0];
    
    // 设置尺寸,和文字一样大,自适应
    [titleLabel sizeToFit];
    
    _titleLabel = titleLabel;
    
    // navigationItem:用于设置导航条的内容模型
    // UIBarButtonItem:用于设置导航条上按钮的内容模型
    [self.navigationItem setTitleView:titleLabel];
}

#pragma mark - tableView数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"weibo";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    return cell;
}


@end
