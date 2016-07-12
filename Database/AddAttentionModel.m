//
//  AddAttentionModel.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/13.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "AddAttentionModel.h"

@implementation AddAttentionModel

//主键
+(NSString *)getPrimaryKey
{
    return @"keyValue";
}
+(NSArray *)getPrimaryKeyUnionArray
{
    return @[@"refId",@"parentId",@"dataType"];
}

+(NSString *)getTableName
{
    return @"AddAttentionTable";
}

+(int)getTableVersion
{
    return 1;
}

@end
