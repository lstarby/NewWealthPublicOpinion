//
//  ResearchModel.h
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/13.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import <LKDBHelper/LKDBHelper.h>

@interface ResearchModel : JSONModel

@property (copy, nonatomic  ) NSString *itemID;
@property (copy, nonatomic  ) NSString *sktType;
@property (copy, nonatomic  ) NSString *type;
@property (copy, nonatomic  ) NSString *sktname;
@property (copy, nonatomic  ) NSString *content;
@property (nonatomic, assign) long      publishedAt;
@property (copy, nonatomic  ) NSString *stkcode;
@property (copy, nonatomic  ) NSString *title;
@property (copy, nonatomic  ) NSString *startDate;
@property (copy, nonatomic  ) NSString *source;

@end
