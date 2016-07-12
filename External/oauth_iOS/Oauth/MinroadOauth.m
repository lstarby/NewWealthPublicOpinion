//
//  MinroadOauth.m
//  Oauth
//
//  Created by gao wei on 10-8-10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MinroadOauth.h"

@interface MinroadOauth(private)
-(void) clear;
- (NSString *)_signatureBaseString:(BOOL)isGet;
- (NSString *)_generateTimestamp;
- (NSString *)_generateNonce;
///解析参数
- (NSDictionary*)dictionaryFromQuery:(NSString*)query usingEncoding:(NSStringEncoding)encoding;
@end

@implementation MinroadOauth
@synthesize delegate;

+ (instancetype)sharedOauthInstance
{
    static MinroadOauth *minroadOauth;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        minroadOauth = [[MinroadOauth alloc] init];
    });
    return minroadOauth;
}

-(NSString*) getSignString:(NSString *)aUrl isGet:(BOOL)isGet
{
    [pAddressUrl setString:aUrl];
    NSString *signature = [hmacSha1Provider signClearText:[self _signatureBaseString:isGet]
                                               withSecret:[NSString stringWithFormat:@"%@&%@",[consumer.secret URLEncodedString], [token.secret URLEncodedString]]];
//    NSString *oauthHeader = [NSString stringWithFormat:@"oauth_token=%@&oauth_consumer_key=%@&oauth_signature_method=%@&oauth_timestamp=%@&oauth_nonce=%@&oauth_version=1.0&oauth_signature=%@",[token.key URLEncodedString],[consumer.key URLEncodedString],[[hmacSha1Provider name] URLEncodedString],timestamp,nonce,[signature URLEncodedString]];
    
    
     NSString *oauthHeader = [NSString stringWithFormat:@"OAuth realm=\"\", oauth_token=\"%@\", oauth_consumer_key=\"%@\", oauth_signature_method=\"%@\", oauth_timestamp=\"%@\", oauth_nonce=\"%@\", oauth_version=\"1.0\", oauth_signature=\"%@\"",[token.key URLEncodedString],[consumer.key URLEncodedString],[[hmacSha1Provider name] URLEncodedString],timestamp,nonce,[signature URLEncodedString]];
    
    NSLog(@"%@",oauthHeader);
    return oauthHeader;
    
}

-(void) setToken:(NSString*)aKey withSecret:(NSString*)aSecret
{
    token.key = aKey;
    token.secret = aSecret;
}

- (NSDictionary*)dictionaryFromQuery:(NSString*)query usingEncoding:(NSStringEncoding)encoding 
{
    NSCharacterSet* delimiterSet = [NSCharacterSet characterSetWithCharactersInString:@"&"];
    NSMutableDictionary* pairs = [NSMutableDictionary dictionary];
    NSScanner* scanner = [[[NSScanner alloc] initWithString:query] autorelease];
    while (![scanner isAtEnd]) {
        NSString* pairString = nil;
        [scanner scanUpToCharactersFromSet:delimiterSet intoString:&pairString];
        [scanner scanCharactersFromSet:delimiterSet intoString:NULL];
        NSArray* kvPair = [pairString componentsSeparatedByString:@"="];
        if (kvPair.count == 2) {
            NSString* key = [[kvPair objectAtIndex:0]
                             stringByReplacingPercentEscapesUsingEncoding:encoding];
            NSString* value = [[kvPair objectAtIndex:1]
                               stringByReplacingPercentEscapesUsingEncoding:encoding];
            [pairs setObject:value forKey:key];
        }
    }
    
    return [NSDictionary dictionaryWithDictionary:pairs];
}


