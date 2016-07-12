//
//  InfoModel.h
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/7/4.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface InfoModel : JSONModel

@property (copy, nonatomic  ) NSString<Optional> *author;
@property (copy, nonatomic  ) NSString           *content;
@property (copy, nonatomic  ) NSString<Optional> *id;
@property (copy, nonatomic  ) NSString<Optional> *itemID;
@property (copy, nonatomic  ) NSString<Optional> *imgUrl;
@property (copy, nonatomic  ) NSString           *publishedAt;
@property (copy, nonatomic  ) NSString<Optional> *source;
@property (copy, nonatomic  ) NSString           *stkType;
@property (assign, nonatomic) int                stkcode;
@property (copy, nonatomic  ) NSString           *stkname;
@property (copy, nonatomic  ) NSString<Optional> *storeTime;
@property (copy, nonatomic  ) NSString<Optional> *summary;
@property (copy, nonatomic  ) NSString           *title;
@property (copy, nonatomic  ) NSString<Optional> *url;
@property (copy, nonatomic  ) NSString<Optional> *type;
@property (copy, nonatomic  ) NSString<Optional> *ztFlag;
@property (copy, nonatomic  ) NSString<Optional> *zxFlag;

@end
