//
//  HttpManager.h
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/14.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpHeader.h"
#import "TypeHeader.h"

// 请求成功回调
typedef void (^SuccessBlock)(NSDictionary *returnData);

//请求失败回调
typedef void (^FailureBlock)(NSError *error);

@interface HttpManager : NSObject

//开始网络监测
+ (void)startMonitoring;

+ (void)cancelAllNetWorking;

//请求预警列表
+ (void)requestNewsListWithParams:(NSDictionary*)params successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

//修改userKey
+ (void)modifyUserKeySuccessBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

//请求收藏的新闻
+ (void)requestLikeNewsSuccessBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

//获取用户权限
+ (void)requestUserPermissionSuccessBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

//获取咨讯
+ (void)requestZiXunTitleListSuccessBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

//登陆
+ (void)requestLoginUserName:(NSString *)name passWord:(NSString *)passWord successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

//获取舆情关注
+ (void)requestAttention:(NSString *)dataType successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

//获取广告图片
+ (void)requestAdvertiseImageVersion:(NSString *)version SuccessBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

//上传头像
+ (void)uploadUserHeadPhoto:(NSData*)imageData SuccessBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

//修改用户昵称@"nickname"或电话@"mobile"
+ (void)requestModifyKey:(NSString *)key value:(NSString *)value SuccessBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

//修改用户密码
+ (void)requestModifyPassword:(NSString *)newPassword oldPassword:(NSString *)oldPassword SuccessBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

//申请定制服务
+ (void)requestApplyFoucs:(NSString *)name applyFoucsType:(ApplyFoucsType)applyFoucsType SuccessBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

//获取申请记录
+ (void)requestApplyRecordAapplyFoucsType:(ApplyFoucsType)applyFoucsType SuccessBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

//取消收藏
+ (void)requestDeletedLikeNews:(NSString *)newsId SuccessBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

//添加收藏
+ (void)requestAddLikeNews:(NSDictionary *)parame SuccessBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

//获取Default资讯
+ (void)requestDefaultInformation:(int)currentPage type:(NSString *)type SuccessBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

//获取Custom资讯
+ (void)requestCustomInformation:(int)currentPage itemId:(NSString *)itemId SuccessBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

//退出登录
+ (void)requestLogoutSuccessBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

@end
