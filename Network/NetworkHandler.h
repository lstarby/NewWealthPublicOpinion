//
//  NetworkHander.h
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/14.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkDefine.h"
#import "NetworkItem.h"

@interface NetworkHandler : NSObject<NetworkDelegate>

//networkError 网络监测
@property(nonatomic,assign)BOOL networkError;

//网络请求项
@property(nonatomic,strong)NSMutableArray *items;

+ (void)cancelAllNetItems;
/**
 *  单例
 *
 *  @return NetworkHandler的单例对象
 */
+ (NetworkHandler *)sharedInstance;

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
              failureBlock:(NetworkFailureBlock)failureBlock;

/**
 *  上传文件
 *
 *  @param url           上传文件的 url 地址
 *  @param paramsDict    参数字典
 *  @param progressBlock 进度block
 *  @param successBlock  成功
 *  @param failureBlock  失败
 *  @param uploadParams  上传的数据数组
 *  @param showHUD       显示 HUD
 */
- (NetworkItem *)uploadFileWithURL:(NSString*)url
                            params:(NSDictionary*)params
                     progressBlock:(NetworkProgressBlock)progressBlock
                      successBlock:(NetworkSuccessBlock)successBlock
                      failureBlock:(NetworkFailureBlock)failureBlock
                      uploadParams:(NSArray *)uploadParams
                           showHUD:(BOOL)showHUD;

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
                 completionBlock:(NetworkDownLoadCompletionBlock)completionBlock;

/**
 *   监听网络状态的变化
 */
+ (void)startMonitoring;

@end
