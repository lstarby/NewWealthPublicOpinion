//
//  LikeNewsModel.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/13.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "LikeNewsModel.h"

@implementation LikeNewsModel

//主键
+(NSString *)getPrimaryKey
{
    return @"url";
}

+(NSString *)getTableName
{
    return @"LikeNewsTable";
}

+(int)getTableVersion
{
    return 1;
}

@end
