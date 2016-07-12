//
//  StockPriceModel.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/13.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "StockPriceModel.h"

@implementation StockPriceModel

//主键
+(NSString *)getPrimaryKey
{
    return @"code";
}

+(NSString *)getTableName
{
    return @"StockPriceTable";
}

+(int)getTableVersion
{
    return 1;
}

@end
