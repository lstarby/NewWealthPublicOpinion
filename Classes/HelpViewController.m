//
//  HelpViewController.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/7/13.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "HelpViewController.h"
#import "GuideView.h"

@interface HelpViewController ()<EAIntroDelegate>
@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    [self createSubView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    [self.mm_drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeNone];
}

- (void)createSubView {
    GuideView *guideView = [[GuideView alloc] initWithFrame:[UIScreen  mainScreen].bounds];
    guideView.delegate = self;
    [guideView showInView:self.view];
}

#pragma mark - EAIntroDelegate
- (void)introDidFinish:(EAIntroView *)introView wasSkipped:(BOOL)wasSkipped {
    [self.navigationController popViewControllerAnimated:YES];
    self.navigationController.navigationBarHidden = NO;
}

@end
