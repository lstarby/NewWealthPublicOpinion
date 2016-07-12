//
//  LoginViewController.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/17.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "LoginViewController.h"
#import "UserHeader.h"
#import "ConstHeader.h"
#import "UtilsHeader.h"
#import "MBProgressHUD+Extend.h"
#import "ForgetViewController.h"
#import "HttpManager.h"
#import "NotificationHeader.h"
#import "DBManager.h"
#import "HelpManager.h"
#import "UICommon.h"

@interface LoginViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *userNameTextFiled;
@property (nonatomic, strong) UITextField *userPwdTextFiled;
@property (nonatomic, strong) UIButton    *rememberButton;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    [self createLoginView];
    [UICommon addTapGestureToView:self.view target:self selector:@selector(oneFingerOneTaps)];
    if (![UserManager getGuideTag]) {
        //引导页
        GuideView *guideView = [[GuideView alloc] initWithFrame:[UIScreen  mainScreen].bounds];
        guideView.delegate = self;
        [guideView showInView:self.view];
    }
    [[UserHandler sharedUserHandler] startUserOauth:^(OAToken *token, int aCode) {
        if (aCode != 0) {
            [MBProgressHUD showError:@"获取认证信息失败！"];
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSString *rememberMeStr = [UserManager getRemeberMe];
    if ( [rememberMeStr isEqualToString:@"0"] ) {
        _rememberButton.selected = NO;
        _userNameTextFiled.text = @"";
        _userPwdTextFiled.text = @"";
    }
    else {
        _userNameTextFiled.text = [UserManager readUserName];
        _userPwdTextFiled.text = [UserManager readPassWord];
    }
}

- (void)createLoginView {
    UIImageView *logoImage = [[UIImageView alloc] init];
    logoImage.frame = CGRectMake(self.view.frame.size.width/2-103, 100 + kLoginHeight, 207, 51);
    logoImage.image = [UIImage imageNamed:@"login_logo"];
    [self.view addSubview:logoImage];
    
    UIImageView *inputBgImage = [[UIImageView alloc] init];
    inputBgImage.frame = CGRectMake(self.view.frame.size.width/2-137, 180+ kLoginHeight, 275, 80);
    inputBgImage.image = [UIImage imageNamed:@"input2"];
    
    [self.view addSubview:inputBgImage];
    
    
    _userNameTextFiled = [[UITextField alloc] init];
    _userNameTextFiled.frame = CGRectMake(self.view.frame.size.width/2-130, 186 + kLoginHeight,260, 30);
    _userNameTextFiled.placeholder = @"账号";
    _userNameTextFiled.delegate = self;
    [self.view  addSubview:_userNameTextFiled];
    
    
    _userPwdTextFiled = [[UITextField alloc] init];
    _userPwdTextFiled.frame = CGRectMake(self.view.frame.size.width/2-130, 224+ kLoginHeight, 260, 30);
    _userPwdTextFiled.secureTextEntry = YES;
    _userPwdTextFiled.placeholder = @"密码";
    _userPwdTextFiled.delegate = self;
    _userPwdTextFiled.keyboardType = UIReturnKeyGo;
    [self.view  addSubview:_userPwdTextFiled];
    
    
    _rememberButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rememberButton setTitle:@"记住密码" forState:UIControlStateNormal];
    _rememberButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_rememberButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_rememberButton setTitleColor:COLOR_REDDEF forState:UIControlStateSelected];
    [_rememberButton setImage:[UIImage imageNamed:@"Remember"] forState:UIControlStateNormal];
    [_rememberButton setImage:[UIImage imageNamed:@"Remember_sel"] forState:UIControlStateSelected];
    [_rememberButton addTarget:self action:@selector(rememberMeClicked:) forControlEvents:UIControlEventTouchUpInside];
    _rememberButton.frame = CGRectMake(self.view.frame.size.width/2-145, 260+ kLoginHeight, 100, 44);
    _rememberButton.selected = YES;
    [self.view  addSubview:_rememberButton];
    
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginButton setBackgroundColor:COLOR_REDDEF];
    [loginButton addTarget:self action:@selector(loginClicked:) forControlEvents:UIControlEventTouchUpInside];
    loginButton.frame = CGRectMake(self.view.frame.size.width/2-137, 310+ kLoginHeight, 275, 40);
    [loginButton.layer setCornerRadius:4.0f];
    [self.view  addSubview:loginButton];
    
    UIButton *forgetPwdButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [forgetPwdButton setTitle:@"忘记密码" forState:UIControlStateNormal];
    forgetPwdButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [forgetPwdButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [forgetPwdButton setTitleColor:COLOR_REDDEF forState:UIControlStateSelected];
    [forgetPwdButton addTarget:self action:@selector(forgetPwdClicked:) forControlEvents:UIControlEventTouchUpInside];
    forgetPwdButton.frame = CGRectMake(self.view.frame.size.width-108, 260+ kLoginHeight, 100, 44);
    [self.view  addSubview:forgetPwdButton];
    
    UIButton *guestButton = [UIButton buttonWithType:UIButtonTypeCustom];
    NSString *title = [NSString stringWithFormat:@"咨询电话:%@",PHONE];
    [guestButton setTitle:title forState:UIControlStateNormal];
    guestButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [guestButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [guestButton setTitleColor:COLOR_REDDEF forState:UIControlStateSelected];
    [guestButton addTarget:self action:@selector(guestClicked:) forControlEvents:UIControlEventTouchUpInside];
    guestButton.frame = CGRectMake(10, self.view.frame.size.height-70, self.view.frame.size.width-20, 21);
    [self.view  addSubview:guestButton];
    
    UILabel *banquanLabel = [[UILabel alloc] init];
    banquanLabel.frame = CGRectMake(10, self.view.frame.size.height-40, self.view.frame.size.width-20, 21);
    banquanLabel.textAlignment = NSTextAlignmentCenter;
    banquanLabel.font = [UIFont systemFontOfSize:10];
    banquanLabel.textColor = [UIColor lightGrayColor];
    banquanLabel.text = BANQUAN;
    [self.view addSubview:banquanLabel];
}

- (void)addTapGestureRecognizer {
    UITapGestureRecognizer *oneFingeroneTaps =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(oneFingerOneTaps)] ;
    [oneFingeroneTaps setNumberOfTapsRequired:1];
    [oneFingeroneTaps setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:oneFingeroneTaps];
}

