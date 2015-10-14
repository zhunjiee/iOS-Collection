//
//  BWClearCachesController.m
//  BWClearCaches
//
//  Created by 侯宝伟 on 15/10/13.
//  Copyright © 2015年 ZHUNJIEE. All rights reserved.
//

#import "BWClearCachesController.h"

@interface BWClearCachesController ()

@end

@implementation BWClearCachesController

- (void)viewDidLoad {
    [super viewDidLoad];

}

// 获取caches文件的大小
- (void)getFileSize{
    // 1. 获取caches路径
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    
    //    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    //    NSString *temp = NSTemporaryDirectory();
    
    // 2. 拼接SDWebImage的文件路径
    NSString *file = [caches stringByAppendingPathComponent:@"default/com.hackemist.SDWebImageCache.default"];
    // 3.创建文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    // 4.初始化文件大小
    NSUInteger size = 0;
    // 5.获取问价加下所以子路径及子文件(返回数组)
    NSArray *subpaths = [mgr subpathsAtPath:file];
    
    // 6.遍历subpaths数组计算文件的全部大小
    for (NSString *subpath in subpaths) {
        // 6.1拼接获取每个文件的全路径
        NSString *fullSubpath = [file stringByAppendingPathComponent:subpath];
        // 6.2获取文件的属性
        NSDictionary *attrs = [mgr attributesOfItemAtPath:fullSubpath error:nil];
        // 6.3如果是文件夹就跳过
        if ([attrs[NSFileType] isEqualToString:NSFileTypeDirectory]) {
            continue;
        }
        // 6.4是文件就计算大小
        size += [attrs[NSFileSize] integerValue];
    }
}

- (void)getFileSize2{
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *file = [caches stringByAppendingPathComponent:@"default/com.hackemist.SDWebImageCache.default"];
    
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    NSInteger size = 0;
    
    // 通过文件夹遍历器获取文件夹下所有的路径
    NSDirectoryEnumerator *fileEnum = [mgr enumeratorAtPath:file];
    
    for (NSString *subpath in fileEnum) {
        NSString *fullSubpath = [file stringByAppendingPathComponent:subpath];
        
        NSDictionary *attrs = [mgr attributesOfItemAtPath:fullSubpath error:nil];
        
        if ([attrs[NSFileType] isEqualToString:NSFileTypeDirectory]) {
            continue;
        }
        size += [attrs[NSFileSize] integerValue];
    }
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
