//
//  TypeHeader.h
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/8.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#ifndef TypeHeader_h
#define TypeHeader_h

//修改昵称  电话
typedef NS_ENUM(NSInteger, ModifyType) {
    ModifyName = 0,      //昵称
    ModifyPhone = 1,     //电话
};


//申请关注
typedef NS_ENUM(NSInteger, ApplyFoucsType) {
    ApplyFoucsCompany = 0,      //公司
    ApplyFoucsCharacter = 1,    //人物
};

//网页类型
typedef NS_ENUM(NSInteger, WebViewType) {
    WebViewBackTool = 1 << 0,      //全部显示
    WebViewFontTool = 1 << 1,    //显示设置字体
    WebViewShareTool = 1 << 2,  //显示分享
    WebViewCollectTool = 1 << 3,  //显示收藏
    WebViewAllTool = WebViewBackTool | WebViewFontTool | WebViewShareTool | WebViewCollectTool,
};

//分享类型
typedef NS_ENUM(NSInteger, ShareType) {
    ShareJingGao = 0,
    ShareNews,
};

//资讯类型
typedef NS_ENUM(NSInteger, InformationType) {
    InfoDefaultType = 0,  //有图片
    InfoDisclosureType,   //信息披露
    InfoOtherType         //其他一般的
};

#endif /* TypeHeader_h */
