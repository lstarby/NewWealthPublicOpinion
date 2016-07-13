//
//  FeedbackViewController.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/7/12.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "FeedbackViewController.h"
#import "UICommon.h"
#import "HelpManager.h"
#import "MBProgressHUD+Extend.h"
#import "HttpManager.h"

@interface FeedbackViewController ()
@property (strong, nonatomic) UITextView *textView;


@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [UICommon setNavBarTitle:self.navigationItem title:@"联系我们"];
    [self createSubView];
    self.navigationItem.rightBarButtonItem = [UICommon createCustomNavButtonTitle:@"提交" image:nil target:self selector:@selector(submit)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.textView becomeFirstResponder];
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    [self.mm_drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeNone];
}

- (void)createSubView {
    
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.frame = CGRectMake(10, 10, self.view.frame.size.width-20, 120);
    bgView.layer.cornerRadius = 4.0f;
    [bgView.layer setBorderColor:[UIColor colorWithRed:210/255.0 green:210/255.0 blue:210/255.0 alpha:1].CGColor];
    [bgView.layer setBorderWidth:1.0];
    [self.view addSubview:bgView];

    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(5, 0, bgView.frame.size.width-10, 120)];
    self.textView.font = [UIFont systemFontOfSize:15];
    [bgView addSubview:self.textView];
}

- (void)submit {
    if ([HelpManager isVisitor]) {
        return;
    }
    NSString *content = self.textView.text;
    if (content == nil || [content isEqualToString:@""]) {
        [MBProgressHUD showTextHUD:@"您还没有填写反馈信息"];
        return;
    }
    [MBProgressHUD showMessage:@"正在提交..."];
    [HttpManager requestFeedback:content SuccessBlock:^(NSDictionary *returnData) {
        if (returnData == nil) {
            [MBProgressHUD showError:@"提交失败，请检查网络是否正常"];
            return ;
        }
        if ([returnData[kStatus] intValue] == kSuccess) {
            [MBProgressHUD showSuccess:@"提交成功"];
        }
        else {
            [MBProgressHUD showSuccess:@"提交失败"];
        }
    } failureBlock:^(NSError *error) {
        [MBProgressHUD showSuccess:@"提交失败"];
    }];
}

@end
