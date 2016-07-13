//
//  NSString+Extend.h
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/24.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Extend)

//昵称
- (NSString *)isNickName;
//获取字符串长度
- (int)getStringLen;

//电话号码
- (NSString *)isValiMobile;

//确认密码
- (NSString *)sureNewPassword:(NSString *)newPassword surePassword:(NSString *)surePassword;

//计算字符串size
- (CGSize)sizeForFont:(UIFont*)font constrainedToSize:(CGSize)constraint;

//获取时间戳
- (NSNumber *)getTime;

//获取展示时间
- (NSString *)getTimeStr;

//获取有效URL
- (NSString *)encodeToPercentEscapeString;
@end
