//
//  NetworkDefine.h
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/14.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#ifndef NetworkDefine_h
#define NetworkDefine_h

/**
 *  请求类型
 */
typedef enum {
    NetWorkGET = 1,   /**< GET请求 */
    NetWorkPOST       /**< POST请求 */
} NetWorkType;

//错误样式
typedef NS_ENUM(NSInteger, HttpErrorType) {
    HttpErrorType_TimedOut  = NSURLErrorTimedOut,               //请求超时
    HttpErrorType_UnUrl     = NSURLErrorUnsupportedURL,         //不支持的url
    HttpErrorType_NONetwork = NSURLErrorNotConnectedToInternet, //断网
    HttpErrorType_404Failed = NSURLErrorBadServerResponse,      //404错误
};


//网络提示框出现时机
typedef NS_ENUM(NSInteger, NetworkGraceTimeType) {
    NetworkGraceTimeTypeNormal,                 //0.5s
    NetworkGraceTimeTypeLong,                   //1s
    NetworkGraceTimeTypeShort,                  //0.1s
    NetworkGraceTimeTypeNone,                   //不显示
    NetworkGraceTimeTypeAlways                  //总是显示
};


//网络请求超时的时间
#define NET_TIME_OUT 20

//网络提示框出现时机
#define kGraceTime NetworkGraceTimeTypeAlways


/**
 *  请求成功回调
 *
 *  @param returnData 回调block
 */
typedef void (^NetworkSuccessBlock)(NSDictionary *returnData);

/**
 *  请求失败回调
 *
 *  @param error 回调block
 */
typedef void (^NetworkFailureBlock)(NSError *error);

/**
 *  进度回调
 *
 *  @param progress 监听进度
 *  @property int64_t totalUnitCount;     需要下载文件的总大小
 *  @property int64_t completedUnitCount; 当前已经下载的大小
 */
typedef void (^NetworkProgressBlock)(NSProgress *progress);

/**
 *  下载成功回调
 *
 *  @param response 返回的response
 *  @param filePath 下载成功地址
 *  @param error 失败
 */
typedef void (^NetworkDownLoadCompletionBlock)(NSURLResponse *response, NSURL *filePath, BOOL success);



#endif /* NetworkDefine_h */
