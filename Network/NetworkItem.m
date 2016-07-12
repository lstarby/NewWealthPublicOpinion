//
//  NetworkItem.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/14.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "NetworkItem.h"
#import <AFNetworking/AFNetworking.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import <objc/runtime.h>
#import "UserHandler.h"

static char  hudKey;

@implementation NetworkItem

/**
 *  创建一个网络请求项，开始请求网络
 *
 *  @param networkType  网络请求方式
 *  @param url          网络请求URL
 *  @param params       网络请求参数
 *  @param showHUD      是否显示HUD
 *  @param progressBlock 进度block
 *  @param successBlock 请求成功后的block
 *  @param failureBlock 请求失败后的block
 *
 *  @return NetworkItem对象
 */
- (NetworkItem *)initWithtype:(NetWorkType)networkType
                               url:(NSString *)url
                            params:(NSDictionary *)params
                           showHUD:(BOOL)showHUD
                        progressBlock:(NetworkProgressBlock)progressBlock
                      successBlock:(NetworkSuccessBlock)successBlock
                      failureBlock:(NetworkFailureBlock)failureBlock
{
    if (self = [super init])
    {
        self.networkType    = networkType;
        self.url            = url;
        self.params         = params;
        self.showHUD        = showHUD;
        
        if (showHUD==YES) {
            [NetworkItem hud:kGraceTime];
        }
        __weak typeof(self)weakSelf = self;
        DLog(@"--请求url地址--%@\n",url);
        DLog(@"----请求参数%@\n",params);
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer.timeoutInterval = NET_TIME_OUT;

        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject: @"text/html"];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        //[manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        //manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        //[manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];

        // AFN不会解析,数据是data，需要自己解析
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        // AFN会JSON解析返回的数据
        //manager.responseSerializer = [AFJSONResponseSerializer serializer];

        if (networkType == NetWorkGET)
        {
            NSString *getUrl = [self getUrl:url withParames:params];
            NSString *head = [UserHandler getAuthorization:getUrl isGET:YES];
            if (head) {
                [manager.requestSerializer setValue:head forHTTPHeaderField:@"Authorization"];
            }
            
            [manager GET:getUrl parameters:nil progress:progressBlock success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [NetworkItem hideHud];
                if (successBlock) {
                    NSDictionary *jsonDict = [weakSelf sortOutResponseObject:responseObject];
                    successBlock(jsonDict);
                }
                [weakSelf removewItem];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [NetworkItem hideHud];
                DLog(@"---error==%@\n",error.localizedDescription);
                if (failureBlock) {
                    failureBlock(error);
                }
                [weakSelf removewItem];
            }];
            
        }
        else {
            NSString *head = [UserHandler getAuthorization:url isGET:NO];
            if (head) {
                [manager.requestSerializer setValue:head forHTTPHeaderField:@"Authorization"];
            }
            [manager POST:url parameters:params progress:progressBlock success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [NetworkItem hideHud];
                if (successBlock) {
                    NSDictionary *jsonDict = [self sortOutResponseObject:responseObject];
                    successBlock(jsonDict);
                }
                [weakSelf removewItem];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [NetworkItem hideHud];
                DLog(@"---error==%@\n",error.localizedDescription);
                if (failureBlock) {
                    failureBlock(error);
                }
                [weakSelf removewItem];
            }];
        }
    }
    return self;
}

- (NSString *)getUrl:(NSString *)url withParames:(id)params {
    NSString *query = [NSString stringWithFormat:[url rangeOfString:@"?"].location == NSNotFound ? @"?%@" : @"&%@", AFQueryStringFromParameters(params)];
    return [url stringByAppendingString:query];
}

/**
 *  创建一个文件上传项，开始上传文件
 *
 *  @param url          网络请求URL
 *  @param params       网络请求参数
 *  @param showHUD      是否显示HUD
 *  @param uploadParams 上传文件的参数
 *  @param progressBlock 进度block
 *  @param successBlock 请求成功后的block
 *  @param failureBlock 请求失败后的block
 *
 *  @return NetworkItem对象
 */
- (NetworkItem *)initWithURL:(NSString *)url
                       params:(NSDictionary *)params
                      showHUD:(BOOL)showHUD
                    uploadParams:(NSArray *)uploadParams
                progressBlock:(NetworkProgressBlock)progressBlock
                 successBlock:(NetworkSuccessBlock)successBlock
                 failureBlock:(NetworkFailureBlock)failureBlock

{
    if (self = [super init])
    {
        self.url            = url;
        self.params         = params;
        self.showHUD        = showHUD;
        self.uploadParams    = uploadParams;
        
        UIView *windowView = (UIView*)[[[UIApplication sharedApplication]delegate]window];
        if (showHUD==YES) {
            [MBProgressHUD showHUDAddedTo:windowView animated:YES];
        }
        __weak typeof(self)weakSelf = self;
        DLog(@"--请求url地址--%@\n",url);
        DLog(@"----请求参数%@\n",params);
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject: @"text/html"];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSString *head = [UserHandler getAuthorization:url isGET:NO];
        if (head) {
            [manager.requestSerializer setValue:head forHTTPHeaderField:@"Authorization"];
        }
        [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            for (UploadParam *uploadParam in uploadParams) {
                [formData appendPartWithFileData:uploadParam.data name:uploadParam.name fileName:uploadParam.fileName mimeType:uploadParam.mimeType];
            }
        } progress:progressBlock success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [MBProgressHUD hideHUDForView:windowView animated:YES];
            DLog(@"----> %@",responseObject);
            if (successBlock) {
                NSDictionary *jsonDict = [self sortOutResponseObject:responseObject];
                successBlock(jsonDict);
            }
            [weakSelf removewItem];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [MBProgressHUD hideAllHUDsForView:windowView animated:YES];
            DLog(@"----> %@",error.description);
            if (failureBlock) {
                failureBlock(error);
            }
            [weakSelf removewItem];
        }];
    }
    return self;
}

