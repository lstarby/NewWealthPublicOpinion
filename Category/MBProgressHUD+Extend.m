//
//  MBProgressHUD+Extend.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/15.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "MBProgressHUD+Extend.h"

CGFloat const MBProgressYOffset = 100.f;

@implementation MBProgressHUD (Extend)

/**
 *  显示带图片的提示框
 *
 *  @param text 显示文字
 *  @param icon 图片
 *  @param view 视图
 */
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view{
    if (view == nil){
        view = [[UIApplication sharedApplication].windows lastObject];
    }
    [self hideHUDForView:view];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = text;
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    
    hud.square = YES;
    
    // 1秒之后再消失
    [hud hide:YES afterDelay:1.0f];
}

/**
 *  纯文字提示框
 *
 *  @param text 显示文字
 *  @param view 视图
 */
+ (void)showTextHUD:(NSString *)text view:(UIView *)view{
    if (view == nil){
        view = [[UIApplication sharedApplication].windows lastObject];
    }
    [self hideHUDForView:view];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    hud.mode = MBProgressHUDModeText;
    hud.labelText = text;

    hud.yOffset = MBProgressYOffset;
    
    [hud hide:YES afterDelay:1.0f];
}

/**
 *  快速生成一个提示框
 *
 *  @param message 提示内容
 *  @param view    视图
 *
 *  @return HUD
 */
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil){
        view = [[UIApplication sharedApplication].windows lastObject];
    }
    [self hideHUDForView:view];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = message;
    // YES代表需要蒙版效果
    //如果dimBackground设置为true，那么背景就会变成阴影；
    hud.dimBackground = false;
    return hud;
}

#pragma mark - 显示错误信息
+ (void)showError:(NSString *)error toView:(UIView *)view{
    [self show:error icon:@"error.png" view:view];
}

#pragma mark - 显示成功信息
+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    [self show:success icon:@"success.png" view:view];
}

+ (void)showSuccess:(NSString *)success
{
    [self showSuccess:success toView:nil];
}

+ (void)showError:(NSString *)error
{
    [self showError:error toView:nil];
}

+ (void)showTextHUD:(NSString *)text
{
    [self showTextHUD:text view:nil];
}

+ (MBProgressHUD *)showMessage:(NSString *)message
{
    return [self showMessage:message toView:nil];
}

+ (void)hideHUDForView:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    [self hideHUDForView:view animated:YES];
}

+ (void)hideHUD
{
    [self hideHUDForView:nil];
}

@end
