//
//  MenuModel.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/13.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "MenuModel.h"

@implementation MenuModel

//主键
+(NSString *)getPrimaryKey
{
    return @"itemId";
}

+(NSString *)getTableName
{
    return @"MenuTable";
}

+(int)getTableVersion
{
    return 1;
}

@end
