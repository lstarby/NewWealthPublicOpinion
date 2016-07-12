//
//  PublicNoticeEntityModel.h
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/13.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import <LKDBHelper/LKDBHelper.h>

@interface PublicNoticeEntityModel : JSONModel

@property (copy, nonatomic  ) NSString *itemID;
@property (copy, nonatomic  ) NSString *sktType;
@property (copy, nonatomic  ) NSString *type;
@property (copy, nonatomic  ) NSString *sktname;
@property (copy, nonatomic  ) NSString *content;
@property (assign, nonatomic) long     ublishedAt;
@property (copy,nonatomic   ) NSString *stkcode;
@property (copy,nonatomic   ) NSString *title;
@property (copy,nonatomic   ) NSString *startDate;

@property (assign, nonatomic) int      dataType;
@property (assign, nonatomic) int      refId;

@end
