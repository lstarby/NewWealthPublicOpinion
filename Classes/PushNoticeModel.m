//
//  PushNoticeModel.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/7/12.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "PushNoticeModel.h"
#import "DBManager.h"
#import "UserHandler.h"

@implementation PushNoticeModel

- (id)initWithTitle:(NSString *)title isOnflag:(BOOL)isOnflag pushID:(NSString *)pushID {
    self = [super init];
    if (self) {
        self.titleName = title;
        self.isOnflag = isOnflag;
        self.pushID = pushID;
    }
    return self;
}

+ (id)initWithTitle:(NSString *)title isOnflag:(BOOL)isOnflag pushID:(NSString *)pushID {
    return [[self alloc] initWithTitle:title isOnflag:isOnflag pushID:pushID];
}

+ (NSArray *)getDataSource {
    NSMutableArray *dataSource = [NSMutableArray array];
    [dataSource addObject:[self initWithTitle:@"预警" isOnflag:[UserHandler sharedUserHandler].loginUser.isPush pushID:@"0"]];
    //预警
    NSString *where = [NSString stringWithFormat:@"itemId=%d and itemOwen=1",153];
    if ([DBManager searchMenuByWhere:where]) {
         [dataSource addObject:[self initWithTitle:@"舆情预警" isOnflag:[UserHandler sharedUserHandler].loginUser.isPushWarning pushID:@"1"]];
    }
    //简报
    where = [NSString stringWithFormat:@"itemId=%d and itemOwen=1",154];
    if ([DBManager searchMenuByWhere:where]) {
        [dataSource addObject:[self initWithTitle:@"舆情简报" isOnflag:[UserHandler sharedUserHandler].loginUser.isPushReport pushID:@"2"]];
    }
    [dataSource addObject:[self initWithTitle:@"快讯" isOnflag:[UserHandler sharedUserHandler].loginUser.isPushInformation pushID:@"3"]];
    
    return dataSource;
}

@end
