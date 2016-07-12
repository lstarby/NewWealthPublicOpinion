//
//  DefCompanyModel.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/13.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "DefCompanyModel.h"

@implementation DefCompanyModel

//主键
+(NSString *)getPrimaryKey
{
    return @"key";
}

+(NSString *)getTableName
{
    return @"DefCompanyTable";
}

+(int)getTableVersion
{
    return 1;
}

@end
