#import "NSString+Path.h"

@implementation NSString (Path)

- (NSString *)cacheDir{
    // 1. 获取caches目录
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    
    // 2.拼接生成绝对路径
    return [path stringByAppendingPathComponent:[self lastPathComponent]];
}

- (NSString *)docDir{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    return [path stringByAppendingPathComponent:[self lastPathComponent]];
}

- (NSString *)tmpDir{
    NSString *path = NSTemporaryDirectory();
    
    return [path stringByAppendingPathComponent:[self lastPathComponent]];
}
@end
