//
//  MyGroupModel.h
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/13.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import <LKDBHelper/LKDBHelper.h>

@interface MyGroupModel : JSONModel

@property (assign, nonatomic) int      key;
@property (copy, nonatomic  ) NSString *code;
@property (copy, nonatomic  ) NSString *name;
@property (copy, nonatomic  ) NSString *icon;

@end
