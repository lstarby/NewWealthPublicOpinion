//
//  NetworkManager.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/14.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "NetworkManager.h"
#import "NetworkHandler.h"

@implementation NetworkManager

/**
 *  开始网络监测
 */
+ (void)startMonitoring {
    [NetworkHandler startMonitoring];
}

/**
 *  GET请求
 *
 *  @param url           网络请求URL
 *  @param params        网络请求参数
 *  @param showHUD       是否显示HUD
 *  @param progressBlock 进度block
 *  @param successBlock  请求成功后的block
 *  @param failureBlock  请求失败后的block
 */
+ (void)getRequestWithURL:(NSString*)url
                  params:(NSDictionary*)params
                 showHUD:(BOOL)showHUD
             progressBlock:(NetworkProgressBlock)progressBlock
            successBlock:(NetworkSuccessBlock)successBlock
            failureBlock:(NetworkFailureBlock)failureBlock
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionaryWithDictionary:params];
    [[NetworkHandler sharedInstance] connectURL:url networkType:NetWorkGET params:mutableDict showHUD:showHUD progressBlock:progressBlock successBlock:successBlock failureBlock:failureBlock];
}


/**
 *   POST请求
 *
 *   @param url           url
 *   @param paramsDict    请求的参数字典
 *   @param showHUD       是否加载进度指示器
 *   @param progressBlock 进度block
 *   @param successBlock  成功的回调
 *   @param failureBlock  失败的回调
 */
+ (void)postRequestWithURL:(NSString*)url
                    params:(NSDictionary*)params
                    showHUD:(BOOL)showHUD
                progressBlock:(NetworkProgressBlock)progressBlock
              successBlock:(NetworkSuccessBlock)successBlock
              failureBlock:(NetworkFailureBlock)failureBlock
{
      NSMutableDictionary *mutableDict = [NSMutableDictionary dictionaryWithDictionary:params];
    [[NetworkHandler sharedInstance] connectURL:url networkType:NetWorkPOST params:mutableDict showHUD:showHUD progressBlock:progressBlock successBlock:successBlock failureBlock:failureBlock];
}

/**
 *  上传文件
 *
 *  @param url          url
 *  @param params       参数字典
 *  @param showHUD      是否显示HUD
 *  @param uploadParams 上传的数据
 *  @param progressBlock 进度block
 *  @param successBlock 请求成功后的block
 *  @param failureBlock 请求失败后的block
 */
+ (void)uploadFileWithURL:(NSString*)url
                   params:(NSDictionary*)params
                    showHUD:(BOOL)showHUD
                uploadParams:(NSArray *)uploadParams
                progressBlock:(NetworkProgressBlock)progressBlock
             successBlock:(NetworkSuccessBlock)successBlock
             failureBlock:(NetworkFailureBlock)failureBlock
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionaryWithDictionary:params];
    
    [[NetworkHandler sharedInstance] uploadFileWithURL:url params:mutableDict progressBlock:progressBlock successBlock:successBlock failureBlock:failureBlock uploadParams:uploadParams showHUD:showHUD];
}

/**
 *  下载文件
 *
 *  @param url             下载地址URL
 *  @param filePath        下载保存地址
 *  @param showHUD         是否显示HUD
 *  @param progressBlock   进度block
 *  @param completionBlock 下载完成block
 *
 *  @return 下载项目
 */
+ (NetworkItem *)downLoadWithURL:(NSString *)url
               filePath:(NSString *)filePath
                showHUD:(BOOL)showHUD
          progressBlock:(NetworkProgressBlock)progressBlock
        completionBlock:(NetworkDownLoadCompletionBlock)completionBlock{
    
    return [[NetworkHandler sharedInstance] downLoadWithURL:url filePath:filePath showHUD:showHUD progressBlock:progressBlock completionBlock:completionBlock];
}

+ (void)cancelAllNetWorking {
    [NetworkHandler cancelAllNetItems];
}
@end
