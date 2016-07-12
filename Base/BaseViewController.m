//
//  BaseViewController.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/17.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "BaseViewController.h"
#import "UtilsHeader.h"

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        [self setEdgesForExtendedLayout:UIRectEdgeNone]; //从（0, 64）开始
    }
    if([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]){
        [self setAutomaticallyAdjustsScrollViewInsets:NO];
    }
    self.view.backgroundColor = COLOR_BKGROUND;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self setNeedsStatusBarAppearanceUpdate];
    
}

- (void)setAutomaticallyAdjustsScrollViewInsets:(BOOL)flag {
    if (kiOS7) {
        [super setAutomaticallyAdjustsScrollViewInsets:flag];
    }
}


@end
