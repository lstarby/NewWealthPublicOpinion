//
//  PersonModel.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/13.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "PersonModel.h"

@implementation PersonModel

//主键
+(NSString *)getPrimaryKey
{
    return @"key";
}

+(NSString *)getTableName
{
    return @"PersonTable";
}

+(int)getTableVersion
{
    return 1;
}

@end