/**
 *  创建一个下载任务
 *
 *  @param url             下载URL
 *  @param filePath        下载地址
 *  @param showHUD         是否显示HUD
 *  @param progressBlock   进度block
 *  @param completionBlock 下载完成block
 *
 *  @return NetworkItem对象
 */
- (NetworkItem *)initDownLoadWithURL:(NSString *)url
            filePath:(NSString *)filePath
            showHUD:(BOOL)showHUD
            progressBlock:(NetworkProgressBlock)progressBlock
            completionBlock:(NetworkDownLoadCompletionBlock)completionBlock

{
    if (self = [super init])
    {
        self.url            = url;
        self.filePath       = filePath;
        self.showHUD        = showHUD;
        
        UIView *windowView = (UIView*)[[[UIApplication sharedApplication]delegate]window];
        if (showHUD==YES) {
            [MBProgressHUD showHUDAddedTo:windowView animated:YES];
        }
        __weak typeof(self)weakSelf = self;
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        //下载任务
        self.task = [manager downloadTaskWithRequest:request progress:progressBlock destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
            if (filePath) {
                return [NSURL fileURLWithPath:filePath];
            }
            DLog(@"默认下载地址%@",targetPath);
            // 设置下载路径,通过沙盒获取缓存地址,最后返回NSURL对象
            NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
            NSString *path = [cachesPath stringByAppendingPathComponent:response.suggestedFilename];
            return [NSURL fileURLWithPath:path]; // 返回的是文件存放在本地沙盒的地址
        } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
            // 下载完成调用的方法
            DLog(@"%@---%@", response, filePath);
            if (completionBlock) {
                if (error) {
                    completionBlock(response, filePath, NO);
                }
                completionBlock(response, filePath, YES);
            }
            [weakSelf removewItem];
        }];
        // 5.启动下载任务
        [self.task resume];
    }
    return self;
}

/**
 *  暂停下载
 */
- (void)stopDownloadItem{
    [self.task suspend];
}

/**
 *  继续下载
 */
- (void)starDownLoadItem{
    [self.task resume];
}

/**
 *   移除网络请求项
 */
- (void)removewItem
{
    __weak typeof(self)weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([weakSelf.delegate respondsToSelector:@selector(netWorkWillDealloc:)]) {
            [weakSelf.delegate netWorkWillDealloc:weakSelf];
        }
    });
}

/**
 *  解析Data为JSON数据
 *
 *  @param responseObject Data数据
 *
 *  @return JSON数据
 */
- (NSDictionary *)sortOutResponseObject:(NSData *)responseObject{
    NSString* sTemp = [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
    
    DLog(@"%@",sTemp);
    NSRange range = [sTemp rangeOfString:@"\r\n"];
    if (range.location != NSNotFound) {
        sTemp =   [sTemp stringByReplacingCharactersInRange:range withString:@""];
    }
    range = [sTemp rangeOfString:@" 	"];
    if (range.location != NSNotFound) {
        sTemp =   [sTemp stringByReplacingCharactersInRange:range withString:@""];
    }
    range = [sTemp rangeOfString:@"\n"];
    if (range.location != NSNotFound) {
        sTemp =   [sTemp stringByReplacingCharactersInRange:range withString:@""];
    }
    range = [sTemp rangeOfString:@"\t"];
    if (range.location != NSNotFound) {
        sTemp =   [sTemp stringByReplacingCharactersInRange:range withString:@""];
    }
    NSError* error;
    
    id json = [NSJSONSerialization JSONObjectWithData:[sTemp dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
    if (error) {
        return nil;
    } else {
        return json;
    }
}

/**
 *  展示HUD
 *
 *  @param graceTimeType 提示框提示时机
 *
 *  @return HUD
 */
+ (MBProgressHUD *)hud:(NetworkGraceTimeType)graceTimeType {
    NSTimeInterval graceTime = 0;
    switch (graceTimeType) {
        case NetworkGraceTimeTypeNormal:
            graceTime = 0.5;
            break;
        case NetworkGraceTimeTypeLong:
            graceTime = 1.0;
            break;
        case NetworkGraceTimeTypeShort:
            graceTime = 0.1;
            break;
        case NetworkGraceTimeTypeAlways:
            graceTime = 0;
            break;
        case NetworkGraceTimeTypeNone:
            return nil;
            break;
        default:
            break;
    }
    MBProgressHUD *hud = [self createHud];
    UIWindow *window = [[[UIApplication sharedApplication]delegate]window];
    [window addSubview:hud];
    hud.graceTime = graceTime;
    hud.taskInProgress = YES;
    [hud show:YES];
    return hud;
}

/**
 *  创建和NetworkItem关联的HUD
 *
 *  @return 返回的hud
 */
+ (MBProgressHUD *)createHud{
    MBProgressHUD *hud = objc_getAssociatedObject(self, &hudKey);
    if (!hud) {
        hud = [[MBProgressHUD alloc] initWithWindow:[[[UIApplication sharedApplication]delegate]window]];
        hud.labelText = @"加载中...";
        objc_setAssociatedObject(self, &hudKey, hud, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        DLog(@"创建一个HUD");
    }
    return hud;
}

/**
 *  隐藏HUD
 */
+ (void)hideHud{
    MBProgressHUD *hud = objc_getAssociatedObject(self, &hudKey);
    hud.taskInProgress = NO;
    [hud hide:YES];
}

@end
