//
//  ViewController.m
//  单例
//
//  Created by Houge on 2020/1/12.
//  Copyright © 2020 ZHUNJIEE. All rights reserved.
//

#import "ViewController.h"
#import "Singleton.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    Singleton *single1 = [Singleton shareInstance];
    Singleton *single2 = [Singleton shareInstance];
    Singleton *single3 = [[Singleton alloc] init];
    Singleton *single4 = [Singleton new];
    
    NSLog(@"第一个对象的地址%p",single1);
    NSLog(@"第二个对象的地址%p",single2);
    NSLog(@"第三个对象的地址%p",single3);
    NSLog(@"第四个对象的地址%p",single4);
}


@end
