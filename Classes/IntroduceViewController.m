//
//  IntroduceViewController.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/7/12.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "IntroduceViewController.h"
#import "UICommon.h"
#import "ConstHeader.h"

@interface IntroduceViewController ()

@property (strong, nonatomic) UILabel *banquanLabel;
@property (strong, nonatomic) UILabel *descLabel;

@end

@implementation IntroduceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [UICommon setNavBarTitle:self.navigationItem title:@"关于我们"];
    [self createSubView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    [self.mm_drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeNone];
}

- (void)createSubView {
 
    self.banquanLabel = [[UILabel alloc] init];
    self.banquanLabel.frame = CGRectMake(10, self.view.frame.size.height-100, self.view.frame.size.width-20, 21);
    self.banquanLabel.textAlignment = NSTextAlignmentCenter;
    self.banquanLabel.font = [UIFont systemFontOfSize:10];
    self.banquanLabel.textColor = [UIColor lightGrayColor];
    self.banquanLabel.text = @"Copyright © 2015 西安全景数据技术有限公司  版权所有";
    
    
    self.descLabel = [[UILabel alloc] init];
    self.descLabel.frame = CGRectMake(25, 20 + kLoginHeight, self.view.frame.size.width-50, 200);
    self.descLabel.textAlignment = NSTextAlignmentLeft;
    self.descLabel.textColor = [UIColor lightGrayColor];
    self.descLabel.font = [UIFont systemFontOfSize:15];
    self.descLabel.text = @"        新财富舆情中心是西安全景数据技术有限公司旗下负责舆情研究及服务的专业机构。依托自身强大的数据、全媒体资源和技术优势，精心打造的资本市场舆情服务品牌。为资本市场提供全方位、多维度的舆情服务，在业内处于领先地位。\r\n\r\n微信公众号： xcfyqzx\r\n微博公众号： 新财富舆情中心";
    self.descLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.descLabel.numberOfLines = 0;
    
    [self.view addSubview:self.banquanLabel];
    [self.view addSubview:self.descLabel];
}

@end
