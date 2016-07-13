//
//  CacheManager.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/15.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "CacheManager.h"
#import "CacheHeader.h"
#import "NSArray+NullSafe.h"
#import "NSDictionary+NullSafe.h"

@implementation CacheManager

/**
 *  删除文件
 *
 *  @param path 路径
 */
+ (void)deleteFile:(NSString*)path {
    if (path==nil) return;
    NSFileManager* fileManager = [NSFileManager defaultManager];
    NSError* error;
    [fileManager removeItemAtPath:path error:&error];
}

/**
 *  写入字典
 *
 *  @param path 路径
 *  @param dict 字典数据
 */
+ (void)writeFile:(NSString*)path dict:(NSDictionary*)dict {
    if ([[NSNull null] isEqual:dict]) return;
    NSDictionary* selfDict = [dict toNoNullDictionary];
    DLog(@"%@",selfDict);
    BOOL success =[selfDict writeToFile:path atomically:YES];
    if (!success) {
        DLog(@"写文件 [%@] 失败！！！", path);
    }
}

/**
 *  写入数组
 *
 *  @param path  路径
 *  @param array 数组数据
 */
+ (void)writeFile:(NSString*)path array:(NSArray*)array {
    if ([[NSNull null] isEqual:array]) return;
    array = [array toNoNullArray];
    BOOL success = [array writeToFile:path atomically:YES];
    if (!success) {
        DLog(@"写文件 [%@] 失败！！！", path);
    }
}

/**
 *  写入自定义对象
 *
 *  @param path   路径
 *  @param object 自定义对象
 */
+ (void)writeFile:(NSString *)path object:(id)object {
    [NSKeyedArchiver archiveRootObject:object toFile:path];
}

/**
 *  写入自定义对象数组
 *
 *  @param path   路径
 *  @param object 自定义对象数组
 */
+ (void)writeFile:(NSString *)path objectArray:(NSArray *)array {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:array];
    [data writeToFile:path atomically:YES];
}

/**
 *  获取自定义对象
 *
 *  @param path 路径
 *
 *  @return 对象
 */
+ (id)objectFromeFile:(NSString *)path {
    return [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}

/**
 *  获取数组
 *
 *  @param path 路径
 *
 *  @return 数组
 */
+ (NSArray*)arrayFromFile:(NSString*)path {
    return [NSArray arrayWithContentsOfFile:path];
}

/**
 *  获取字典
 *
 *  @param path 路径
 *
 *  @return 字典
 */
+ (NSDictionary*)dictFromFile:(NSString*)path {
    return [NSDictionary dictionaryWithContentsOfFile:path];
}

/**
 *  获得caches文件路径
 *
 *  @param relative 文件名
 *
 *  @return 文件路径
 */
+ (NSString *)cachesRelativePath:(NSString *)relative {
     return [[self cachesPath] stringByAppendingPathComponent:[self formatUrlString:relative]];
}

/**
 *  获得document文件路径
 *
 *  @param relative 文件名
 *
 *  @return 文件路径
 */
+ (NSString*)documentRelativePath:(NSString*)relative {
    return [[self documentPath] stringByAppendingPathComponent:[self formatUrlString:relative]];
}

/**
 *  判断文件是否存在
 *
 *  @param path 文件路径
 *
 *  @return 是否存在
 */
+ (BOOL)fileExist:(NSString*)path {
    NSFileManager* fileMgr = [NSFileManager defaultManager];
    return [fileMgr fileExistsAtPath:path];
}

/**
 *  将uri替换为合法的文件名
 *
 *  @param urlString URL
 *
 *  @return 合法地址
 */
+ (NSString*)formatUrlString:(NSString*)urlString {
    NSString* path = [urlString stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    return path;
}

/**
 *  获取caches文件
 *
 *  @return caches
 */
+ (NSString *)cachesPath {
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}

/**
 *  获取document文件
 *
 *  @return document
 */
+ (NSString *)documentPath {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}

//清除缓存
+ (void)clearCache {
    NSString *cachPath = [self cachesPath];
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
    for (NSString *file in files) {
        NSError *error;
        NSString *path = [cachPath stringByAppendingPathComponent:file];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
        }
    }
}


//获取缓存大小
+ (NSString *)getCacheSpace {
    NSString *path = [self cachesPath];
    DLog(@"cachesPath->>%@",path);
    float cache = [self folderSizeAtPath:path];
    NSString *strDistance=[NSString stringWithFormat:@"%.2f", cache];
    DLog(@"%@",strDistance);
    if ( strDistance == nil ) {
        strDistance = @"0 M";
    }
    else {
        strDistance = [strDistance stringByAppendingString:@" M"];
    }
    return strDistance;
}

+ (float ) folderSizeAtPath:(NSString*) folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}

+ (long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

@end
