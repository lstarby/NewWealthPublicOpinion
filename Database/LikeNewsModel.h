//
//  LikeNewsModel.h
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/13.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import <LKDBHelper/LKDBHelper.h>

@interface LikeNewsModel : JSONModel

@property (copy, nonatomic  ) NSString *author;
@property (copy, nonatomic  ) NSString *createDate;
@property (copy, nonatomic  ) NSString *docId;
@property (copy, nonatomic  ) NSString *enabled;
@property (copy, nonatomic  ) NSString *entityName;
@property (assign, nonatomic) int      id;
@property (copy, nonatomic  ) NSString *url;
@property (copy, nonatomic  ) NSString *publishDate;
@property (copy, nonatomic  ) NSString *reprintTimes;
@property (copy, nonatomic  ) NSString *sourceInfo;
@property (copy, nonatomic  ) NSString *title;
@property (copy, nonatomic  ) NSString *userId;

@property (nonatomic, strong) NSNumber<Ignore> *publishTime;
@property (nonatomic, strong) NSNumber<Ignore> *createTime;

@property (nonatomic, strong) NSNumber<Ignore> *isSeleted;
@property (nonatomic, strong) NSNumber<Ignore> *height;

@end
