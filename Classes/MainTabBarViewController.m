//
//  MianTableViewController.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/21.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "MBProgressHUD+Extend.h"
#import "HttpManager.h"
#import "DBManager.h"
#import "MainViewController.h"
#import "PublicSentimentViewController.h"
#import "VipViewController.h"
#import "InterActionViewController.h"
#import "PublicNoticeViewController.h"
#import "InformationViewController.h"
#import "ReleaseViewController.h"
#import "ResearchViewController.h"
#import "BaseNavigationController.h"

@interface MainTabBarViewController ()

@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    [self initChildVC];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)initChildVC {
    //1--预警 2--舆情 152--专享 3--研报 4--互动 5--公告 6--资讯 155--发布
    NSMutableArray *childVCArray = [NSMutableArray array];
    
    MainViewController *mainVC = [[MainViewController alloc] init];
    mainVC.tabBarItem = [self setTabBarItemTitle:@"预警" tag:1 image:@"home" selectedImage:@"home_sel"];
    BaseNavigationController *mainNav = [[BaseNavigationController alloc] initWithRootViewController:mainVC];
    if ([DBManager searchMenuByWhere:@"itemId=1 and itemOwen=1"]) {
        [childVCArray addObject:mainNav];
    }
    
    PublicSentimentViewController *publicSentimentVC = [[PublicSentimentViewController alloc] init];
    publicSentimentVC.tabBarItem = [self setTabBarItemTitle:@"舆情" tag:2 image:@"yuqing" selectedImage:@"yuqing_sel"];
    BaseNavigationController *publicSentimentNav = [[BaseNavigationController alloc] initWithRootViewController:publicSentimentVC];
    if ([DBManager searchMenuByWhere:@"itemId=2 and itemOwen=1"]) {
        [childVCArray addObject:publicSentimentNav];
    }
    
    VipViewController *vipVC = [[VipViewController alloc] init];
    vipVC.tabBarItem = [self setTabBarItemTitle:@"专享" tag:152 image:@"vip_sel" selectedImage:@"vip_"];
    BaseNavigationController *vipNav = [[BaseNavigationController alloc] initWithRootViewController:vipVC];
    if ([DBManager searchMenuByWhere:@"itemId=152 and itemOwen=1"]) {
        [childVCArray addObject:vipNav];
    }
    
    ResearchViewController *researchVC = [[ResearchViewController alloc] init];
    researchVC.tabBarItem = [self setTabBarItemTitle:@"研报" tag:3 image:@"yb_" selectedImage:@"yb_sel"];
    BaseNavigationController *researchNav = [[BaseNavigationController alloc] initWithRootViewController:researchVC];
    if ([DBManager searchMenuByWhere:@"itemId=3 and itemOwen=1"]) {
        [childVCArray addObject:researchNav];
    }
    
    InterActionViewController *interActionVC = [[InterActionViewController alloc] init];
    interActionVC.tabBarItem = [self setTabBarItemTitle:@"互动" tag:4 image:@"hudong" selectedImage:@"hudong_sel"];
    BaseNavigationController *interActionNav = [[BaseNavigationController alloc] initWithRootViewController:interActionVC];
    if ([DBManager searchMenuByWhere:@"itemId=4 and itemOwen=1"]) {
        [childVCArray addObject:interActionNav];
    }
    
    PublicNoticeViewController *publicNoticeVC = [[PublicNoticeViewController alloc] init];
    publicNoticeVC.tabBarItem = [self setTabBarItemTitle:@"公告" tag:5 image:@"affiche" selectedImage:@"affiche_sel"];
    BaseNavigationController *publicNoticeNav = [[BaseNavigationController alloc] initWithRootViewController:publicNoticeVC];
    if ([DBManager searchMenuByWhere:@"itemId=5 and itemOwen=1"]) {
        [childVCArray addObject:publicNoticeNav];
    }
    
    InformationViewController *informationVC = [[InformationViewController alloc] init];
    informationVC.tabBarItem = [self setTabBarItemTitle:@"资讯" tag:6 image:@"Report" selectedImage:@"Report_sel"];
    BaseNavigationController *informationNav = [[BaseNavigationController alloc] initWithRootViewController:informationVC];
    if ([DBManager searchMenuByWhere:@"itemId=6 and itemOwen=1"]) {
        [childVCArray addObject:informationNav];
    }
    
    ReleaseViewController *releaseVC = [[ReleaseViewController alloc] init];
    releaseVC.tabBarItem = [self setTabBarItemTitle:@"发布" tag:155 image:@"bj-18" selectedImage:@"bj-17"];
    BaseNavigationController *releaseNav = [[BaseNavigationController alloc] initWithRootViewController:releaseVC];
    if ([DBManager searchMenuByWhere:@"itemId=155 and itemOwen=1"]) {
        [childVCArray addObject:releaseNav];
    }
    self.tabBar.tintColor = [UIColor clearColor];
    self.tabBar.translucent = NO;
    self.viewControllers = childVCArray;
}

@end
