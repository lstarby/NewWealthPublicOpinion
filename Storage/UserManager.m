//
//  UserManager.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/16.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "UserManager.h"
#import "UserHeader.h"
#import "CacheHeader.h"
#import "KeyChainTool.h"

@implementation UserManager

//保存DeviceToken
+ (void)saveDeviceToken:(NSString*)deviceToken {
    [[NSUserDefaults standardUserDefaults] setObject:deviceToken forKey:SAVE_USER_DEVICE_TOKEN];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/**
 *  用户退出登录
 */
+ (void)userLogout {
    [UserManager userAlreadyLogout];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:SAVE_USER_ID];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/**
 *  保存用户信息
 *
 *  @param user 用户对象
 */
+ (void)saveUserInfo:(LoginUser *)user {
    [UserManager userAlreadyLogin];
    [UserHandler sharedUserHandler].loginUser = user;
    [CacheManager writeFile:[CacheManager documentRelativePath:FILE_USER_ACCOUNT] object:user];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/**
 *  保存用户channel
 *
 *  @param channelArray channel
 */
+ (void)saveUserChannel:(NSArray *)channelArray {
    [UserHandler sharedUserHandler].userChannels = channelArray;
    [CacheManager writeFile:[CacheManager documentRelativePath:FILE_USER_CHANNEL] objectArray:channelArray];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/**
 *  保存keyWordType
 *
 *  @param keyWord keyWordType
 */
+ (void)saveKeyWordType:(NSArray *)keyWordTypes {
    NSMutableDictionary *keyWordDic = [NSMutableDictionary dictionary];
    for ( NSDictionary *dic in keyWordTypes ) {
        NSString *sId = [dic objectForKey:@"id"];
        NSString *sName = [dic objectForKey:@"name"];
        [keyWordDic setObject:sName forKey:sId];
    }
    [UserHandler sharedUserHandler].keyWordType = keyWordDic;
    [CacheManager writeFile:[CacheManager documentRelativePath:FILE_USER_KEYWORD] dict:keyWordDic];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/**
 *  保存Urltype
 *
 *  @param newsUrls newsUrls
 */
+ (void)saveNewsUrl:(NSArray *)newsUrls {
    NSMutableDictionary *detailListDict = [NSMutableDictionary dictionary];
    for ( NSDictionary *dict in newsUrls ) {
        NSString *type = [dict objectForKey:@"URLTYPE"];
        NSString *strUrl = [dict objectForKey:@"URL"];
        [detailListDict setObject:strUrl forKey:type];
    }
    [UserHandler sharedUserHandler].urlType = detailListDict;
    [CacheManager writeFile:[CacheManager documentRelativePath:FILE_USER_URLTYPE] dict:detailListDict];
    [[NSUserDefaults standardUserDefaults] synchronize];
}



/**
 *  清除用户信息
 */
+ (void)clearUserInfo {
    [UserManager userAlreadyLogout];
    UserHandler *userHandler = [UserHandler sharedUserHandler];
    userHandler.userKey = nil;
    userHandler.keyWordType = nil;
    userHandler.loginUser = nil;
    userHandler.userChannels = nil;
    userHandler.urlType = nil;
    [CacheManager deleteFile:[CacheManager documentRelativePath:FILE_USER_ACCOUNT]];
}

/**
 *  读取用户信息
 */
+ (void)readUserInfo {
    UserHandler *userHandler = [UserHandler sharedUserHandler];
    userHandler.loginUser = [CacheManager objectFromeFile:[CacheManager documentRelativePath:FILE_USER_ACCOUNT]];
    if (userHandler.loginUser) {
        [UserManager userAlreadyLogin];
    }
    userHandler.keyWordType = [CacheManager dictFromFile:[CacheManager documentRelativePath:FILE_USER_KEYWORD]];
    userHandler.urlType = [CacheManager dictFromFile:[CacheManager documentRelativePath:FILE_USER_URLTYPE]];
    userHandler.userChannels = [CacheManager arrayFromFile:[CacheManager documentRelativePath:FILE_USER_CHANNEL]];
    userHandler.userKey = [[NSUserDefaults standardUserDefaults] objectForKey:SAVE_USER_KEY];
    
}

/**
 *  保存UserKey
 *
 *  @param userKey UserKey
 */
+ (void)saveUserKey:(NSString*)userKey {
    [UserHandler sharedUserHandler].userKey = userKey;;
    [[NSUserDefaults standardUserDefaults] setObject:userKey forKey:SAVE_USER_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/**
 *  获取userKey
 *
 *  @return userKey
 */
+ (NSString*)getUserKey {
    NSString *strUserKey = [[NSUserDefaults standardUserDefaults] objectForKey:SAVE_USER_KEY];
    if (strUserKey == nil) {
        strUserKey =  @"";
        [UserManager saveUserKey:strUserKey];
    }
    return strUserKey;
}

/**
 *  记住我
 *
 *  @param me 我
 */
+ (void)saveRememberMe:(NSString*)me {
    [[NSUserDefaults standardUserDefaults] setObject:me forKey:SAVE_USER_REMEMBERME];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/**
 *  获取是否记住用户
 *
 *  @return 默认“0” 不记住
 */
+ (NSString*)getRemeberMe {
    NSString *meState = [[NSUserDefaults standardUserDefaults] objectForKey:SAVE_USER_REMEMBERME];
    if ( meState == nil) {
        meState = @"0";
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:SAVE_USER_REMEMBERME];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    return meState;
}

/**
 *  设置字体
 *
 *  @param systemFont 字体 小“0” 中“1” 大“2”
 */
+ (void)SaveSystemFont:(NSString*)systemFont {
    [[NSUserDefaults standardUserDefaults] setObject:systemFont forKey:SAVE_USER_SYSTEMFONT];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/**
 *  获取字体大小
 *
 *  @return 字体大小 默认中：“1”
 */
+ (NSString*)getSystemFont {
    NSString *systemFont = [[NSUserDefaults standardUserDefaults] objectForKey:SAVE_USER_SYSTEMFONT];
    if ( systemFont == nil ) {
        systemFont = @"1";
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:SAVE_USER_SYSTEMFONT];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    return systemFont;
}

/**
 *  保存用户名和密码
 *
 *  @param name     用户名
 *  @param password 密码
 */
+ (void)saveUserName:(NSString *)name passWord:(NSString *)password {
    NSMutableDictionary *usernamepasswordKVPairs = [NSMutableDictionary dictionary];
    [usernamepasswordKVPairs setObject:name forKey:SAVE_USER_LOGIN_NAME];
    [usernamepasswordKVPairs setObject:password forKey:SAVE_USER_LOGIN_PWD];
    [KeyChainTool save:KEY_IN_KEYCHAIN data:usernamepasswordKVPairs];
}

/**
 *  读取用户名
 *
 *  @return 用户名
 */
+ (NSString *)readUserName {
    NSMutableDictionary *usernamepasswordKVPair = (NSMutableDictionary *)[KeyChainTool load:KEY_IN_KEYCHAIN];
    return [usernamepasswordKVPair objectForKey:SAVE_USER_LOGIN_NAME];
}

/**
 *  读取密码
 *
 *  @return 密码
 */
+ (NSString *)readPassWord {
    NSMutableDictionary *usernamepasswordKVPair = (NSMutableDictionary *)[KeyChainTool load:KEY_IN_KEYCHAIN];
    return [usernamepasswordKVPair objectForKey:SAVE_USER_LOGIN_PWD];
}

/**
 *  引导页保存标签
 */
+ (void)saveGuideTag {
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:SAVE_USER_GUIDE_TAG];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/**
 *  获取引导页标识
 *
 *  @return 是否有引导页
 */
+ (BOOL)getGuideTag {
    NSString *guideTag = [[NSUserDefaults standardUserDefaults] objectForKey:SAVE_USER_GUIDE_TAG];
    if ([guideTag isEqualToString:@"1"]) {
        return TRUE;
    }
    return FALSE;
}

/**
 *  设置重新刷新首页
 *
 *  @param refreshTag 是否刷新
 */
+ (void)saveMainNewsRefreshTag:(NSString*)refreshTag {
    [[NSUserDefaults standardUserDefaults] setObject:refreshTag forKey:SAVE_USER_MAINNEWS_REFRESH_TAG];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/**
 *  获取是否刷新首页
 *
 *  @return 刷新标示
 */
+ (BOOL)getMainNewsRefreshTag {
    NSString *guideTag = [[NSUserDefaults standardUserDefaults] objectForKey:SAVE_USER_MAINNEWS_REFRESH_TAG];
    if ([guideTag isEqualToString:@"1"]) {
        return TRUE;
    }
    return FALSE;;
}

/**
 *  用户是否登录
 *
 *  @return
 */
+ (BOOL)userIsAlreadLogin {
    return  [[NSUserDefaults standardUserDefaults] boolForKey:USER_ALREADY_LOGIN];
}

/**
 *  用户已登录
 */
+ (void)userAlreadyLogin {
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:USER_ALREADY_LOGIN];
}

/**
 *  用户已退出
 */
+ (void)userAlreadyLogout {
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:USER_ALREADY_LOGIN];
}

@end
