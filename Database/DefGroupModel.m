//
//  DefGroupModel.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/13.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "DefGroupModel.h"

@implementation DefGroupModel

//主键
+(NSString *)getPrimaryKey
{
    return @"key";
}

+(NSString *)getTableName
{
    return @"DefGroupTable";
}

+(int)getTableVersion
{
    return 1;
}

@end
