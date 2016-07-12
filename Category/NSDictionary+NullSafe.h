//
//  NSDictionary+NullSafe.h
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/15.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (NullSafe)

/**
 *  如果key的值为空，返回空字符串
 *
 *  @param aKey 键值
 *
 *  @return 返回数据
 */
- (id)objectForKeyNullSafeString:(id)aKey;

/**
 *  如果key的值为空，返回空数组
 *
 *  @param aKey 键值
 *
 *  @return 返回数据
 */
-(id)objectForKeyNullSafeArray:(id)aKey;

/**
 *  如果key的值为空，返回空字典
 *
 *  @param aKey 键值
 *
 *  @return 返回数据
 */
-(id)objectForKeyNullSafeDictionary:(id)aKey;

/**
 *  判断是否存在值不为空的null
 *
 *  @param aKey 键值
 *
 *  @return 是否为Null
 */
-(BOOL)hasNoNullKey:(id)aKey;

/**
 *  将集合转换为不包含空的集合
 *
 *  @return 不包含空的字典
 */
-(NSMutableDictionary*)toNoNullDictionary;

@end
