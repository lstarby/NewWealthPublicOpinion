//
//  ApplyRecordModel.h
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/27.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import <LKDBHelper/LKDBHelper.h>

@interface ApplyRecordModel : JSONModel

@property(nonatomic)     int             id;
@property(nonatomic)     int             type;
@property(nonatomic)     int             status;
@property(nonatomic)     int             time;
@property(nonatomic)     NSString*       content;

@end
