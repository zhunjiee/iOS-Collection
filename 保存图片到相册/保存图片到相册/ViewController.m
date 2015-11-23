//
//  ViewController.m
//  保存图片到相册
//
//  Created by 侯宝伟 on 15/11/22.
//  Copyright © 2015年 ZHUNJIEE. All rights reserved.
//

#import "ViewController.h"
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>
#import <AssetsLibrary/AssetsLibrary.h> // iOS9.0以后彻底弃用
#import <Photos/Photos.h> // iOS8.0开始使用

@interface ViewController ()
/** 图片 */
@property (nonatomic, weak) UIImageView *imageView;
@end

@implementation ViewController

static NSString * const BSCollectionName = @"我的相册";

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self save];

}

// 保存图片到相机胶卷
- (void)save {
    // 0.判断状态
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusDenied) {
        [SVProgressHUD showErrorWithStatus:@"没有访问相册的权限"];
        NSLog(@"用户拒绝当前应用访问相册,需要提醒用户打开允许访问开关");
    }else if (status == PHAuthorizationStatusRestricted) {
        NSLog(@"家长控制,不允许访问");
    }else if (status == PHAuthorizationStatusNotDetermined) {
        NSLog(@"用户还没有做出选择");
        [self saveImage];
    }else if (status == PHAuthorizationStatusAuthorized) {
        NSLog(@"用户允许当前应用访问相册");
        [self saveImage];
    }
}

/**
 *  返回相册,避免重复创建相册引起不必要的错误
 */
- (PHAssetCollection *)collection{
    // 先获得之前创建过的相册
    PHFetchResult *collectionResult =[PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *collection in collectionResult) {
        if ([collection.localizedTitle isEqualToString:BSCollectionName]) {
            return collection;
        }
    }
    
    // 如果相册不存在,就创建新的相册(文件夹)
    __block NSString *collectionID = nil; // __block作用:可以修改block外部的变量的值
    // 这个方法会在相册创建完毕后返回
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        // 新建一个PHAssetCollectionChangeRequest对象,用来创建一个新的相册
        collectionID = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:BSCollectionName].placeholderForCreatedAssetCollection.localIdentifier;
    } error:nil];
    
    return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[collectionID] options:nil].firstObject;
}

/**
 *  保存图片到相册
 */
- (void)saveImage{
    /*
     PHAsset : 一个PHAsset对象就代表一个资源文件,比如一张图片
     PHAssetCollection : 一个PHAssetCollection对象就代表一个相册
     */
    
    __block NSString *assetID = nil;
    // 1. 存储图片到"相机胶卷"
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{ // 这个block里保存一些"修改性质"的代码
        // 新建一个PHAssetCreationRequest对象,保存图片到"相机胶卷" // iOS9.0以后才可以使用,所以新建PHAssetChangeRequest对象吧
        // 返回PHAsset(图片资源)的字符串标识
        assetID = [PHAssetChangeRequest creationRequestForAssetFromImage:self.imageView.image].placeholderForCreatedAsset.localIdentifier;
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (error) {
            NSLog(@"保存图片到相机胶卷中失败");
            return;
        }
        NSLog(@"成功保存图片到相机胶卷中");
        
        // 2. 获取相册对象
        PHAssetCollection *collection = [self collection];
        
        // 3. 将"相机胶卷"中的图片添加到新的相册
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:collection];
            
            // 根据唯一标识获得相片对象
            PHAsset *asset = [PHAsset fetchAssetsWithLocalIdentifiers:@[assetID] options:nil].firstObject;
            // 添加图片到相册中
            [request addAssets:@[asset]];
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            if (error) {
                NSLog(@"添加图片到相册中失败");
                return;
            }
            
            NSLog(@"成功添加图片到相册中");
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [SVProgressHUD showSuccessWithStatus:@"保存成功"];
            }];
        }];
    }];
}

@end
