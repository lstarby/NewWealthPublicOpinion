//
//  PublicSenModel.h
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/13.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import <LKDBHelper/LKDBHelper.h>

@interface PublicSenModel : JSONModel

@property (assign, nonatomic) int      rowindex;
@property (assign, nonatomic) int      groupid;
@property (copy, nonatomic  ) NSString *stockprice;
@property (copy, nonatomic  ) NSString *stockupdwn;
@property (copy, nonatomic  ) NSString *stockupdwnpct;
@property (assign, nonatomic) int      updwntype;
@property (assign, nonatomic) int      pid;
@property (assign, nonatomic) int      groupindex;
@property (assign, nonatomic) int      alarm;

@end
