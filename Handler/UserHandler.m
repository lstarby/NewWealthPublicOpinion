//
//  UserHandler.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/16.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "UserHandler.h"

@implementation UserHandler

//初始化单例
+ (UserHandler *)sharedUserHandler {
    static UserHandler *handler = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handler = [[UserHandler alloc] init];
    });
    return handler;
}

//Oauth认证
- (void)startUserOauth:(OauthDidFinishBlock)oauthDidFinishBlock{
    self.oauthDidFinishBlock = oauthDidFinishBlock;
    MinroadOauth *minroadOauth = [MinroadOauth sharedOauthInstance];
    minroadOauth.delegate = self;
    [minroadOauth startOauth];
}

+ (NSString *)getAuthorization:(NSString *)url isGET:(BOOL)isGET {
    MinroadOauth *minroadOauth = [MinroadOauth sharedOauthInstance];
    return [minroadOauth getSignString:url isGet:isGET];
}

- (void)OauthDidFinish:(OAToken *)token withCode:(int)aCode {
    self.oauthDidFinishBlock(token, aCode);
}

@end
