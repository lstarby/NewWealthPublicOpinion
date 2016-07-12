//
//  AppHeader.h
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/8.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#ifndef AppHeader_h
#define AppHeader_h

#pragma mark - 设备大小
//NavBar 高度
#define kNavigationBar_HEIGHT 44
//获取屏幕 宽度、高度
#define kSCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define kSCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#pragma mark - 读取图片
#define kLOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]
#define kIMAGENAME(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]

#pragma mark - rgb颜色转换（16进制->10进制）
#define kUIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#pragma mark - 获取RGB颜色
#define kCOLOR_RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define kCOLOR_RGB(r,g,b) kCOLOR_RGBA(r,g,b,1.0f)

#pragma mark - 定义字号
#define kFONT_SIZE(size) [UIFont systemFontOfSize:size]
#define kFONT_BOLDSIZE(size) [UIFont boldSystemFontOfSize:size]
//方正黑体简体字体定义
#define kFONT(F) [UIFont fontWithName:@"FZHTJW--GB1-0" size:F]

#pragma mark - 角度/弧度转换
#define kDEGREES_RADIAN(degrees) (M_PI * (degrees) / 180.0)
#define kRADIAN_DEGREES(radian)  ((radian * 180.0) / M_PI)

#pragma mark - 设备类型
//判断是否 Retina屏、设备是否iphone 5、是否是iPad
#define kisRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define kiPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define kisPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#pragma mark - 系统版本
#define kIOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define kCurrentSystemVersion [[UIDevice currentDevice] systemVersion]

#define kiOS8 [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0
#define kiOS7 [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0

#pragma mark - 设备类型
#define kiPhone4     ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define kiPhone5     ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define kiPhone6     ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define kiPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)


#ifdef DEBUG
# define DLog(fmt, ...) NSLog((@"[函数名:%s]\n" "[行号:%d] \n" fmt), __FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
# define DLog(...);
#endif

#endif /* AppHeader_h */
