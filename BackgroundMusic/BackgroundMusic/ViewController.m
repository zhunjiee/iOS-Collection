//
//  ViewController.m
//  BackgroundMusic
//
//  Created by zl on 2019/7/25.
//  Copyright © 2019 ZHUNJIEE. All rights reserved.
//

#import "ViewController.h"
#import "SharedBgMusic.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)palyMusic:(UIButton *)sender {
    [[SharedBgMusic sharedInstance] playMusic];
}
- (IBAction)pauseMusic:(UIButton *)sender {
    [[SharedBgMusic sharedInstance] pauseMusic];
}
- (IBAction)stopMusic:(UIButton *)sender {
    [[SharedBgMusic sharedInstance] stopMusic];
}

@end
