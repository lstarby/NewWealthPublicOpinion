//
//  HelpManager.h
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/23.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^CompletionBlock)(BOOL success);

@interface HelpManager : NSObject

//游客
+ (BOOL)isVisitor;

//退出登录
+ (void)userLogOut;

//更新Userkey
+ (void)upLoadUserKey;

//获取收藏
+ (void)loadLikeNews:(CompletionBlock)completion;

//获取权限
+ (void)getUserPermission:(CompletionBlock)completion;

//获取资讯列表样式
+ (void)getZiXunTitleList;

//初始化关注
+ (void)initAttentionData;

@end
