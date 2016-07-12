//
//  ModifyNameViewController.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/24.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "ModifyNamePhoneViewController.h"
#import "UICommon.h"
#import "UtilsHeader.h"
#import "HelpManager.h"
#import "NSString+Extend.h"
#import "MBProgressHUD+Extend.h"
#import "HttpManager.h"
#import "UserHeader.h"
@interface ModifyNamePhoneViewController ()
@property (nonatomic, strong) UITextField *textFiled;
@end

@implementation ModifyNamePhoneViewController

- (id)initWithModifyType:(ModifyType)modifyType {
    self = [super init];
    if (self) {
        self.modifyType = modifyType;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *title = nil;
    if (self.modifyType == ModifyName) {
        title = @"修改昵称";
    } else if (self.modifyType == ModifyPhone) {
        title = @"修改手机号";
    }
    [UICommon setNavBarTitle:self.navigationItem title:title];
    self.navigationItem.rightBarButtonItem = [UICommon createCustomNavButtonTitle:@"保存" image:nil target:self selector:@selector(saveName)];
    [self createSubview];
    [UICommon addTapGestureToView:self.view target:self selector:@selector(oneFingerOneTap)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.modifyType == ModifyName) {
        self.textFiled.text = [UserHandler sharedUserHandler].loginUser.nickname;
    } else if (self.modifyType == ModifyPhone) {
        self.textFiled.text = [UserHandler sharedUserHandler].loginUser.mobile;
    }
}

- (void)createSubview {
    UIImageView *bgimgView = [[UIImageView alloc] init];
    bgimgView.frame = CGRectMake(10, 10, 290, 40);
    bgimgView.image = [UIImage imageNamed:@"input"];
    [self.view addSubview:bgimgView];
    
    self.textFiled = [[UITextField alloc] init];
    self.textFiled.frame = CGRectMake(14, 15, 290, 30);
    self.textFiled.font = [UIFont systemFontOfSize:15];
    if (self.modifyType == ModifyName) {
        self.textFiled.placeholder = @"请输入1-16个字母、数字或1-8个汉字";
        self.textFiled.keyboardType = UIKeyboardTypeDefault;
    } else if (self.modifyType == ModifyPhone) {
        self.textFiled.placeholder = @"新手机号";
        self.textFiled.keyboardType = UIKeyboardTypeNumberPad;
    }
    self.textFiled.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.textFiled];
}

- (void)oneFingerOneTap {
    if ([self.textFiled isFirstResponder]) {
        [self.textFiled resignFirstResponder];
    }
}

- (void)saveName {
    [self oneFingerOneTap];
    if ([HelpManager isVisitor]) {
        return;
    }
    if (self.modifyType == ModifyName) {
        [self modifyNickName];
    } else if (self.modifyType == ModifyPhone) {
        [self modifyPhone];
    }
}

- (void)modifyNickName {
    NSString *nickName = self.textFiled.text;

    NSString *result = [nickName isNickName];
    if (result != nil) {
        [MBProgressHUD showError:result];
        return;
    }
    [MBProgressHUD showMessage:@"正在修改昵称..."];
    [HttpManager requestModifyKey:@"nickname" value:nickName SuccessBlock:^(NSDictionary *returnData) {
        if ([returnData[kStatus] intValue] == kSuccess) {
            [MBProgressHUD showSuccess:@"修改昵称成功"];
            [UserHandler sharedUserHandler].loginUser.nickname = nickName;
            [UserManager saveUserInfo:[UserHandler sharedUserHandler].loginUser];
        } else {
            [MBProgressHUD showError:returnData[kMessage]];
        }
        [self goBack];
    } failureBlock:^(NSError *error) {
        [MBProgressHUD showError:@"修改昵称失败"];
        [self goBack];
    }];
}

- (void)modifyPhone {
    NSString *mobile = self.textFiled.text;
    
    NSString *result = [mobile isValiMobile];
    if (result != nil) {
        [MBProgressHUD showError:result];
        return;
    }
    [MBProgressHUD showMessage:@"正在修改手机号..."];
    [HttpManager requestModifyKey:@"mobile" value:mobile SuccessBlock:^(NSDictionary *returnData) {
        if ([returnData[kStatus] intValue] == kSuccess) {
            [MBProgressHUD showSuccess:@"修改手机号成功"];
            [UserHandler sharedUserHandler].loginUser.mobile = mobile;
            [UserManager saveUserInfo:[UserHandler sharedUserHandler].loginUser];
        } else {
            [MBProgressHUD showError:returnData[kMessage]];
        }
        [self goBack];
    } failureBlock:^(NSError *error) {
        [MBProgressHUD showError:@"修改手机号失败"];
        [self goBack];
    }];
}

- (void)goBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
