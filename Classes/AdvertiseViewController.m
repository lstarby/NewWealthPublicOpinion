//
//  AdvertiseViewController.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/21.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "AdvertiseViewController.h"
#import "MBProgressHUD+Extend.h"
#import "UserHeader.h"
#import "UserManager.h"
#import "LoginViewController.h"
#import "AppHeader.h"
#import "NotificationHeader.h"
#import "HttpManager.h"
#import "HelpManager.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface AdvertiseViewController ()

@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, strong) UIImageView *adImageView;

@end

@implementation AdvertiseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    [self createSubview];
    __weak typeof(self) weakSelf = self;
    [[UserHandler sharedUserHandler] startUserOauth:^(OAToken *token, int aCode) {
        if (aCode != 0) {
            [MBProgressHUD showError:@"获取认证信息失败！"];
            [weakSelf nextViewController];
            return ;
        }
        [HelpManager getZiXunTitleList];
        [HelpManager getUserPermission:^(BOOL success) {
            if (!success) {
                [weakSelf nextViewController];
                return ;
            }
            [weakSelf getAdvertiseImage];
        }];
    }];
}

- (void)createSubview {
    self.imageName = @"2280";
    if (kiPhone4) {
        self.imageName = @"lanch960";
    } else if (kiPhone5) {
        self.imageName = @"lanch1136";
    } else if (kiPhone6) {
        self.imageName = @"1334";
    } else if (kiPhone6Plus) {
        self.imageName = @"2280";
    }

    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    bgImageView.image = [UIImage imageNamed:self.imageName];
    [self.view addSubview:bgImageView];
    
    self.adImageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.adImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.adImageView.backgroundColor = [UIColor whiteColor];
    [self.adImageView setUserInteractionEnabled:YES];
    
    UIButton *skipButton = [UIButton buttonWithType:UIButtonTypeCustom];
    skipButton.frame = CGRectMake(kSCREEN_WIDTH - 60, kSCREEN_HEIGHT - 60, 40, 20);
    [skipButton setTitle:@"跳过" forState:UIControlStateNormal];
    [skipButton setTitle:@"" forState:UIControlStateHighlighted];
    skipButton.titleLabel.font = [UIFont systemFontOfSize:12];
    skipButton.titleLabel.textColor = [UIColor blackColor];
    [skipButton addTarget:self action:@selector(skipButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.adImageView addSubview:skipButton];
}

- (void)skipButtonClicked:(UIButton *)sender {
    [NSRunLoop cancelPreviousPerformRequestsWithTarget:self selector:@selector(nextViewController) object:self];
    [self nextViewController];
}

- (void)getAdvertiseImage {
    //version  IOS   4、5、6、6plus
    NSString *version = @"6plus";
    if (kiPhone4) {
        version = @"4";
    } else if (kiPhone5) {
        version = @"5";
    } else if (kiPhone6) {
        version = @"6";
    } else if (kiPhone6Plus) {
        version = @"6plus";
    }
    __weak typeof(self) weakSelf = self;
    [HttpManager requestAdvertiseImageVersion:version SuccessBlock:^(NSDictionary *returnData) {
        if (returnData == nil) {
            [weakSelf nextViewController];
            return ;
        }
        if ([returnData[kStatus] intValue] == kSuccess) {
            id getAd =  [returnData objectForKey:@"items"];
            NSString *photo = nil;
            if ( [getAd isKindOfClass:[NSArray class]] ) {
                NSArray *array = (NSArray*)getAd;
                if (array.count > 0 ) {
                    NSDictionary *getDicObj = [array objectAtIndex:0];
                    photo = [getDicObj objectForKey:@"photoSource"];
                }
            } else if ([getAd isKindOfClass:[NSDictionary class]]) {
                NSDictionary *dict = getAd;
                if (dict) {
                    photo = [dict objectForKey:@"photoSource"];
                }
            }
            if (photo) {
                DLog(@"%@",photo);
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (photo != nil && ![photo isEqualToString:@""]) {
                        NSURL *url = [NSURL URLWithString:photo];
                        [weakSelf.adImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:self.imageName]];
                        [weakSelf.view addSubview:weakSelf.adImageView];
                    }
                    [weakSelf performSelector:@selector(nextViewController) withObject:weakSelf afterDelay:4.0];
                });
            }
        } else {
            [weakSelf nextViewController];
        }
    } failureBlock:^(NSError *error) {
        [weakSelf nextViewController];
    }];
}

- (void)nextViewController {
    if ([UserManager userIsAlreadLogin]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kShowMainVC object:@YES];
    }
    else {
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
