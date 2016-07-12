//
//  ApplyFoucsViewController.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/24.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "ApplyFoucsViewController.h"
#import "UICommon.h"
#import "HelpManager.h"
#import "MBProgressHUD+Extend.h"
#import "HttpManager.h"
#import "ApplyRecordViewController.h"

@interface ApplyFoucsViewController ()
@property (strong, nonatomic) UITextField *nameTextFiled;
@end

@implementation ApplyFoucsViewController

- (id)initWithApplyFoucsType:(ApplyFoucsType)applyFoucsType {
    self = [super init];
    if (self) {
        self.applyFoucsType = applyFoucsType;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *title = nil;
    if (self.applyFoucsType == ApplyFoucsCompany) {
        title = @"申请关注公司";
    } else if (self.applyFoucsType == ApplyFoucsCharacter) {
        title = @"申请关注人物";
    }
    [UICommon setNavBarTitle:self.navigationItem title:title];
    self.navigationItem.rightBarButtonItem = [UICommon createCustomNavButtonTitle:@"提交" image:nil target:self selector:@selector(applyFoucs)];
    [self createSubview];
    [UICommon addTapGestureToView:self.view target:self selector:@selector(oneFingerOneTap)];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.nameTextFiled becomeFirstResponder];
}

- (void)createSubview {
    UIImageView *bgImageView= [[UIImageView alloc] init];
    bgImageView.frame = CGRectMake(10, 10, 290, 40);
    bgImageView.image = [UIImage imageNamed:@"input"];
    [self.view addSubview:bgImageView];
    
    NSString *placeholder = nil;
    if (self.applyFoucsType == ApplyFoucsCompany) {
        placeholder = @"公司名称";
    } else if (self.applyFoucsType == ApplyFoucsCharacter) {
        placeholder = @"人物名称";
    }
    self.nameTextFiled = [[UITextField alloc] init];
    self.nameTextFiled.frame = CGRectMake(14, 15, 290, 30);
    self.nameTextFiled.font = [UIFont systemFontOfSize:15];
    self.nameTextFiled.placeholder = placeholder;
    self.nameTextFiled.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.nameTextFiled];
    
    UIButton *recordButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [recordButton setTitle:@"查看申请记录" forState:UIControlStateNormal];
    recordButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [recordButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [recordButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    recordButton.frame = CGRectMake(self.view.frame.size.width-140, bgImageView.frame.size.height + 15, 140, 30);
    [recordButton addTarget:self action:@selector(recordButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:recordButton];
}

- (void)recordButtonClicked {
    ApplyRecordViewController *applyRecordVC = [[ApplyRecordViewController alloc] initWithApplyFoucsType:self.applyFoucsType];
    [self.navigationController pushViewController:applyRecordVC animated:YES];
}

- (void)oneFingerOneTap {
    if ([self.nameTextFiled isFirstResponder]) {
        [self.nameTextFiled resignFirstResponder];
    }
}

- (void)applyFoucs {
    [self oneFingerOneTap];
    if ([HelpManager isVisitor]) {
        return;
    }
    NSString *name = self.nameTextFiled.text;
    if (name == nil || [name isEqualToString:@""]) {
        [MBProgressHUD showError:@"请填写人物名称！"];
        return;
    }
    __weak typeof(self) weakSelf = self;
    [MBProgressHUD showMessage:@"正在提交..."];
    [HttpManager requestApplyFoucs:name applyFoucsType:self.applyFoucsType SuccessBlock:^(NSDictionary *returnData) {
        if ([returnData[kStatus] intValue] == kSuccess) {
             [MBProgressHUD showError:@"提交成功"];
        } else {
            [MBProgressHUD showError:returnData[kMessage]];
        }
        [weakSelf goBack];
    } failureBlock:^(NSError *error) {
        [MBProgressHUD showError:@"提交失败"];
        [weakSelf goBack];
    }];
}

- (void)goBack {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
