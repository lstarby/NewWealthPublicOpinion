//
//  ModifyPasswordViewController.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/24.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "ModifyPasswordViewController.h"
#import "UICommon.h"
#import "NSString+Extend.h"
#import "MBProgressHUD+Extend.h"
#import "HttpManager.h"
#import "UserManager.h"

@interface ModifyPasswordViewController ()

@property (nonatomic, strong) UITextField *oldTextFiled;
@property (nonatomic, strong) UITextField *freshTextFiled;
@property (nonatomic, strong) UITextField *sureTextFiled;

@end

@implementation ModifyPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [UICommon setNavBarTitle:self.navigationItem title:@"修改密码"];
    self.navigationItem.rightBarButtonItem = [UICommon createCustomNavButtonTitle:@"保存" image:nil target:self selector:@selector(savePassword)];
    [self createSubview];
    [UICommon addTapGestureToView:self.view target:self selector:@selector(oneFingerOneTap)];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.oldTextFiled becomeFirstResponder];
}

- (void)createSubview {
    UIImageView *oldImageView = [[UIImageView alloc] init];
    oldImageView.frame = CGRectMake(10, 10, 290, 40);
    oldImageView.image = [UIImage imageNamed:@"input"];
    [self.view addSubview:oldImageView];
    
    UIImageView *newImageView = [[UIImageView alloc] init];
    newImageView.frame = CGRectMake(10, 60, 290, 80);
    newImageView.image = [UIImage imageNamed:@"input2"];
    [self.view addSubview:newImageView];
    
    self.oldTextFiled = [[UITextField alloc] init];
    self.oldTextFiled.frame = CGRectMake(14, 15, 290, 30);
    self.oldTextFiled.font = [UIFont systemFontOfSize:15];
    self.oldTextFiled.secureTextEntry = YES;
    self.oldTextFiled.placeholder = @"旧密码";
    [self.view addSubview:self.oldTextFiled];
    
    
    self.freshTextFiled = [[UITextField alloc] init];
    self.freshTextFiled.frame = CGRectMake(14, 65, 290, 30);
    self.freshTextFiled.font = [UIFont systemFontOfSize:15];
    self.freshTextFiled.secureTextEntry = YES;
    self.freshTextFiled.placeholder = @"新密码";
    [self.view addSubview:self.freshTextFiled];
    
    self.sureTextFiled = [[UITextField alloc] init];
    self.sureTextFiled.frame = CGRectMake(14, 105, 290, 30);
    self.sureTextFiled.font = [UIFont systemFontOfSize:15];
    self.sureTextFiled.secureTextEntry = YES;
    self.sureTextFiled.placeholder = @"确认密码";
    [self.view addSubview:self.sureTextFiled];
}

- (void)oneFingerOneTap {
    if ([self.oldTextFiled isFirstResponder]) {
        [self.oldTextFiled resignFirstResponder];
    }
    if ([self.freshTextFiled isFirstResponder]) {
        [self.freshTextFiled resignFirstResponder];
    }
    if ([self.sureTextFiled isFirstResponder]) {
        [self.sureTextFiled resignFirstResponder];
    }
}

- (void)savePassword {
    [self oneFingerOneTap];
    NSString *oldPassword = self.oldTextFiled.text;
    NSString *newPassword = self.freshTextFiled.text;
    NSString *surePassword = self.sureTextFiled.text;
    NSString *result = [oldPassword sureNewPassword:newPassword surePassword:surePassword];
    if (result) {
        [MBProgressHUD showError:result];
        return;
    }
    [MBProgressHUD showMessage:@"正在修改密码..."];
    [HttpManager requestModifyPassword:newPassword oldPassword:oldPassword SuccessBlock:^(NSDictionary *returnData) {
        if ([returnData[kStatus] intValue] == kSuccess) {
            [MBProgressHUD showSuccess:@"修改密码成功！"];
            NSString *userName = [UserManager readUserName];
            [UserManager saveUserName:userName passWord:newPassword];
        } else {
            [MBProgressHUD showError:returnData[kMessage]];
        }
        [self goBack];
    } failureBlock:^(NSError *error) {
        [MBProgressHUD showError:@"修改密码失败！"];
        [self goBack];
    }];
}

- (void)goBack {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
