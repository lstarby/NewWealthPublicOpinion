//
//  ConnetViewController.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/7/12.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "ConnetViewController.h"
#import "UICommon.h"
#import "ConstHeader.h"

@interface ConnetViewController ()
@property (strong, nonatomic) UIImageView *logoImageView;
@property (strong,nonatomic ) UILabel     *banquanLabel;
@property (strong,nonatomic ) UILabel     *descLabel;

@end

@implementation ConnetViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [UICommon setNavBarTitle:self.navigationItem title:@"联系我们"];
    
    [self createSubView];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    [self.mm_drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeNone];
}

- (void)createSubView {
    self.logoImageView = [[UIImageView alloc] init];
    self.logoImageView .frame = CGRectMake(self.view.frame.size.width/2-103, 50+ kLoginHeight, 207, 51);
    self.logoImageView .image = [UIImage imageNamed:@"login_logo"];
    [self.view addSubview:self.self.logoImageView];
    
    self.banquanLabel = [[UILabel alloc] init];
    self.banquanLabel.frame = CGRectMake(10, self.view.frame.size.height-100, self.view.frame.size.width-20, 21);
    self.banquanLabel.textAlignment = NSTextAlignmentCenter;
    self.banquanLabel.font = [UIFont systemFontOfSize:10];
    self.banquanLabel.textColor = [UIColor lightGrayColor];
    self.banquanLabel.text = @"Copyright © 2015 西安全景数据技术有限公司  版权所有";
    [self.view addSubview:self.banquanLabel];
    
    self.descLabel = [[UILabel alloc] init];
    self.descLabel.frame = CGRectMake(50, 110+ kLoginHeight, self.view.frame.size.width-100, 80);
    self.descLabel.textAlignment = NSTextAlignmentLeft;
    self.descLabel.textColor = [UIColor lightGrayColor];
    self.descLabel.font = [UIFont systemFontOfSize:15];
    self.descLabel.text = @"客服电话: 029-88993782\r\n联系邮箱: yqkf@p5w.net\r\n地址:西安市科技二路软件园唐乐阁E101";
    self.descLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.descLabel.numberOfLines = 0;
    [self.view addSubview:self.descLabel];
    
}

@end
