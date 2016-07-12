//
//  PublicNoticeEntityModel.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/13.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "PublicNoticeEntityModel.h"

@implementation PublicNoticeEntityModel

//主键
+(NSString *)getPrimaryKey
{
    return @"itemID";
}

+(NSString *)getTableName
{
    return @"PublicNoticeEntityTable";
}

+(int)getTableVersion
{
    return 1;
}

@end
