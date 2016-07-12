//
//  EntityNewsModel.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/13.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "EntityNewsModel.h"

@implementation EntityNewsModel

//主键
+(NSString *)getPrimaryKey
{
    return @"strUrl";
}

+(NSString *)getTableName
{
    return @"EntityNewsTable";
}

+(int)getTableVersion
{
    return 1;
}


@end
