//
//  UserManager.h
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/16.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LoginUser;
@class URLType;

@interface UserManager : NSObject

/**
 *  用户退出登录
 */
+ (void)userLogout;

/**
 *  保存用户信息
 *
 *  @param user 用户对象
 */
+ (void)saveUserInfo:(LoginUser *)user;

/**
 *  保存用户channel
 *
 *  @param channelArray channel
 */
+ (void)saveUserChannel:(NSArray *)channelArray;

/**
 *  保存keyWordType
 *
 *  @param keyWord keyWordType
 */
+ (void)saveKeyWordType:(NSArray *)keyWordTypes;

/**
 *  保存Urltype
 *
 *  @param newsUrls newsUrls
 */
+ (void)saveNewsUrl:(NSArray *)newsUrls;

/**
 *  清除用户信息
 */
+ (void)clearUserInfo;

/**
 *  读取用户信息
 */
+ (void)readUserInfo;

/**
 *  保存UserKey
 *
 *  @param userKey UserKey
 */
+ (void)saveUserKey:(NSString*)userKey;

/**
 *  获取userKey
 *
 *  @return userKey
 */
+ (NSString*)getUserKey;

/**
 *  记住我
 *
 *  @param me 我
 */
+ (void)saveRememberMe:(NSString*)me;

/**
 *  获取是否记住用户
 *
 *  @return 默认“0” 不记住
 */
+ (NSString*)getRemeberMe;

/**
 *  设置字体
 *
 *  @param systemFont 字体 小“0” 中“1” 大“2”
 */
+ (void)SaveSystemFont:(NSString*)systemFont;

/**
 *  获取字体大小
 *
 *  @return 字体大小 默认中：“1”
 */
+ (NSString*)getSystemFont;

/**
 *  保存用户名和密码
 *
 *  @param name     用户名
 *  @param password 密码
 */
+ (void)saveUserName:(NSString *)name passWord:(NSString *)password;

/**
 *  读取用户名
 *
 *  @return 用户名
 */
+ (NSString *)readUserName;

/**
 *  读取密码
 *
 *  @return 密码
 */
+ (NSString *)readPassWord;

/**
 *  引导页保存标签
 */
+ (void)saveGuideTag;

/**
 *  获取引导页标识
 *
 *  @return 是否有引导页
 */
+ (BOOL)getGuideTag;

/**
 *  设置重新刷新首页
 *
 *  @param refreshTag 是否刷新
 */
+ (void)saveMainNewsRefreshTag:(NSString*)refreshTag;

/**
 *  获取是否刷新首页
 *
 *  @return 刷新标示
 */
+ (BOOL)getMainNewsRefreshTag;

/**
 *  用户是否登录
 *
 *  @return
 */
+ (BOOL)userIsAlreadLogin;

@end
