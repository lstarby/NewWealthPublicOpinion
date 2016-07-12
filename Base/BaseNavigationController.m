//
//  BaseNavigationController.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/17.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "BaseNavigationController.h"
#import "UtilsHeader.h"
#import "UICommon.h"

@implementation BaseNavigationController

+ (void)appearanceNavigationBar {
    [[UINavigationBar appearance] setBarTintColor:COLOR_REDDEF];
    [[UINavigationBar appearance] setTranslucent:NO];
    [[UINavigationBar appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:COLOR_BAR_TITLE, NSForegroundColorAttributeName, [UIFont fontWithName:@ "HelveticaNeue-CondensedBlack" size:21.0], NSFontAttributeName, nil]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (kiOS7)
    {
        __weak typeof (self) weakSelf = self;
        if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.interactivePopGestureRecognizer.delegate = weakSelf;
        }
    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [super pushViewController:viewController animated:animated];
    if (kiOS7)
    {
        if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.interactivePopGestureRecognizer.enabled = NO;
        }
    }
    // 添加返回
    if ([self.viewControllers count] > 1){
        if (viewController.navigationItem.leftBarButtonItem == nil){
            viewController.navigationItem.leftBarButtonItem = [UICommon createCustomNavButtonTitle:nil image:[UIImage imageNamed:@"back"] target:self selector:@selector(backBtnClicked:)];
        }
    }
}

- (void)backBtnClicked:(id)sender{
    [super popViewControllerAnimated:YES];
}

- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    [super presentViewController:viewControllerToPresent animated:flag completion:completion];
    UINavigationController *nav = (UINavigationController*)viewControllerToPresent;
    // 添加返回
    if ([self.viewControllers count] > 1){
        if (nav.topViewController.navigationItem.leftBarButtonItem == nil){
            nav.topViewController.navigationItem.leftBarButtonItem = [UICommon createCustomNavButtonTitle:nil image:[UIImage imageNamed:@"back"] target:self selector:@selector(dissmissBtnClicked:)];
        }
    }
}

- (void)dissmissBtnClicked:(id)sender{
    [super dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController
        didShowViewController:(UIViewController *)viewController
                     animated:(BOOL)animate {
   // Enable the gesture again once the new controller is shown
    if (kiOS7)
    {
        if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
            self.interactivePopGestureRecognizer.enabled = YES;
    }
}


@end
