//
//  NSArray+NullSafe.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/15.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "NSArray+NullSafe.h"
#import "NSDictionary+Nullsafe.h"

@implementation NSArray (NullSafe)

/**
 *  将集合转换为不包含空的集合
 *
 *  @return 不包含空的数组
 */
- (NSMutableArray*)toNoNullArray {
    NSMutableArray* newArray = [NSMutableArray new];
    
    for (id item in self) {
        if (item==nil || [[NSNull null] isEqual:item]) continue;
        
        if ([item isKindOfClass:[NSDictionary class]]) {
            NSDictionary* dict = item;
            [newArray addObject:[dict toNoNullDictionary]];
        } else {
            [newArray addObject:item];
        }
        
    }
    return newArray;
}

@end
