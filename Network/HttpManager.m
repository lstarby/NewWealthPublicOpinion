//
//  HttpManager.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/14.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "HttpManager.h"
#import "NetworkManager.h"
#import "MBProgressHUD+Extend.h"
#import "SIAlertView+Extend.h"
#import "UserHandler.h"
#import "UploadParam.h"

@implementation HttpManager

//开始网络监测
+ (void)startMonitoring {
    [NetworkManager startMonitoring];
}

+ (void)cancelAllNetWorking {
    [NetworkManager cancelAllNetWorking];
}

+ (NSString *)getRequestURL:(NSString *)url {
    return [NSString stringWithFormat:@"%@/%@",kBaseUrl,url];
}

+ (NSString *)getUploadURL:(NSString *)url {
    return [NSString stringWithFormat:@"%@/%@",kPhoto,url];
}


//请求预警列表
+ (void)requestNewsListWithParams:(NSDictionary*)params successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock {
    NSString *url = [HttpManager getRequestURL:kNewsList];
    [NetworkManager getRequestWithURL:url params:params showHUD:kShowHUD  progressBlock:nil successBlock:^(NSDictionary *returnData) {
        if (successBlock) {
            successBlock(returnData);
        }
    } failureBlock:^(NSError *error) {
        [self requestFailed:error];
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

//修改userKey
+ (void)modifyUserKeySuccessBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock {
    NSString *url = [HttpManager getRequestURL:kModifyUserKey];
    NSString *userId = [UserHandler sharedUserHandler].loginUser.userId;
    if (userId == nil || [userId isEqualToString:@""]) {
        return;
    }
    NSString *userKey = [UserHandler sharedUserHandler].userKey;
    if (userKey == nil || [userKey isEqualToString:@""]) {
        return;
    }
    NSDictionary *parame = @{@"userId":userId,
                             @"uk": userKey,
                             @"clientType":@"ios" };
    [NetworkManager getRequestWithURL:url params:parame showHUD:kShowHUD progressBlock:nil successBlock:^(NSDictionary *returnData) {
        if (successBlock) {
            successBlock(returnData);
        }
    } failureBlock:^(NSError *error) {
        [self requestFailed:error];
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

//请求收藏的新闻
+ (void)requestLikeNewsSuccessBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock {
    NSString *url = [HttpManager getRequestURL:kLikeNews];
    NSString *userId = [UserHandler sharedUserHandler].loginUser.userId;
    if (userId == nil || [userId isEqualToString:@""]) {
        return;
    }
    NSDictionary *parame = @{@"userId":userId,
                             @"method": @"down",
                             @"pageSize":@"100000" };
    [NetworkManager getRequestWithURL:url params:parame showHUD:kShowHUD progressBlock:nil successBlock:^(NSDictionary *returnData) {
        if (successBlock) {
            successBlock(returnData);
        }
    } failureBlock:^(NSError *error) {
        [self requestFailed:error];
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

//获取用户权限 
+ (void)requestUserPermissionSuccessBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock {
    NSString *url = [HttpManager getRequestURL:kUserPermission];
    NSString *userId = [UserHandler sharedUserHandler].loginUser.userId;
    if (userId == nil || [userId isEqualToString:@""]) {
        failureBlock(nil);
        return;
    }
    NSDictionary *parame = @{@"userId":userId };
    [NetworkManager getRequestWithURL:url params:parame showHUD:NO progressBlock:nil successBlock:^(NSDictionary *returnData) {
        if (successBlock) {
            successBlock(returnData);
        }
    } failureBlock:^(NSError *error) {
        if (failureBlock) {
            failureBlock(error);
        }
        [self requestFailed:error];
    }];
}

//获取咨讯
+ (void)requestZiXunTitleListSuccessBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock {
    NSString *url = [HttpManager getRequestURL:kZiXunTitleList];
    NSString *userId = [UserHandler sharedUserHandler].loginUser.userId;
    if (userId == nil || [userId isEqualToString:@""]) {
        return;
    }
    NSDictionary *parame = @{@"userId":userId };
    [NetworkManager getRequestWithURL:url params:parame showHUD:NO  progressBlock:nil successBlock:^(NSDictionary *returnData) {
        if (successBlock) {
            successBlock(returnData);
        }
    } failureBlock:^(NSError *error) {
        [self requestFailed:error];
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

//登陆
+ (void)requestLoginUserName:(NSString *)name passWord:(NSString *)passWord successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock {
    NSString *url = [HttpManager getRequestURL:kLogin];
    NSDictionary *parame = @{@"username":name,
                             @"password":passWord,
                             @"clientType":@"ios"};
    [NetworkManager getRequestWithURL:url params:parame showHUD:NO progressBlock:nil successBlock:^(NSDictionary *returnData) {
        if (successBlock) {
            successBlock(returnData);
        }
    } failureBlock:^(NSError *error) {
        [self requestFailed:error];
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

//获取舆情关注
+ (void)requestAttention:(NSString *)dataType successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock {
    NSString *url = [HttpManager getRequestURL:kAttention];
    NSString *userId = [UserHandler sharedUserHandler].loginUser.userId;
    if (userId == nil || [userId isEqualToString:@""]) {
        return;
    }
    NSDictionary *parame = @{@"userId":userId ,
                             @"type":dataType };
    [NetworkManager getRequestWithURL:url params:parame showHUD:NO progressBlock:nil successBlock:^(NSDictionary *returnData) {
        if (successBlock) {
            successBlock(returnData);
        }
    } failureBlock:^(NSError *error) {
        //[self requestFailed:error];
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

//获取广告图片
+ (void)requestAdvertiseImageVersion:(NSString *)version SuccessBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock {
    NSString *url = [HttpManager getRequestURL:kAdvertise];
    NSDictionary *parame = @{@"clientType":@"0",
                             @"position":@"0",
                             @"version":version };
    [NetworkManager getRequestWithURL:url params:parame showHUD:NO progressBlock:nil successBlock:^(NSDictionary *returnData) {
        if (successBlock) {
            successBlock(returnData);
        }
    } failureBlock:^(NSError *error) {
        //[self requestFailed:error];
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

//上传头像
+ (void)uploadUserHeadPhoto:(NSData*)imageData SuccessBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock {
    NSString *url = [HttpManager getUploadURL:kUploadPhoto];
    NSString *userId = [UserHandler sharedUserHandler].loginUser.userId;
    if (userId == nil || [userId isEqualToString:@""]) {
        return;
    }
    NSDictionary *parame = @{@"userId":userId,
                             @"lang":[self localeStr]};
    
    UploadParam *uploadParam = [[UploadParam alloc] init];
    uploadParam.data = imageData;
    uploadParam.name = @"photo";
    uploadParam.fileName = @"jpg";
    uploadParam.mimeType = @"image/jpeg";
    
    [NetworkManager uploadFileWithURL:url params:parame showHUD:NO uploadParams:[NSArray arrayWithObject:uploadParam] progressBlock:nil successBlock:^(NSDictionary *returnData) {
        if (successBlock) {
            successBlock(returnData);
        }
    } failureBlock:^(NSError *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

+ (NSString*)localeStr {
    NSLocale* currentLocale = [NSLocale autoupdatingCurrentLocale];
    NSString* countryCode = [currentLocale objectForKey:NSLocaleCountryCode];
    NSString* LanguageCode = [currentLocale objectForKey:NSLocaleLanguageCode];
    if ([LanguageCode isEqualToString:@"zh"]) {
        if ([countryCode isEqualToString:@"HK"]) {
            return @"zh_HK";
        } else {
            return @"zh_CN";
        }
    } else {
        //默认为英语
        return @"en";
    }
}
//修改用户昵称@"nickname"或电话@"mobile"
+ (void)requestModifyKey:(NSString *)key value:(NSString *)value SuccessBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock {
    NSString *url = [HttpManager getRequestURL:kModifyNickName];
    NSString *userId = [UserHandler sharedUserHandler].loginUser.userId;
    if (userId == nil || [userId isEqualToString:@""]) {
        return;
    }
    NSDictionary *parame = @{@"userId":userId,
                             key: value};
    [NetworkManager getRequestWithURL:url params:parame showHUD:NO progressBlock:nil successBlock:^(NSDictionary *returnData) {
        if (successBlock) {
            successBlock(returnData);
        }
    } failureBlock:^(NSError *error) {
        //[self requestFailed:error];
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

//修改用户密码
+ (void)requestModifyPassword:(NSString *)newPassword oldPassword:(NSString *)oldPassword SuccessBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock {
    NSString *url = [HttpManager getRequestURL:kModifyPassword];
    NSString *userName = [UserHandler sharedUserHandler].loginUser.username;
    if (userName == nil || [userName isEqualToString:@""]) {
        return;
    }
    NSDictionary *parame = @{@"username":userName,
                             @"password":oldPassword,
                             @"newPassword": newPassword};
    [NetworkManager getRequestWithURL:url params:parame showHUD:NO progressBlock:nil successBlock:^(NSDictionary *returnData) {
        if (successBlock) {
            successBlock(returnData);
        }
    } failureBlock:^(NSError *error) {
        //[self requestFailed:error];
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

//申请定制服务
+ (void)requestApplyFoucs:(NSString *)name applyFoucsType:(ApplyFoucsType)applyFoucsType SuccessBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock {
    NSString *url = [HttpManager getRequestURL:kApplyFoucs];
    NSString *userId = [UserHandler sharedUserHandler].loginUser.userId;
    if (userId == nil || [userId isEqualToString:@""]) {
        return;
    }
    NSArray *customTypes = @[@"0", @"1"];
    NSDictionary *parame = @{@"customName":name,
                             @"customType":customTypes[applyFoucsType],
                             @"version": VERSION,
                             @"userId":userId };
    [NetworkManager getRequestWithURL:url params:parame showHUD:NO progressBlock:nil successBlock:^(NSDictionary *returnData) {
        if (successBlock) {
            successBlock(returnData);
        }
    } failureBlock:^(NSError *error) {
        [self requestFailed:error];
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

//获取申请记录
+ (void)requestApplyRecordAapplyFoucsType:(ApplyFoucsType)applyFoucsType SuccessBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock {
    NSString *url = [HttpManager getRequestURL:kApplyRecord];
    NSString *userId = [UserHandler sharedUserHandler].loginUser.userId;
    if (userId == nil || [userId isEqualToString:@""]) {
        return;
    }
    NSArray *customTypes = @[@"0", @"1"];
    NSDictionary *parame = @{@"customType":customTypes[applyFoucsType],
                             @"userId":userId };
    [NetworkManager getRequestWithURL:url params:parame showHUD:kShowHUD progressBlock:nil successBlock:^(NSDictionary *returnData) {
        if (successBlock) {
            successBlock(returnData);
        }
    } failureBlock:^(NSError *error) {
        [self requestFailed:error];
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

//取消收藏
+ (void)requestDeletedLikeNews:(NSString *)newsId SuccessBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock {
    NSString *url = [HttpManager getRequestURL:kDeletedLikeNews];

    NSDictionary *parame = @{@"fID":newsId };
    [NetworkManager getRequestWithURL:url params:parame showHUD:NO progressBlock:nil successBlock:^(NSDictionary *returnData) {
        if (successBlock) {
            successBlock(returnData);
        }
    } failureBlock:^(NSError *error) {
        [self requestFailed:error];
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}


//添加收藏
+ (void)requestAddLikeNews:(NSDictionary *)parame SuccessBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock {
    NSString *url = [HttpManager getRequestURL:kAddLikeNews];
    
    [NetworkManager postRequestWithURL:url params:parame showHUD:NO progressBlock:nil successBlock:^(NSDictionary *returnData) {
        if (successBlock) {
            successBlock(returnData);
        }
    } failureBlock:^(NSError *error) {
        //[self requestFailed:error];
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

//获取Default资讯
+ (void)requestDefaultInformation:(int)currentPage type:(NSString *)type SuccessBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock {
    NSString *url = [HttpManager getRequestURL:kDefaultInfo];
    NSString *userId = [UserHandler sharedUserHandler].loginUser.userId;
    if (userId == nil || [userId isEqualToString:@""]) {
        return;
    }
    
    NSDictionary *parame = @{@"type":type,
                             @"userId":userId,
                             @"pageSize":@"20",
                             @"currentPageNo":[NSString stringWithFormat:@"%d",currentPage]};
    [NetworkManager getRequestWithURL:url params:parame showHUD:NO progressBlock:nil successBlock:^(NSDictionary *returnData) {
        if (successBlock) {
            successBlock(returnData);
        }
    } failureBlock:^(NSError *error) {
        [self requestFailed:error];
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

//获取Custom资讯
+ (void)requestCustomInformation:(int)currentPage itemId:(NSString *)itemId SuccessBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock {
    NSString *url = [HttpManager getRequestURL:kCustomInfo];
    NSString *userId = [UserHandler sharedUserHandler].loginUser.userId;
    if (userId == nil || [userId isEqualToString:@""]) {
        return;
    }
    
    NSDictionary *parame = @{@"itemId":itemId,
                             @"userId":userId,
                             @"pageSize":@"20",
                             @"currentPageNo":[NSString stringWithFormat:@"%d",currentPage]};
    [NetworkManager getRequestWithURL:url params:parame showHUD:NO progressBlock:nil successBlock:^(NSDictionary *returnData) {
        if (successBlock) {
            successBlock(returnData);
        }
    } failureBlock:^(NSError *error) {
        [self requestFailed:error];
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

//退出登录
+ (void)requestLogoutSuccessBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock {
    NSString *url = [HttpManager getRequestURL:kLogout];
    NSString *userId = [UserHandler sharedUserHandler].loginUser.userId;
    if (userId == nil || [userId isEqualToString:@""]) {
        return;
    }
    NSString *userKey = [UserHandler sharedUserHandler].userKey;
    if (!userKey) {
        userKey = @"-1";
    }

    NSDictionary *parame = @{@"userId":userId,
                             @"uk":userKey };
    [NetworkManager getRequestWithURL:url params:parame showHUD:NO progressBlock:nil successBlock:^(NSDictionary *returnData) {
        if (successBlock) {
            successBlock(returnData);
        }
    } failureBlock:^(NSError *error) {
        [self requestFailed:error];
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

+ (void)requestFailed:(NSError *)error{
    DLog(@"%ld/n%@",error.code,error.debugDescription);
    switch (error.code) {
        case HttpErrorType_NONetwork :
            [MBProgressHUD showError:@"网络链接失败"];
            //[SIAlertView createOneButtonAlertView:@"提示" message:@"网络链接失败，请检查网络。" buttonName:@"确定" clicked:nil];
            break;
        case HttpErrorType_TimedOut :
            [MBProgressHUD showError:@"访问服务器超时"];
            //[SIAlertView createOneButtonAlertView:@"提示" message:@"访问服务器超时，请检查网络。" buttonName:@"确定" clicked:nil];
            break;
        case HttpErrorType_404Failed :
            [MBProgressHUD showError:@"访问服务器失败"];
            //[SIAlertView createOneButtonAlertView:@"提示" message:@"服务器报错了，请稍后再访问。" buttonName:@"确定" clicked:nil];
            break;
    }
}

@end
