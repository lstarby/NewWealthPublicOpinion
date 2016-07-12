//
//  CacheManager.h
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/15.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CacheManager : NSObject

/**
 *  删除文件
 *
 *  @param path 路径
 */
+ (void)deleteFile:(NSString*)path;

/**
 *  写入字典
 *
 *  @param path 路径
 *  @param dict 字典数据
 */
+ (void)writeFile:(NSString*)path dict:(NSDictionary*)dict;

/**
 *  写入数组
 *
 *  @param path  路径
 *  @param array 数组数据
 */
+ (void)writeFile:(NSString*)path array:(NSArray*)array;

/**
 *  获取数组
 *
 *  @param path 路径
 *
 *  @return 数组
 */
+ (NSArray*)arrayFromFile:(NSString*)path;

/**
 *  写入自定义对象
 *
 *  @param path   路径
 *  @param object 自定义对象
 */
+ (void)writeFile:(NSString *)path object:(id)object;

/**
 *  写入自定义对象数组
 *
 *  @param path   路径
 *  @param object 自定义对象数组
 */
+ (void)writeFile:(NSString *)path objectArray:(NSArray *)array;

/**
 *  获取自定义对象
 *
 *  @param path 路径
 *
 *  @return 对象
 */
+ (id)objectFromeFile:(NSString *)path;

/**
 *  获取字典
 *
 *  @param path 路径
 *
 *  @return 字典
 */
+ (NSDictionary*)dictFromFile:(NSString*)path;

/**
 *  判断文件是否存在
 *
 *  @param path 文件路径
 *
 *  @return 是否存在
 */
+ (BOOL)fileExist:(NSString*)path;

/**
 *  获得caches文件路径
 *
 *  @param relative 文件名
 *
 *  @return 文件路径
 */
+ (NSString *)cachesRelativePath:(NSString *)relative;

/**
 *  获得document文件路径
 *
 *  @param relative 文件名
 *
 *  @return 文件路径
 */
+ (NSString*)documentRelativePath:(NSString*)relative;

/**
 *  获取caches文件
 *
 *  @return caches
 */
+ (NSString *)cachesPath;

/**
 *  获取document文件
 *
 *  @return document
 */
+ (NSString *)documentPath;

@end
