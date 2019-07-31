//
//  ViewController.m
//  Bluetooth
//
//  Created by zl on 2019/7/19.
//  Copyright © 2019 ZHUNJIEE. All rights reserved.
//

#import "ViewController.h"
#import <BabyBluetooth.h>
#import "MBProgressHUD+XBLoading.h"

@interface ViewController ()
@property (strong, nonatomic) BabyBluetooth *bluetooth;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (IBAction)searchBluetoothButtonDidClick:(UIButton *)sender {
    self.bluetooth = [BabyBluetooth shareBabyBluetooth];
    [self setupBluetoothDelegate];
    self.bluetooth.scanForPeripherals().begin();
}


/**
 设置蓝牙委托
 */
- (void)setupBluetoothDelegate {
    __weak typeof(self) weakSelf = self;
    [MBProgressHUD showMessage:@"正在扫描中..." toView:self.view];
    // 1. 扫描外设
    [self.bluetooth setBlockOnCentralManagerDidUpdateState:^(CBCentralManager *central) {
        if (central.state != CBManagerStatePoweredOn) {
            [MBProgressHUD showText:@"设备打开失败, 请检查蓝牙是否开启" toView:weakSelf.view];
        } else {
            [MBProgressHUD showText:@"设备打开成功,开始扫描设备" toView:weakSelf.view];
        }
    }];
    
    
    // 2. 发现外设
    [self.bluetooth setBlockOnDiscoverToPeripherals:^(CBCentralManager *central, CBPeripheral *peripheral, NSDictionary *advertisementData, NSNumber *RSSI) {
        NSLog(@"搜索到了设备:%@,      RSSI: %@", peripheral.name, RSSI);
//        NSLog(@"advertisementData = = %@", advertisementData);
//        NSLog(@"RSSI = %@", RSSI);
        [MBProgressHUD hideHUD];
    }];
    //设置查找设备的过滤器
    [self.bluetooth setFilterOnDiscoverPeripherals:^BOOL(NSString *peripheralName, NSDictionary *advertisementData, NSNumber *RSSI) {
        if (peripheralName.length >1) {
            return YES;
        }
        return NO;
    }];
}

@end
