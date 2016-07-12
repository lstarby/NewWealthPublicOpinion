//
//  ForgetViewController.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/20.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "ForgetViewController.h"
#import "ConstHeader.h"
#import "UICommon.h"

@implementation ForgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    [UICommon setNavBarTitle:self.navigationItem title:@"忘记密码"];
    [self createSubview];
}

- (void)createSubview {
    UIImageView *logoImageView = [[UIImageView alloc] init];
    logoImageView.frame = CGRectMake(self.view.frame.size.width/2-103, 50 + kLoginHeight, 207, 51);
    logoImageView.image = [UIImage imageNamed:@"login_logo"];
    [self.view addSubview:logoImageView];
    
    UILabel *banquanLabel = [[UILabel alloc] init];
    banquanLabel.frame = CGRectMake(10, self.view.frame.size.height-100, self.view.frame.size.width-20, 21);
    banquanLabel.textAlignment = NSTextAlignmentCenter;
    banquanLabel.font = [UIFont systemFontOfSize:10];
    banquanLabel.textColor = [UIColor lightGrayColor];
    banquanLabel.text = BANQUAN;
    [self.view addSubview:banquanLabel];
    
    UILabel *descLabel = [[UILabel alloc] init];
    descLabel.frame = CGRectMake(50, 120+ kLoginHeight, self.view.frame.size.width-100, 100);
    descLabel.textAlignment = NSTextAlignmentLeft;
    descLabel.textColor = [UIColor lightGrayColor];
    descLabel.font = [UIFont systemFontOfSize:15];
    descLabel.text = FORGET_TITLE;
    descLabel.lineBreakMode = NSLineBreakByWordWrapping;
    descLabel.numberOfLines = 0;
    [self.view addSubview:descLabel];
}

@end
