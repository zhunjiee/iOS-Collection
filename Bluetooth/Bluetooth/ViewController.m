//
//  ViewController.m
//  Bluetooth
//
//  Created by zl on 2019/7/19.
//  Copyright © 2019 ZHUNJIEE. All rights reserved.
//

#import "ViewController.h"
#import <BabyBluetooth.h>
#import "MBProgressHUD+Extension.h"

@interface ViewController ()
@property (strong, nonatomic) BabyBluetooth *bluetooth;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    [self initBluetooth];
    [MBProgressHUD showActivityMessageInView:@"正在扫描..."];
}

- (IBAction)searchBluetoothButtonDidClick:(UIButton *)sender {
    self.bluetooth.scanForPeripherals().begin();
}

- (void)initBluetooth {
    self.bluetooth = [BabyBluetooth shareBabyBluetooth];
    [self setupBlueToothDelegate];
    
}

/**
 设置蓝牙委托
 */
- (void)setupBlueToothDelegate {
    __weak typeof(self) weakSelf = self;
    [MBProgressHUD showActivityMessageInView:@"正在扫描..."];
    [self.bluetooth setBlockOnCentralManagerDidUpdateState:^(CBCentralManager *central) {
        if (central.state != CBManagerStatePoweredOn) {
            [MBProgressHUD showErrorMessage:@"设备打开失败, 请检查蓝牙是否开启"];
        }
    }];
}

@end
