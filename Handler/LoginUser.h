//
//  LoginUser.h
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/16.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface LoginUser : JSONModel<NSCoding>

@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *clientType;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *isPush;               //是否推送
@property (nonatomic, copy) NSString *isPushInformation;
@property (nonatomic, copy) NSString *isPushReport;
@property (nonatomic, copy) NSString *isPushWarning;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *name;                 //应用名称
@property (nonatomic, copy) NSString *nickname;             //用户昵称
@property (nonatomic, copy) NSString *orgId;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *permission;
@property (nonatomic, copy) NSString *photo;                //用户头像
@property (nonatomic, copy) NSString *roleId;
@property (nonatomic, copy) NSString *tel;
@property (nonatomic, copy) NSString *truename;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *uk;
@property (nonatomic, copy) NSString *userId;               //用户id
@property (nonatomic, copy) NSString *username;

@end
