//
//  ConsulationModel.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/13.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "ConsulationModel.h"

@implementation ConsulationModel

//主键
+(NSString *)getPrimaryKey
{
    return @"newsid";
}

+(NSString *)getTableName
{
    return @"ConsulationTable";
}

+(int)getTableVersion
{
    return 1;
}

@end
