//
//  UserHandler.h
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/16.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginUser.h"
#import "UserChannel.h"
#import "MinroadOauth.h"

typedef void (^OauthDidFinishBlock)(OAToken *token, int aCode);

@interface UserHandler : NSObject<OauthToken>

//@property (nonatomic, copy  ) NSString     *userToken;//用户token
@property (nonatomic, copy  ) NSString     *userKey;
@property (nonatomic, strong) NSDictionary *keyWordType;
@property (nonatomic, strong) LoginUser    *loginUser;
@property (nonatomic, strong) NSArray      *userChannels;
@property (nonatomic, strong) NSDictionary *urlType;

@property (nonatomic, strong) MinroadOauth *minroadOauth;
@property (nonatomic, copy) OauthDidFinishBlock oauthDidFinishBlock;
/**
 *  用户单例
 *
 *  @return 用户对象
 */
+ (UserHandler *)sharedUserHandler;

/**
 *  Oauth认证
 *
 *  @param oauthDidFinishBlock 认证完成block
 */
- (void)startUserOauth:(OauthDidFinishBlock)oauthDidFinishBlock;

+ (NSString *)getAuthorization:(NSString *)url isGET:(BOOL)isGET;

@end