- (void)allFocusLast {
    [_userNameTextFiled resignFirstResponder];
    [_userPwdTextFiled resignFirstResponder];
    if (kSCREEN_HEIGHT > 480) {
        return;
    }
    [UIView animateWithDuration:0.1f animations:^{
        CGRect frame = self.view.frame;
        frame.origin.y = 0;
        self.view.frame = frame;
    }];
}

-(void)oneFingerOneTaps
{
    [self allFocusLast];
}

- (void)rememberMeClicked:(UIButton *)sender {
    NSString *remember = sender.isSelected ? @"1" : @"0";
    sender.selected = !sender.isSelected;
    [UserManager saveRememberMe:remember];
}

- (void)forgetPwdClicked:(UIButton *)sender {
    ForgetViewController *forgetVC = [[ForgetViewController alloc] init];
    [self.navigationController pushViewController:forgetVC animated:YES];
}

- (void)guestClicked:(UIButton *)sender {
    
}

- (void)loginClicked:(UIButton *)sender {
    NSString *userName = _userNameTextFiled.text;
    NSString *userPwd = _userPwdTextFiled.text;
    [self allFocusLast];
    if (userName == nil || [userName isEqualToString:@""]) {
        [MBProgressHUD showError:@"请输入账号！"];
        return;
    }
    if (userPwd == nil || [userPwd isEqualToString:@""]) {
        [MBProgressHUD showError:@"请输入密码！"];
        return;
    }
    [MBProgressHUD showMessage:@"正在登录..."];
    [UserManager saveUserName:userName passWord:userPwd];
    
    [HttpManager requestLoginUserName:userName passWord:userPwd successBlock:^(NSDictionary *returnData) {
        if (returnData == nil)
        {
            [MBProgressHUD showError:@"登陆失败，网络超时"];
            return;
        }
        if ([returnData[kStatus] intValue] == kSuccess) {
            NSDictionary *userDic = returnData[@"items"];
            NSError *error = nil;
            LoginUser *loginUser = [[LoginUser alloc] initWithDictionary:userDic error:&error];
            [UserManager saveUserInfo:loginUser];
            
            [UserManager saveKeyWordType:returnData[@"kwTypeItems"]];
            [UserManager saveNewsUrl:returnData[@"detailList"]];
            
            [self initMenuPlist];
            
            [HelpManager getZiXunTitleList];
            [HelpManager upLoadUserKey];
//            [HelpManager loadLikeNews:nil];
            [HelpManager initAttentionData];
            [[NSNotificationCenter defaultCenter] postNotificationName:kShowMainVC object:@YES];
            [MBProgressHUD hideHUD];
        } else {
            [MBProgressHUD showError:returnData[kMessage]];
        }
    } failureBlock:^(NSError *error) {
        [MBProgressHUD hideHUD];
    }];
}

- (void)initMenuPlist {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Permission" ofType:@"plist"];
    NSArray *permissions = [[NSArray alloc] initWithContentsOfFile:plistPath];
    for (NSArray *array in permissions)
    {
        DLog(@"%@",array);
        MenuModel *menuModel = [[MenuModel alloc] init];
        menuModel.itemId = [[array objectAtIndex:0] intValue];
        menuModel.itemFunType = [[array objectAtIndex:1] intValue];
        menuModel.itemDataType = [[array objectAtIndex:2] intValue];
        menuModel.itemOrgType = [[array objectAtIndex:3] intValue];
        menuModel.itemOwen = [[array objectAtIndex:4] intValue];
        [DBManager insertMenuWhenNotExists:menuModel];
    }
    [DBManager updateMenuTable:[UserHandler sharedUserHandler].loginUser.permission];
    
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (kSCREEN_HEIGHT > 480) {
        return;
    }
    [UIView animateWithDuration:0.1 animations:^{
        CGRect frame = self.view.frame;
        frame.origin.y = -86;
        self.view.frame = frame;
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == _userNameTextFiled) {
        [_userPwdTextFiled becomeFirstResponder];
    } else if (textField == _userPwdTextFiled) {
        [self loginClicked:nil];
    }
    return YES;
}


#pragma mark - EAIntroDelegate
- (void)introDidFinish:(EAIntroView *)introView wasSkipped:(BOOL)wasSkipped {
    [UserManager saveGuideTag];
}

@end
