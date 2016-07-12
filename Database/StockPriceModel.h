//
//  StockPriceModel.h
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/13.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import <LKDBHelper/LKDBHelper.h>

@interface StockPriceModel : JSONModel

@property (copy, nonatomic  ) NSString *code;
@property (assign, nonatomic) double   rg;
@property (assign, nonatomic) double   np;
@property (assign, nonatomic) double   ar;

@end
