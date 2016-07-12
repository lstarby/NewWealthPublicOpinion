//
//  AppDelegate+Extend.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/8.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "AppDelegate+Extend.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>

#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

#import "WXApi.h"

#import "WeiboSDK.h"

#import <JPush/JPUSHService.h>

#import "VendorHeader.h"



@implementation AppDelegate (Extend)

/**
 *  设置URL缓存
 */
- (void)initURLCache{
    NSURLCache *urlCache = [[NSURLCache alloc] initWithMemoryCapacity:1024 * 1024 diskCapacity:20 * 1024 * 1024 diskPath:nil];
    [NSURLCache setSharedURLCache:urlCache];
}


- (void)addShareSDKWithapplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
     //初始化配置
     [self initShareSDK];
 }

- (void)addJPushSDKWithapplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
     [self initJPushWithOptions:launchOptions];
}

/**
 *  初始化分享
 */
- (void)initShareSDK{
    [ShareSDK registerApp:kShareAPPKey
     
          activePlatforms:@[@(SSDKPlatformTypeMail),
                            @(SSDKPlatformTypeSMS),
                            @(SSDKPlatformTypeSinaWeibo),
                            @(SSDKPlatformTypeWechat),
                            @(SSDKPlatformTypeQQ),
                            @(SSDKPlatformTypeTencentWeibo),
                            ]
                 onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
                 case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
                 case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
                 case SSDKPlatformTypeSinaWeibo:
                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                 break;
             default:
                 break;
         }
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
                 case SSDKPlatformTypeSinaWeibo:
                 //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                 [appInfo SSDKSetupSinaWeiboByAppKey:kSinaWeiboAPPKey                                           appSecret:kSinaWeiboAPPSecret
                                         redirectUri:kSinaWeiboRedirectUri
                                            authType:SSDKAuthTypeBoth];
                 break;
                 case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:kWechatAPPId                                       appSecret:kWechatAPPSecret];
                 break;
                 case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:kQQAPPId
                                      appKey:kQQAPPKey
                                    authType:SSDKAuthTypeBoth];
                 break;
                 case SSDKPlatformTypeTencentWeibo:
                 //设置腾讯微博应用信息，其中authType设置为只用Web形式授权
                 [appInfo SSDKSetupTencentWeiboByAppKey:kTencentWeiboAPPKey                                              appSecret:kTencentWeiboAPPSecret
                                            redirectUri:kTencentWeiboRedirectUri];
                 break;
                 
             default:
                 break;
         }
     }];
}

/**
 *  初始化推送
 *
 *  @param launchOptions launchOptions
 */
- (void)initJPushWithOptions:(NSDictionary *)launchOptions{
    if (kiOS8) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    } else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
    
    [JPUSHService setupWithOption:launchOptions appKey:kJPushAPPKey channel:kJPushChannel apsForProduction:NO];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(networkDidLogin:)
                                                 name:kJPFNetworkDidLoginNotification
                                               object:nil];
    
}
/**
 *  极光推送登陆
 *
 *  @param notification notification
 */
- (void)networkDidLogin:(NSNotification *)notification {
    NSString *str= [JPUSHService registrationID];
    NSLog(@"registrationID-->>%@",str);
}


- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    [JPUSHService registerDeviceToken:deviceToken];
    
}

- (void)application:(UIApplication *)application
didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
    
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
- (void)application:(UIApplication *)application
didRegisterUserNotificationSettings:
(UIUserNotificationSettings *)notificationSettings {
}

- (void)application:(UIApplication *)application
handleActionWithIdentifier:(NSString *)identifier
forLocalNotification:(UILocalNotification *)notification
  completionHandler:(void (^)())completionHandler {
}

- (void)application:(UIApplication *)application
handleActionWithIdentifier:(NSString *)identifier
forRemoteNotification:(NSDictionary *)userInfo
  completionHandler:(void (^)())completionHandler {
}
#endif

#pragma mark - 获取推送信息
- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:
(void (^)(UIBackgroundFetchResult))completionHandler {
    [JPUSHService handleRemoteNotification:userInfo];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [JPUSHService setBadge:0];
#warning 111
}

@end
