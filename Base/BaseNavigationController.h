//
//  BaseNavigationController.h
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/17.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseNavigationController : UINavigationController<UIGestureRecognizerDelegate>

/**
 *  设置全局Bar
 */
+ (void)appearanceNavigationBar;

@end
