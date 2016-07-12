//
//  MenuModel.h
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/13.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface MenuModel : JSONModel

@property (assign, nonatomic) int itemId;
@property (assign, nonatomic) int itemDataType;
@property (assign, nonatomic) int itemOrgType;
@property (assign, nonatomic) int itemOwen;
@property (assign, nonatomic) int itemFunType;

@end