- (NSString *)_signatureBaseString:(BOOL)isGet
{
    nonce = [self _generateNonce];
    timestamp = [self _generateTimestamp];
    NSMutableArray *parameterPairs = [NSMutableArray  arrayWithCapacity:10]; // 6 being the number of OAuth params in the Signature Base String
    
	[parameterPairs addObject:[[OARequestParameter requestParameterWithName:@"oauth_consumer_key" value:consumer.key] URLEncodedNameValuePair]];
	[parameterPairs addObject:[[OARequestParameter requestParameterWithName:@"oauth_signature_method" value:[hmacSha1Provider name]] URLEncodedNameValuePair]];
	[parameterPairs addObject:[[OARequestParameter requestParameterWithName:@"oauth_timestamp" value:timestamp] URLEncodedNameValuePair]];
	[parameterPairs addObject:[[OARequestParameter requestParameterWithName:@"oauth_nonce" value:nonce] URLEncodedNameValuePair]];
	[parameterPairs addObject:[[OARequestParameter requestParameterWithName:@"oauth_version" value:@"1.0"] URLEncodedNameValuePair]];
    if (![token.key isEqualToString:@""]) {
        [parameterPairs addObject:[[OARequestParameter requestParameterWithName:@"oauth_token" value:token.key] URLEncodedNameValuePair]];
    }
   
    NSRange range = [pAddressUrl rangeOfString:@"?"];
    if (range.length > 0) {
        NSString *pSubString = [pAddressUrl substringFromIndex:range.location+1];
        NSDictionary *pDic = [self dictionaryFromQuery:pSubString usingEncoding:NSUTF8StringEncoding];
        if ([pDic count] > 0) {
            NSArray *pKeys = [pDic allKeys];
            for (int i=0; i< [pKeys count]; i++) {
                NSString *pKeyString = [pKeys objectAtIndex:i];
                NSString *pValueString = [pDic objectForKey:pKeyString];
                [parameterPairs addObject:[[OARequestParameter requestParameterWithName:pKeyString value:pValueString] URLEncodedNameValuePair]];
            }
        }
    }
    
    
    
    NSArray *sortedPairs = [parameterPairs sortedArrayUsingSelector:@selector(compare:)];
    NSString *normalizedRequestParameters = [sortedPairs componentsJoinedByString:@"&"];
    
    // OAuth Spec, Section 9.1.2 "Concatenate Request Elements"
    NSString *pMethod = @"GET";
    if (!isGet) {
        pMethod = @"POST";
    }
    NSString *ret = [NSString stringWithFormat:@"%@&%@&%@",pMethod,
					 [[[NSURL URLWithString:pAddressUrl] URLStringWithoutQuery] URLEncodedString],
					 [normalizedRequestParameters URLEncodedString]];
	return ret;
}

#pragma mark 获得时间戳
- (NSString *)_generateTimestamp 
{
    return [NSString stringWithFormat:@"%ld", time(NULL)];
}

#pragma mark 获得随时字符串
- (NSString *)_generateNonce 
{
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    NSString *result = [(NSString *)CFUUIDCreateString(NULL, theUUID) autorelease];
    CFRelease(theUUID);
    return (NSString *)result;
}

-(id) init
{
    consumer = [[OAConsumer alloc] initWithKey:APPKEY secret:APPSECRET];
	hmacSha1Provider = [[OAHMAC_SHA1SignatureProvider alloc] init];
    fetcher = [[OADataFetcher alloc] init];
    fetcher.mindelegate = self;
    token = [[OAToken alloc] init];
    pAddressUrl = [[NSMutableString alloc] initWithCapacity:10];
    return [super init];
}

#pragma mark 开始认证
- (void)startOauth
{
    [self clear];
	hmacSha1Request = [[OAMutableURLRequest alloc] initWithURL:[NSURL URLWithString:AccessURL]
                                                      consumer:consumer
                                                         token:NULL
                                                         realm:NULL
                                             signatureProvider:hmacSha1Provider
                                                         nonce:[self _generateNonce]
                                                     timestamp:[self _generateTimestamp]];
    
    [fetcher fetchDataWithRequest:hmacSha1Request 
                         delegate:self
                didFinishSelector:@selector(requestTokenTicket:finishedWithData:)
                  didFailSelector:@selector(requestTokenTicket:failedWithError:)];
}

#pragma mark delegate
- (void)requestTokenTicket:(OAServiceTicket *)ticket finishedWithData:(NSMutableData *)data {
  
	if ([[ticket request] isEqual:hmacSha1Request]) {
		NSString *responseBody = [[[NSString alloc] initWithData:data
													   encoding:NSUTF8StringEncoding] autorelease];
		[token initWithHTTPResponseBody:responseBody];
        
        NSLog(@"key=%@\r\nsecret=%@\r\n",token.key,token.secret);
        [delegate OauthDidFinish:token withCode:0];
	}
}

-(void) clear
{
    [hmacSha1Request release];
    hmacSha1Request = nil;
}

- (void)requestTokenTicket:(OAServiceTicket *)ticket failedWithError:(NSError *)error {
    [delegate OauthDidFinish:token withCode:-1];
}

-(void) dealloc
{
    [self clear];
    [pAddressUrl release];
    [token release];
    [super dealloc];
}

@end
