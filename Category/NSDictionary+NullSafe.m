//
//  NSDictionary+NullSafe.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/15.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "NSDictionary+NullSafe.h"
#import "NSArray+Nullsafe.h"

@implementation NSDictionary (NullSafe)

/**
 *  如果key的值为空，返回空字符串
 *
 *  @param aKey 键值
 *
 *  @return 返回数据
 */
- (id)objectForKeyNullSafeString:(id)aKey {
    id result = [self objectForKey:aKey];
    if (result == nil || [[NSNull null] isEqual:result]) {
        return NSLocalizedString(@"NSDictionary+Nullsafe_WuShuJu", @"⚠ 无数据");
    }
    return result;
}

/**
 *  如果key的值为空，返回空数组
 *
 *  @param aKey 键值
 *
 *  @return 返回数据
 */
-(id)objectForKeyNullSafeArray:(id)aKey {
    id result = [self objectForKey:aKey];
    if (result == nil || [[NSNull null] isEqual:result]) {
        return [NSMutableArray array];
    }
    return result;
}

/**
 *  如果key的值为空，返回空字典
 *
 *  @param aKey 键值
 *
 *  @return 返回数据
 */
-(id)objectForKeyNullSafeDictionary:(id)aKey {
    id result = [self objectForKey:aKey];
    if (result == nil || [[NSNull null] isEqual:result]) {
        return [NSMutableDictionary dictionary];
    }
    return result;
}

/**
 *  判断是否存在值不为空的null
 *
 *  @param aKey 键值
 *
 *  @return 是否为Null
 */
-(BOOL)hasNoNullKey:(id)aKey {
    id result = [self objectForKey:aKey];
    if (result == nil || [[NSNull null] isEqual:result]) {
        return NO;
    }
    return YES;
}

/**
 *  将集合转换为不包含空的集合
 *
 *  @return 不包含空的字典
 */
-(NSMutableDictionary*)toNoNullDictionary {
    NSMutableDictionary* newDict = [NSMutableDictionary new];
    NSArray* keys = [self allKeys];
    for (id key in keys) {
        if ([self hasNoNullKey:key]) {
            id item = [self objectForKey:key];
            if ([item isKindOfClass:[NSArray class]]) {
                NSArray* array = item;
                [newDict setObject:[array toNoNullArray] forKey:key];
            } else if ([item isKindOfClass:[NSDictionary class]]) {
                NSDictionary* dict = item;
                [newDict setObject:[dict toNoNullDictionary] forKey:key];
            } else {
                [newDict setObject:item forKey:key];
            }
            
        }
    }
    return newDict;
}

@end
