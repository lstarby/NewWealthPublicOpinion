//
//  PublicNoticeModel.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/13.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "PublicNoticeModel.h"

@implementation PublicNoticeModel

//主键
+(NSString *)getPrimaryKey
{
    return @"itemID";
}

+(NSString *)getTableName
{
    return @"PublicNoticeTable";
}

+(int)getTableVersion
{
    return 1;
}

@end
