//
//  NetworkItem.h
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/14.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkDefine.h"
#import "UploadParam.h"

@class NetworkItem;

@protocol NetworkDelegate <NSObject>
@optional

/**
 *   网络请求项即将被移除掉
 *
 *   @param itme 网络请求项
 */
- (void)netWorkWillDealloc:(NetworkItem*)itme;

@end

@interface NetworkItem : NSObject

//网络请求方式
@property (nonatomic, assign) NetWorkType networkType;

//网络请求URL
@property (nonatomic, strong) NSString *url;

//网络请求参数
@property (nonatomic, strong) NSDictionary *params;

//是否显示HUD
@property (nonatomic, assign) BOOL showHUD;

//上传文件参数
@property (nonatomic, strong) NSArray *uploadParams;

//网络请求的委托
@property (nonatomic, assign) id<NetworkDelegate>delegate;

//下载地址
@property (nonatomic, strong) NSString *filePath;

//下载句柄
@property (nonatomic, assign) NSURLSessionDownloadTask *task;

/**
 *  创建一个网络请求项，开始请求网络
 *
 *  @param networkType   网络请求方式
 *  @param url           网络请求URL
 *  @param params        网络请求参数
 *  @param showHUD       是否显示HUD
 *  @param progressBlock 进度block
 *  @param successBlock  请求成功后的block
 *  @param failureBlock  请求失败后的block
 *
 *  @return NetworkItem对象
 */
- (NetworkItem *)initWithtype:(NetWorkType)networkType
                          url:(NSString *)url
                       params:(NSDictionary *)params
                      showHUD:(BOOL)showHUD
                    progressBlock:(NetworkProgressBlock)progressBlock
                 successBlock:(NetworkSuccessBlock)successBlock
                 failureBlock:(NetworkFailureBlock)failureBlock;

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
                failureBlock:(NetworkFailureBlock)failureBlock;

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
                     completionBlock:(NetworkDownLoadCompletionBlock)completionBlock;

/**
 *  暂停下载
 */
- (void)stopDownloadItem;
/**
 *  继续下载
 */
- (void)starDownLoadItem;

// 下载进度
//DLog(@"当前下载进度为:%lf", 1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
//dispatch_async(dispatch_get_main_queue(), ^{
// 设置进度条的百分比
//weakSelf.progressView.progress = 1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount;
//});
@end


