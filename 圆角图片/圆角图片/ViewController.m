//
//  ViewController.m
//  圆角图片
//
//  Created by 侯宝伟 on 2019/5/15.
//  Copyright © 2019 ZHUNJIEE. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+Circle.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"noselection"] clipImageWithCornerRadius:60]];
    imageView.frame = CGRectMake(0, 0, 120, 120);
    imageView.center = self.view.center;
    [self.view addSubview:imageView];
}


@end
