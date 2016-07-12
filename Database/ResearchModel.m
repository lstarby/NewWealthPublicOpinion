//
//  ResearchModel.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/13.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "ResearchModel.h"

@implementation ResearchModel

//主键
+(NSString *)getPrimaryKey
{
    return @"itemID";
}

+(NSString *)getTableName
{
    return @"ResearchTable";
}

+(int)getTableVersion
{
    return 1;
}

@end
