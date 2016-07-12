//
//  UICommon.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/17.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "UICommon.h"

@implementation UICommon

//创建自定义按钮
+ (UIBarButtonItem*)createCustomNavButtonTitle:(NSString *)title image:(UIImage*)image target:(id)target selector:(SEL)selector {
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 44, 44);
    UIBarButtonItem * barButton= [[UIBarButtonItem alloc] initWithCustomView:button];
    
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    return barButton;
}

//设置BarTitle
+ (void)setNavBarTitle:(UINavigationItem*) navItem title:(NSString*)title {
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0 , 100, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];  //设置Label背景透明
    titleLabel.font = [UIFont boldSystemFontOfSize:18];  //设置文本字体与大小
    titleLabel.textColor = [UIColor whiteColor];  //设置文本颜色
    titleLabel.text = title;  //设置标题
    titleLabel.textAlignment = NSTextAlignmentCenter;
    //titleLabel.alignmentRectInsets
    navItem.titleView = titleLabel;
}

//添加点击事件
+ (void)addTapGestureToView:(UIView *)view target:(id)target selector:(SEL)selector {
    UITapGestureRecognizer *oneFingerOneTap =
    [[UITapGestureRecognizer alloc] initWithTarget:target action:selector] ;
    [oneFingerOneTap setNumberOfTapsRequired:1];
    [oneFingerOneTap setNumberOfTouchesRequired:1];
    [view addGestureRecognizer:oneFingerOneTap];
}


@end
