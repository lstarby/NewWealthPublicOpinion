//
//  BaseTableViewController.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/17.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "BaseTabBarController.h"
#import "UtilsHeader.h"

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        [self setEdgesForExtendedLayout:UIRectEdgeNone]; //从（0, 64）开始
    }
    if([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]){
        [self setAutomaticallyAdjustsScrollViewInsets:NO];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)unSelectedTapTabBarItems:(UITabBarItem *)tabBarItem {
    [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                        [UIFont systemFontOfSize:10],
                                        NSFontAttributeName,COLOR_TABBAR,NSForegroundColorAttributeName,
                                        nil] forState:UIControlStateNormal];
}


- (void)selectedTapTabBarItems:(UITabBarItem *)tabBarItem {
    [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                        [UIFont systemFontOfSize:10],
                                        NSFontAttributeName,COLOR_REDDEF,NSForegroundColorAttributeName,
                                        nil] forState:UIControlStateSelected];
    
    // tabBarItem.imageInsets = UIEdgeInsetsMake(-10, 0, 0, 0);
}

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
- (UITabBarItem *)setTabBarItemTitle:(NSString *)title tag:(NSInteger)tag image:(NSString *)imageName selectedImage:(NSString *)seletedImageName {
    UITabBarItem *tabBarItem = [[UITabBarItem alloc] init];
    tabBarItem.title = title;
    tabBarItem.tag = tag;
    if ( kiOS8 ) {
        [tabBarItem setImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [tabBarItem setSelectedImage:[[UIImage imageNamed:seletedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    }
    else {
        [tabBarItem setFinishedSelectedImage:[UIImage imageNamed:seletedImageName] withFinishedUnselectedImage:[UIImage imageNamed:imageName]];
    }
    [self selectedTapTabBarItems:tabBarItem];
    [self unSelectedTapTabBarItems:tabBarItem];
    return tabBarItem;
}

@end
