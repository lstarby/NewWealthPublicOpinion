//
//  UserCenterModel.h
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/23.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserCenterModel : NSObject

@property (nonatomic, copy) NSString *userInfo;
@property (nonatomic, copy) NSString *userImg;

- (id)initWithUserInfo:(NSString *)userInfo userImg:(NSString *)userImg;
+ (id)initWithUserInfo:(NSString *)userInfo userImg:(NSString *)userImg;
+ (NSArray *)getUserSource ;

@end
