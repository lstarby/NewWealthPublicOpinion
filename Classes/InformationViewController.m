//
//  InformationViewController.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/21.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "InformationViewController.h"
#import <MMDrawerController/UIViewController+MMDrawerController.h>
#import <MMDrawerController/MMDrawerController.h>
#import "UtilsHeader.h"
#import "UserHandler.h"
#import "UICommon.h"
#import "DefaultNewsViewController.h"
#import "DisclosureViewController.h"
#import "OtherNewsViewController.h"

@interface InformationViewController ()

@property (nonatomic, strong)  NSArray *menuList;

@end

static NSString *defaultNews = @"DefaultNewsViewController";
static NSString *disclosure = @"DisclosureViewController";
static NSString *otherNews = @"OtherNewsViewController";

@implementation InformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [UICommon setNavBarTitle:self.navigationItem title:@"资讯"];
    [self initSubView];
}

- (void)initSubView {
    self.magicView.bounces = YES;
    self.magicView.headerHidden = YES;
    self.magicView.itemSpacing = 15.f;
    self.magicView.separatorHidden = NO;
    self.magicView.itemScale = 1.2;
    self.magicView.headerHeight = 40;
    self.magicView.againstStatusBar = NO;
    self.magicView.sliderExtension = 4.0;
    self.magicView.separatorHidden = YES;
    self.magicView.switchStyle = VTSwitchStyleDefault;
    self.magicView.headerView.backgroundColor = [UIColor clearColor];
    self.magicView.layoutStyle = VTLayoutStyleDefault;
    [self.magicView switchToPage:0 animated:YES];
//    self.magicView.rightNavigatoinItem = nil;
    self.view.backgroundColor = COLOR_BKGROUND;
    _menuList = [UserHandler sharedUserHandler].userChannels;
    [self.magicView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self setNeedsStatusBarAppearanceUpdate];
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    [self.mm_drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeNone];
}

#pragma mark - VTMagicViewDataSource
- (NSArray<NSString *> *)menuTitlesForMagicView:(VTMagicView *)magicView
{
    NSMutableArray *titleList = [NSMutableArray array];
    for (UserChannel *channel in _menuList) {
        [titleList addObject:channel.name];
    }
    return titleList;
}

- (UIButton *)magicView:(VTMagicView *)magicView menuItemAtIndex:(NSUInteger)itemIndex
{
    static NSString *itemIdentifier = @"itemIdentifier";
    UIButton *menuItem = [magicView dequeueReusableItemWithIdentifier:itemIdentifier];
    if (!menuItem) {
        menuItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [menuItem setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [menuItem setTitleColor:COLOR_REDDEF forState:UIControlStateSelected];
        [menuItem setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        menuItem.titleLabel.font = [UIFont systemFontOfSize:14];;
    }
    return menuItem;
}

- (UIViewController *)magicView:(VTMagicView *)magicView viewControllerAtPage:(NSUInteger)pageIndex
{
    UserChannel *channel = [UserHandler sharedUserHandler].userChannels[pageIndex];
    
    if (pageIndex == 0 ||  pageIndex == 1  ||  pageIndex == 2  ||  pageIndex == 3) {
        DefaultNewsViewController *defaultNewsVC = [magicView dequeueReusablePageWithIdentifier:defaultNews];
        if (!defaultNewsVC) {
            defaultNewsVC = [[DefaultNewsViewController alloc] init];
        }
        defaultNewsVC.userChannel = channel;
        return defaultNewsVC;
    } else if (pageIndex == 4) {
        DisclosureViewController *disclosureVC = [magicView dequeueReusablePageWithIdentifier:disclosure];
        if (!disclosureVC) {
            disclosureVC = [[DisclosureViewController alloc] init];
        }
        disclosureVC.userChannel = channel;
        return disclosureVC;
    } else {
        OtherNewsViewController *otherNewsVC  = [magicView dequeueReusablePageWithIdentifier:otherNews];
        if (!otherNewsVC) {
            otherNewsVC = [[OtherNewsViewController alloc] init];
        }
        otherNewsVC.userChannel = channel;
        return otherNewsVC;
    }
}

#pragma mark - VTMagicViewDelegate
- (void)magicView:(VTMagicView *)magicView viewDidAppear:(UIViewController *)viewController atPage:(NSUInteger)pageIndex {
}

- (void)magicView:(VTMagicView *)magicView viewDidDisappear:(UIViewController *)viewController atPage:(NSUInteger)pageIndex {
}

- (void)magicView:(VTMagicView *)magicView didSelectItemAtIndex:(NSUInteger)itemIndex {
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
