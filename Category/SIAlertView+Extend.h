//
//  SIAlertView+Extend.h
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/15.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import <SIAlertView/SIAlertView.h>

typedef void(^AlertViewClicked)(SIAlertView *alertView);

@interface SIAlertView (Extend)
/**
 *  对警告框进行全局设置
 */
+ (void)alertViewAppearance;

/**
 *  生成一个button的警告框
 *
 *  @param title        标题
 *  @param message      内容
 *  @param buttonName   按钮名称
 *  @param clickedBlock 点击按钮block
 *
 *  @return SIAlertView对象
 */
+ (SIAlertView *)createOneButtonAlertView:(NSString *)title message:(NSString *)message buttonName:(NSString *)buttonName clicked:(AlertViewClicked)clickedBlock;

+ (SIAlertView *)createTwoButtonAlertView:(NSString *)title message:(NSString *)message cancelButton:(NSString *)cancel defineButton:(NSString *)define cancelClicked:(AlertViewClicked)cancelClickedBlock defineClicked:(AlertViewClicked)defineClickedBlock;

+ (SIAlertView *)createThreeButtonAlertView:(NSString *)title message:(NSString *)message cancelButton:(NSString *)cancel defineButton:(NSString *)define threeButton:(NSString *)three cancelClicked:(AlertViewClicked)cancelClickedBlock defineClicked:(AlertViewClicked)defineClickedBlock threeClicked:(AlertViewClicked)threeClickedBlock;

+ (SIAlertView *)createFourButtonAlertView:(NSString *)title message:(NSString *)message cancelButton:(NSString *)cancel defineButton:(NSString *)define threeButton:(NSString *)three fourButton:(NSString *)four cancelClicked:(AlertViewClicked)cancelClickedBlock defineClicked:(AlertViewClicked)defineClickedBlock threeClicked:(AlertViewClicked)threeClickedBlock fourClicked:(AlertViewClicked)fourClickedBlock;

@end
