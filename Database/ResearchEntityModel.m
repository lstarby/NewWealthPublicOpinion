//
//  ResearchEntityModel.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/13.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "ResearchEntityModel.h"

@implementation ResearchEntityModel

//主键
+(NSString *)getPrimaryKey
{
    return @"itemID";
}

+(NSArray *)getPrimaryKeyUnionArray
{
    return @[@"itemID",@"refId",@"dataType"];
}

+(NSString *)getTableName
{
    return @"ResearchEntityTable";
}

+(int)getTableVersion
{
    return 1;
}

@end
