//
//  PushNoticeModel.h
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/7/12.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PushNoticeModel : NSObject

@property (nonatomic, copy  ) NSString *titleName;
@property (nonatomic, assign) BOOL      isOnflag;
@property (nonatomic, copy  ) NSString *pushID;

- (id)initWithUserInfo:(NSString *)userInfo userImg:(NSString *)userImg;
+ (id)initWithUserInfo:(NSString *)userInfo userImg:(NSString *)userImg;
+ (NSArray *)getDataSource;
@end
