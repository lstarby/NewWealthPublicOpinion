//
//  ApplyRecordModel.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/27.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "ApplyRecordModel.h"

@implementation ApplyRecordModel

//主键
+(NSString *)getPrimaryKey
{
    return @"id";
}

+(NSString *)getTableName
{
    return @"ApplyRecordTable";
}

+(int)getTableVersion
{
    return 1;
}


+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"createDate.time":@"time"}];
}

@end
