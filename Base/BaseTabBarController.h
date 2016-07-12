//
//  BaseTableViewController.h
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/17.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTabBarController : UITabBarController

/**
 *  设置未选中tabBarItem
 *
 *  @param tabBarItem tabBarItem
 */
- (void)unSelectedTapTabBarItems:(UITabBarItem *)tabBarItem;

/**
 *  设置选中tabBarItem
 *
 *  @param tabBarItem tabBarItem
 */
- (void)selectedTapTabBarItems:(UITabBarItem *)tabBarItem;

/**
 *  设置TabBarItem
 *
 *  @param tabBarItem       tabBarItem
 *  @param title            title
 *  @param tag              tag
 *  @param imageName        未选中图片
 *  @param seletedImageName 选中图片
 *  @return TabBarItem
 */
- (UITabBarItem *)setTabBarItemTitle:(NSString *)title tag:(NSInteger)tag image:(NSString *)imageName selectedImage:(NSString *)seletedImageName;

@end
