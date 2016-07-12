//
//  NSArray+NullSafe.h
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/15.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (NullSafe)

/**
 *  将集合转换为不包含空的集合
 *
 *  @return 不包含空的数组
 */
- (NSMutableArray*)toNoNullArray;

@end
