//
//  NetworkHander.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/14.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "NetworkHandler.h"
#import <AFNetworking/AFNetworking.h>

@implementation NetworkHandler

//初始化请求类单例
+ (NetworkHandler *)sharedInstance
{
    static NetworkHandler *handler = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handler = [[NetworkHandler alloc] init];
    });
    return handler;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.networkError = NO;
    }
    return self;
}

/**
 *  创建一个网络请求项
 *
 *  @param url           网络请求URL
 *  @param networkType   网络请求方式
 *  @param params        网络请求参数
 *  @param showHUD       是否显示HUD
 *  @param progressBlock 进度block
 *  @param successBlock  请求成功后的block
 *  @param failureBlock  请求失败后的block
 *
 *  @return 根据网络请求项
 */
- (NetworkItem*)connectURL:(NSString *)url
                networkType:(NetWorkType)networkType
                     params:(NSMutableDictionary *)params
                    showHUD:(BOOL)showHUD
                progressBlock:(NetworkProgressBlock)progressBlock
               successBlock:(NetworkSuccessBlock)successBlock
               failureBlock:(NetworkFailureBlock)failureBlock
{
    if (self.networkError == YES) {
        [self showNetworkAlert];
        if (failureBlock) {
            failureBlock(nil);
        }
        return nil;
    }
    // 如果有一些公共处理，可以写在这里
    
    NetworkItem *netWorkItem = [[NetworkItem alloc]initWithtype:networkType url:url params:params showHUD:showHUD progressBlock:progressBlock successBlock:successBlock failureBlock:failureBlock];
    netWorkItem.delegate = self;
    [self.items addObject:netWorkItem];
    return netWorkItem;
}

/**
 *  上传文件
 *
 *  @param url           上传文件的 url 地址
 *  @param paramsDict    参数字典
 *  @param progressBlock 进度block
 *  @param successBlock  成功
 *  @param failureBlock  失败
 *  @param uploadParams  上传的数据数组
 *  @param showHUD       是否显示 HUD
 *
 *  @return 根据网络请求项
 */
- (NetworkItem *)uploadFileWithURL:(NSString*)url
                   params:(NSDictionary*)params
                progressBlock:(NetworkProgressBlock)progressBlock
             successBlock:(NetworkSuccessBlock)successBlock
             failureBlock:(NetworkFailureBlock)failureBlock
              uploadParams:(NSArray *)uploadParams
                  showHUD:(BOOL)showHUD
{
    if (self.networkError == YES) {
        [self showNetworkAlert];
        if (failureBlock) {
            failureBlock(nil);
        }
        return nil;
    }
    // 如果有一些公共处理，可以写在这里
    
    NetworkItem *netWorkItem = [[NetworkItem alloc]initWithURL:url params:params showHUD:showHUD uploadParams:uploadParams progressBlock:progressBlock successBlock:successBlock failureBlock:failureBlock];
    netWorkItem.delegate = self;
    [self.items addObject:netWorkItem];
    return netWorkItem;
    
}

/**
 *  下载文件
 *
 *  @param url             下载文件的 url 地址
 *  @param filePath        下载文件的地址
 *  @param showHUD         是否显示 HUD
 *  @param progressBlock   进度block
 *  @param completionBlock 完成block
 *
 *  @return 下载的项目
 */
- (NetworkItem *)downLoadWithURL:(NSString *)url
                        filePath:(NSString *)filePath
                         showHUD:(BOOL)showHUD
                   progressBlock:(NetworkProgressBlock)progressBlock
                 completionBlock:(NetworkDownLoadCompletionBlock)completionBlock
{
    if (self.networkError == YES) {
        [self showNetworkAlert];
        if (completionBlock) {
            completionBlock(nil,nil,NO);
        }
        return nil;
    }
    // 如果有一些公共处理，可以写在这里
    
    NetworkItem *netWorkItem = [[NetworkItem alloc]initDownLoadWithURL:url filePath:filePath showHUD:showHUD progressBlock:progressBlock completionBlock:completionBlock];
    netWorkItem.delegate = self;
    [self.items addObject:netWorkItem];
    return netWorkItem;
}

/**
 *  没有网络的警告框
 */
- (void)showNetworkAlert{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络连接断开,请检查网络!" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
}

#pragma makr - 开始监听网络连接
+ (void)startMonitoring
{
    // 1.获得网络监控的管理者
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    // 2.设置网络状态改变后的处理
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变了, 就会调用这个block
        switch (status)
        {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
                DLog(@"未知网络");
                [NetworkHandler sharedInstance].networkError = NO;
                break;
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                [NetworkHandler sharedInstance].networkError = YES;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                DLog(@"手机自带网络");
                [NetworkHandler sharedInstance].networkError = NO;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                DLog(@"WIFI");
                [NetworkHandler sharedInstance].networkError = NO;
                break;
        }
    }];
    [mgr startMonitoring];
}

/**
 *   懒加载网络请求项的 items 数组
 *
 *   @return 返回一个数组
 */
- (NSMutableArray *)items
{
    if (!_items) {
        _items = [NSMutableArray array];
    }
    return _items;
}

/**
 *   取消所有正在执行的网络请求项
 */
+ (void)cancelAllNetItems
{
    NetworkHandler *handler = [NetworkHandler sharedInstance];
    [handler.items removeAllObjects];
}

#pragma mark - NetworkDelegate
- (void)netWorkWillDealloc:(NetworkItem *)itme
{
    [self.items removeObject:itme];
}

@end
