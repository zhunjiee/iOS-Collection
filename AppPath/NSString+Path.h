#import <Foundation/Foundation.h>

@interface NSString (Path)

// 生成文件在caches目录中的路径
- (NSString *)cacheDir;

// 生成文件在document目录中的路径
- (NSString *)docDir;

// 生成文件在tmp目录中的路径
- (NSString *)tmpDir;

@end
