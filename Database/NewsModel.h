//
//  NewsModel.h
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/13.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import <LKDBHelper/LKDBHelper.h>

@interface NewsModel : JSONModel

@property (assign, nonatomic) int      newsid;
@property (assign, nonatomic) NSString * newsTitle;
@property (copy, nonatomic  ) NSString *strSource;
@property (copy, nonatomic  ) NSString *strUrl;
@property (copy, nonatomic  ) NSString *newsUrl;
@property (copy, nonatomic  ) NSString *newstime;
@property (assign, nonatomic) int      newstype;
@property (assign, nonatomic) int      newsselect;
@property (copy, nonatomic  ) NSString *entityName;

@property (copy, nonatomic  ) NSString *method;
@property (copy, nonatomic  ) NSString *queryConfig;

@end
