//
//  HttpHeader.h
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/14.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#ifndef HttpHeader_h
#define HttpHeader_h


#define kShowHUD YES

//返回状态
#define kStatus  @"status"
#define kSuccess 200
#define kMessage @"message"
//底层接口
//测试
//#define kBaseUrl        @"http://192.168.65.189"
//#define kPhoto          @"http://192.168.65.187/jgyq/login.jsp"
//正式
#define kBaseUrl        @"http://1.85.59.245"
#define kPhoto          @"http://yuqing.p5w.net"

//首页舆情列表
#define kNewsList       @"gdsp/v1/app/news/index"

//修改userKey
#define kModifyUserKey  @"gdsp/v1/app/user/modify"

//收藏的新闻
#define kLikeNews       @"gdsp/v1/app/news/favorite"

//用户权限
#define kUserPermission @"gdsp/v1/app/user/permission"

//资讯列表
#define kZiXunTitleList @"gdsp/v1/app/information/type"

//登陆
#define kLogin          @"gdsp/v1/app/user/login"

//舆情关注
#define kAttention      @"gdsp/v1/app/user/attention/"

//广告图片
#define kAdvertise      @"gdsp/v1/app/advertisement/search"

//上传头像
#define kUploadPhoto    @"jgyq/rest/appuser/uploadPhoto?"

//修改昵称电话
#define kModifyNickName @"gdsp/v1/app/user/modify"

//修改密码
#define kModifyPassword @"gdsp/v1/app/user/pwd"

//申请定制服务
#define kApplyFoucs     @"gdsp/v1/app/custom/create"

//定制服务记录
#define kApplyRecord     @"gdsp/v1/app/custom/query"

//取消收藏
#define kDeletedLikeNews @"gdsp/v1/app/favorite/del"

//添加收藏
#define kAddLikeNews     @"gdsp/v1/app/favorite/add"

//获取default资讯
#define kDefaultInfo     @"gdsp/v1/app/information/company/default"

//获取custom资讯
#define kCustomInfo      @"gdsp/v1/app/information/company/custom"

//退出登录
#define kLogout          @"gdsp/v1/app/user/loginOut"

//预警推送提醒设置
#define kPush            @"gdsp/v1/app/user/modify"

//其它推送提醒设置
#define kOtherPush       @"gdsp/v1/app/user/modifyPush"

//意见反馈
#define kFeedback        @"gdsp/v1/app/feedback/add"


#endif /* HttpHeader_h */
