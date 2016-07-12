//
//  UICommon.h
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/17.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UICommon : UIView

//创建自定义按钮
+ (UIBarButtonItem*)createCustomNavButtonTitle:(NSString *)title image:(UIImage*)image target:(id)target selector:(SEL)selector;

//设置BarTitle
+ (void)setNavBarTitle:(UINavigationItem*) navItem title:(NSString*)title;

//添加点击事件
+ (void)addTapGestureToView:(UIView *)view target:(id)target selector:(SEL)selector;


@end
