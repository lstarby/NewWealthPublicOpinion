//
//  PublicSenModel.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/13.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "PublicSenModel.h"

@implementation PublicSenModel


//主键
+(NSString *)getPrimaryKey
{
    return @"rowindex";
}

+(NSString *)getTableName
{
    return @"PublicSenTable";
}

+(int)getTableVersion
{
    return 1;
}

@end
