//
//  OADataFetcher.m
//  OAuthConsumer
//
//  Created by Jon Crosby on 11/5/07.
//  Copyright 2007 Kaboomerang LLC. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.


#import "OADataFetcher.h"


@implementation OADataFetcher

- (void)fetchDataWithRequest:(OAMutableURLRequest *)aRequest 
					delegate:(id)aDelegate 
		   didFinishSelector:(SEL)finishSelector 
			 didFailSelector:(SEL)failSelector 
{
    request = aRequest;
    //delegate = aDelegate;
    didFinishSelector = finishSelector;
    didFailSelector = failSelector;
    
    [request prepare];
    
    if (pNSURLConnection) {
        [pNSURLConnection release];
        pNSURLConnection = nil;
    }
    pNSURLConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse*)response 
{
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection 
{
    //[_waitingDialog dismissWithClickedButtonIndex:0 animated:NO];
    [pNSURLConnection release];
    pNSURLConnection = nil;
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{ 
    OAServiceTicket *ticket= [[OAServiceTicket alloc] initWithRequest:request
                                                             response:response
                                                           didSucceed:NO];
    
    [_mindelegate requestTokenTicket:ticket failedWithError:error];
//    [delegate performSelector:didFailSelector
//                   withObject:ticket
//                   withObject:error];
    [ticket release];
}
- (BOOL)connectionShouldUseCredentialStorage:(NSURLConnection *)connection
{
    return NO;
}
//下面两段是重点，要服务器端单项HTTPS 验证，iOS 客户端忽略证书验证。
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
} 
- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge 
{    
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]){
        [[challenge sender]  useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
        [[challenge sender]  continueWithoutCredentialForAuthenticationChallenge: challenge];
    }
} 

//处理数据 s
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{ 
    OAServiceTicket *ticket = [[[OAServiceTicket alloc] initWithRequest:request
                                                              response:response
                                                            didSucceed:[(NSHTTPURLResponse *)response statusCode] < 400] autorelease];
    
    
    responseData = data;
//    [NSMutableData dataWithData:responseData];
    [_mindelegate requestTokenTicket:ticket finishedWithData:[NSMutableData dataWithData:responseData]];
//    [delegate performSelector:didFinishSelector
//                   withObject:ticket
//                   withObject:responseData];

} 


-(void) dealloc
{
    [pNSURLConnection release];
    [super dealloc];
}

@end
