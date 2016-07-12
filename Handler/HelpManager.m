//
//  HelpManager.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/23.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "HelpManager.h"
#import "HttpManager.h"
#import "UserHeader.h"
#import "DBManager.h"
#import "MBProgressHUD+Extend.h"
#import "NSString+Extend.h"

@implementation HelpManager

//游客
+ (BOOL)isVisitor {
    NSString *name = [UserHandler sharedUserHandler].loginUser.name;
    NSString *password = [UserHandler sharedUserHandler].loginUser.password;
    if ([name isEqualToString:USERTYPE_GUEST_USERNAME] && [password isEqualToString:USERTYPE_GUEST_USERPWD]) {
        [MBProgressHUD showError:@"游客身份，不能操作"];
        return YES;
    }
    return NO;
}

//退出登录
+ (void)userLogOut {
    [DBManager deleteDB];
    [UserManager clearUserInfo];
}

//更新Userkey
+ (void)upLoadUserKey {
    if (![UserManager userIsAlreadLogin]) {
        return;
    }
    [HttpManager modifyUserKeySuccessBlock:^(NSDictionary *returnData) {
        DLog(@"UserKey修改成功");
    } failureBlock:nil];
}

//获取收藏
+ (void)loadLikeNews:(CompletionBlock)completion {
    [HttpManager requestLikeNewsSuccessBlock:^(NSDictionary *returnData) {
        if (returnData == nil) {
            completion(NO);
            return;
        }
        NSArray *likes = returnData[@"items"];
        if (likes.count == 0) {
            completion(NO);
            return;
        }
        if ([returnData[kStatus] intValue] == kSuccess) {
            NSError* error = nil;
            for (NSDictionary *dict in likes) {
                LikeNewsModel *likeNews = [[LikeNewsModel alloc] initWithDictionary:dict error:&error];
                if (error) {
                    DLog(@"json解析错误");
                    continue;
                }
                likeNews.publishTime = [likeNews.publishDate getTime];
                likeNews.createTime = [likeNews.createDate getTime];
                CGFloat height = [likeNews.title sizeForFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(kSCREEN_WIDTH - 40, 300.0f)].height;
                likeNews.height = [NSNumber numberWithFloat:height];
                likeNews.isSeleted = [NSNumber numberWithBool:NO];
                [DBManager insertLikeNewsWhenNotExists:likeNews];
            }
            completion(YES);
        } else {
            completion(NO);
        }
        
    } failureBlock:nil];
}

//获取权限
+ (void)getUserPermission:(CompletionBlock)completion {
    [HttpManager requestUserPermissionSuccessBlock:^(NSDictionary *returnData) {
        if (!returnData) {
            completion(NO);
            return;
        }
        if ([returnData[kStatus] intValue] == kSuccess) {
            [DBManager clearAllPermission];
            [DBManager updateMenuTable:returnData[@"permission"]];
            completion(YES);
        } else {
            completion(NO);
        }
    } failureBlock:^(NSError *error) {
         completion(NO);
    }];
}

//获取资讯列表样式
+ (void)getZiXunTitleList {
    [HttpManager requestZiXunTitleListSuccessBlock:^(NSDictionary *returnData) {
        if (!returnData) {
            return;
        }
         if ([returnData[kStatus] intValue] == kSuccess) {
             NSMutableArray *userChannels = [NSMutableArray array];
             NSArray *array = returnData[@"items"];
             for (NSDictionary *dict in array) {
                 NSError *error = nil;
                 UserChannel *userChannel = [[UserChannel alloc] initWithDictionary:dict error:&error];
                 [userChannels addObject:userChannel];
             }
             [UserManager saveUserChannel:userChannels];
         }
    } failureBlock:nil];
}

//初始化关注
+ (void)initAttentionData {
    //[MBProgressHUD showMessage:@"正在初始化数据..."];
    NSString *dataType = @"0";
    [HttpManager requestAttention:dataType successBlock:^(NSDictionary *returnData) {
        if (returnData == nil) {
            //[MBProgressHUD showError:@"初始化数据失败!"];
            return ;
        }
        if ([returnData[kStatus] intValue] == kSuccess) {
            NSArray *array = [returnData objectForKey:@"items"];
            for (NSDictionary *dict in array) {
                NSError *error = nil;
                AddAttentionModel *attention = [[AddAttentionModel alloc] initWithDictionary:dict error:&error];
                if (error) {
                    return;
                }
                [DBManager insertAddAttentionWhenNotExists:attention];
            }
        }
        //[MBProgressHUD hideHUD];
    } failureBlock:^(NSError *error) {
        //[MBProgressHUD showError:@"初始化数据失败!"];
    }];
}

@end
