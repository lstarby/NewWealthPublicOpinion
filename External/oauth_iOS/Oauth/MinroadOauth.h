//
//  MinroadOauth.h
//  Oauth
//
//  Created by gao wei on 10-8-10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OADataFetcher.h"
#import "KEY.h"

@protocol OauthToken

/**
 *  @brief      认证成功
 *
 *
 *	@return
 *  @note
 */
- (void)OauthDidFinish:(OAToken *)token withCode:(int)aCode;

@end


@interface MinroadOauth : NSObject<MinroadDelete> {
	OAConsumer *consumer;
	OAMutableURLRequest *hmacSha1Request;//请求access(一步搞定
	OAToken *token;
	OAHMAC_SHA1SignatureProvider *hmacSha1Provider;
	OADataFetcher       *fetcher;
    NSMutableString     *pAddressUrl;
    NSString            *nonce;
    NSString            *timestamp;
	id<OauthToken> delegate;
}
@property (assign,nonatomic) id<OauthToken> delegate;
- (void)startOauth;

-(NSString*) getSignString:(NSString *)aUrl isGet:(BOOL)isGet;


/**
 *  @brief      设置token值
 *
 *
 *	@return
 *  @note
 */
-(void) setToken:(NSString*)aKey withSecret:(NSString*)aSecret;

+ (instancetype)sharedOauthInstance;
@end
