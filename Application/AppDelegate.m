//
//  AppDelegate.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/6.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "NotificationHeader.h"
#import "AppDelegate.h"
#import "AppDelegate+Extend.h"
#import "DBManager.h"
#import "SIAlertView+Extend.h"
#import "UserHeader.h"
#import "MBProgressHUD+Extend.h"
#import "LikeNewsModel.h"
#import "LoginViewController.h"
#import "BaseNavigationController.h"
#import "MainTabBarViewController.h"
#import <MMDrawerController/MMDrawerController.h>
#import <MMDrawerController/MMDrawerVisualState.h>
#import "UserCenterViewController.h"
#import "AdvertiseViewController.h"
#import "UserHandler.h"


//#import <JPush/JPUSHService.h>

#import "HttpManager.h"

@interface AppDelegate ()

@property (nonatomic,strong) MMDrawerController * drawerController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //设置缓存
    [self initURLCache];
    
    //设置ShareSDK
    [self addShareSDKWithapplication:application didFinishLaunchingWithOptions:launchOptions];
    //设置JPushSDK
    [self addJPushSDKWithapplication:application didFinishLaunchingWithOptions:launchOptions];
    //设置通知
    [self initNotification];
    //初始化数据库
    [DBManager initAllTbale];
    //设置SIAlertView样式
    [SIAlertView alertViewAppearance];
    //开始网络监控
    [HttpManager startMonitoring];
    //读取用户信息
    [UserManager readUserInfo];
    //设置NavigationBar样式
    [BaseNavigationController appearanceNavigationBar];
    
    BaseNavigationController *baseNav = nil;
    if ([UserManager getGuideTag]) {
        AdvertiseViewController *advertiseVC = [[AdvertiseViewController alloc] init];
        baseNav = [[BaseNavigationController alloc] initWithRootViewController:advertiseVC];
    } else {
        //第一次打开应用
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        baseNav = [[BaseNavigationController alloc] initWithRootViewController:loginVC];
    }
    
    self.window.rootViewController = baseNav;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)initNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showMainVC)
                                                 name:kShowMainVC
                                               object:nil];
}

- (void)showMainVC {
    MainTabBarViewController *mainTabBarVC = [[MainTabBarViewController alloc] init];
    BaseNavigationController *mainNav = [[BaseNavigationController alloc] initWithRootViewController:mainTabBarVC];
    UserCenterViewController *userCenterVC = [[UserCenterViewController alloc] init];
    self.drawerController = [[MMDrawerController alloc]
                             initWithCenterViewController:mainNav
                             leftDrawerViewController:userCenterVC
                             rightDrawerViewController:nil];
    [self.drawerController setShowsShadow:YES];
    [self.drawerController setRestorationIdentifier:@"MMDrawer"];
    [self.drawerController setMaximumLeftDrawerWidth:(kSCREEN_WIDTH)*3/4];
    [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    [self.drawerController
     setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
         MMDrawerControllerDrawerVisualStateBlock block;
         block = [MMDrawerVisualState parallaxVisualStateBlockWithParallaxFactor:2.0];
         if(block){
             block(drawerController, drawerSide, percentVisible);
         }
     }];
    self.window.rootViewController = self.drawerController;
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

@end
