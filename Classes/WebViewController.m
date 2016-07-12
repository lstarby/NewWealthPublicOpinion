//
//  WebViewController.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/29.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "WebViewController.h"
#import "UtilsHeader.h"
#import "ANWebView.h"
#import "SIAlertView+Extend.h"
#import "UserManager.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import "DBManager.h"
#import "HelpManager.h"
#import "MBProgressHUD+Extend.h"
#import "HttpManager.h"
#import "UtilsHeader.h"
#import "NSString+Extend.h"

@interface WebViewController ()<ANWebViewDelegate>
@property (nonatomic, strong) ANWebView *webView ;
@end

@implementation WebViewController

- (id)initWithURL:(NSString *)url type:(WebViewType)webViewType {
    self = [super init];
    if (self) {
        self.url = url;
        self.webViewType = webViewType;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    [self createSubview];
    [self createToolbarItems];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)createSubview {
    CGRect rect = [[UIApplication sharedApplication] statusBarFrame];
    UIView *statusView = [[UIView alloc] init];
    statusView.frame = rect;
    statusView.backgroundColor = COLOR_REDDEF;
    [self.view addSubview:statusView];

    self.webView = [[ANWebView alloc] initWithFrame:CGRectMake(0, rect.size.height, kSCREEN_WIDTH, kSCREEN_HEIGHT - rect.size.height - 44)];
    [self.view addSubview:self.webView];
    [self.webView loadURLString:self.url];
}

- (void)createToolbarItems {
    NSMutableArray *toolBarItems = [NSMutableArray array];
    UIBarButtonItem *spaceButton =[ [UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    if (self.webViewType & WebViewBackTool) {
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonClicked:)];
        [toolBarItems addObject:backButton];
        [toolBarItems addObject:spaceButton];
    }
    if (self.webViewType & WebViewFontTool) {
        UIBarButtonItem *setFontButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"webfont"] style:UIBarButtonItemStylePlain target:self action:@selector(setFontButtonClicked:)];
        [toolBarItems addObject:setFontButton];
        [toolBarItems addObject:spaceButton];
    }
    if (self.webViewType & WebViewShareTool) {
        UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"forward"] style:UIBarButtonItemStylePlain target:self action:@selector(shareButtonClicked:)];
        [toolBarItems addObject:shareButton];
        [toolBarItems addObject:spaceButton];
    }
    if (self.webViewType & WebViewCollectTool) {
        UIButton *customButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [customButton setImage:[UIImage imageNamed:@"collectnews_"] forState:UIControlStateNormal];
        [customButton setImage:[UIImage imageNamed:@"collect_sel"] forState:UIControlStateSelected];
        customButton.frame = CGRectMake(0, 0, 24, 24);
        [customButton addTarget:self action:@selector(collectButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *collectButton = [[UIBarButtonItem alloc] initWithCustomView:customButton];
        [toolBarItems addObject:collectButton];
        
        NSArray *array = [DBManager searchLikeNewsByUrl:self.collectDict[@"url"]];
        if (array.count) {
            customButton.selected = YES;
        } else {
            customButton.selected = NO;
        }
    }
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0, self.view.frame.size.height - 44.0, self.view.frame.size.width, 44.0)];
    toolBar.tintColor = [UIColor whiteColor];
    toolBar.barTintColor = COLOR_REDDEF;
    toolBar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [toolBar setItems:toolBarItems];
    [self.view addSubview:toolBar];
}


- (void)backButtonClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setFontButtonClicked:(id)sender {
    __weak typeof(self) weakSelf = self;
   [SIAlertView createFourButtonAlertView:nil message:@"请选择字体大小" cancelButton:@"取消" defineButton:@"大" threeButton:@"默认" fourButton:@"小" cancelClicked:nil defineClicked:^(SIAlertView *alertView) {
       [weakSelf.webView setTitleFont:LargeFont];
   } threeClicked:^(SIAlertView *alertView) {
       [weakSelf.webView setTitleFont:MediumFont];
   } fourClicked:^(SIAlertView *alertView) {
       [weakSelf.webView setTitleFont:SmallFont];
   }];
}

- (void)shareButtonClicked:(id)sender {
    //1、创建分享参数
    
    NSString *SMSText;
    NSString *MailText;
    NSURL *url = [self.webView getURL];
    NSString *title = self.collectDict[@"title"];
    NSArray* imageArray = @[[UIImage imageNamed:@"80"]];
    switch (self.shareType) {
        case ShareJingGao:
            SMSText = [NSString stringWithFormat:@"相关公司:%@   分享链接:%@",self.collectDict[@"entityName"], self.url];
            MailText = [NSString stringWithFormat:@"相关公司:%@<br/>分享链接:<<a href=%@>%@</a>>",self.collectDict[@"entityName"], self.url, self.url];
            break;
        case ShareNews:
            SMSText = [NSString stringWithFormat:@"分享链接:%@", self.url];
            MailText = [NSString stringWithFormat:@"分享链接:<<a href=%@>%@</a>>", self.url, self.url];
            break;
            
        default:
            break;
    }
    
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:@""
                                     images:imageArray
                                        url:url
                                      title:title
                                       type:SSDKContentTypeAuto];
    //2、分享（可以弹出我们的分享菜单和编辑界面）
    [shareParams SSDKSetupSMSParamsByText:SMSText title:title images:imageArray attachments:nil recipients:nil type:SSDKContentTypeAuto];
    
    [shareParams SSDKSetupMailParamsByText:MailText title:title images:imageArray attachments:nil recipients:nil ccRecipients:nil bccRecipients:nil type:SSDKContentTypeAuto];
    
    __weak typeof(self) weakSelf = self;
    
    SSUIShareActionSheetController *sheet = [ShareSDK showShareActionSheet:nil
                            items:@[@(SSDKPlatformTypeMail),
                                    @(SSDKPlatformTypeSMS)]
                       shareParams:shareParams
               onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                   
                   switch (state) {
                       case SSDKResponseStateSuccess:{
                           [weakSelf showAlertView:@"分享成功" message:nil];
                           break;
                       }
                       case SSDKResponseStateFail:{
                           if (platformType == SSDKPlatformTypeSMS && [error code] == 201) {
                               [weakSelf showAlertView:@"分享失败" message:@"失败原因可能是：1、短信应用没有设置帐号；2、设备不支持短信应用。"];
                           }
                           else if(platformType == SSDKPlatformTypeMail && [error code] == 201) {
                               [weakSelf showAlertView:@"分享失败" message:@"失败原因可能是：1、邮件应用没有设置帐号；2、设备不支持邮件应用。"];
                           }
                           else {
                               [weakSelf showAlertView:@"分享失败" message:[NSString stringWithFormat:@"%@",error]];
                           }
                           break;
                       }
                       default:
                           break;
                   }
               }
     ];
    //删除和添加平台示例
    [sheet.directSharePlatforms addObject:@(SSDKPlatformTypeSMS)];
    [sheet.directSharePlatforms addObject:@(SSDKPlatformTypeMail)];
}

- (void)showAlertView:(NSString *)title message:(NSString *)message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil, nil];
    [alert show];
}

- (void)collectButtonClicked:(UIButton *)sender {
    if ([HelpManager isVisitor]) {
        return;
    }
    if (sender.isSelected) {
        [self cancelCollect];
    } else {
        [self ensureCollect];
    }
    sender.selected = !sender.isSelected;
}

- (void)cancelCollect{
    NSArray *array = [DBManager searchLikeNewsByUrl:self.collectDict[@"url"]];
    if (array.count) {
        LikeNewsModel *likeNews = array[0];
        [MBProgressHUD showMessage:@"正在取消收藏..."];
        [HttpManager requestDeletedLikeNews:[NSString stringWithFormat:@"%d",likeNews.id] SuccessBlock:^(NSDictionary *returnData) {
            [MBProgressHUD hideHUD];
            if (returnData == nil) {
                return ;
            }
            if ([returnData[kStatus] intValue] == kSuccess ) {
                [likeNews deleteToDB];
                [MBProgressHUD showSuccess:@"取消收藏成功！"];
            }
        } failureBlock:^(NSError *error) {
            [MBProgressHUD hideHUD];
        }];
    }
}

- (void)ensureCollect {
    [MBProgressHUD showMessage:@"正在收藏..."];
    [HttpManager requestAddLikeNews:self.collectDict SuccessBlock:^(NSDictionary *returnData) {
        [MBProgressHUD hideHUD];
        if (returnData == nil) {
            return ;
        }
        if ([returnData[kStatus] intValue] == kSuccess ) {
            NSDictionary *dic = [returnData objectForKey:@"items"];
            if (dic) {
                NSError *error;
                LikeNewsModel *likeNews = [[LikeNewsModel alloc] initWithDictionary:dic error:&error];
                if (!error) {
                    likeNews.publishTime = [likeNews.publishDate getTime];
                    likeNews.createTime = [likeNews.createDate getTime];
                    CGFloat height = [likeNews.title sizeForFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(kSCREEN_WIDTH - 40, 300.0f)].height;
                    likeNews.height = [NSNumber numberWithFloat:height];
                    likeNews.isSeleted = [NSNumber numberWithBool:NO];
                    [DBManager insertLikeNewsWhenNotExists:likeNews];
                    [DBManager insertLikeNewsWhenNotExists:likeNews];
                    [MBProgressHUD showSuccess:@"收藏成功"];
                }
            }
        }
    } failureBlock:^(NSError *error) {
        [MBProgressHUD hideHUD];
    }];
}

#pragma mark - ANWebViewDelegate
- (void)anWebView:(ANWebView *)webview shouldStartLoadWithURL:(NSURL *)URL {
    
}

- (void)anWebView:(ANWebView *)webview didFinishLoadingURL:(NSURL *)URL {
    NSInteger font = [[UserManager getSystemFont] integerValue];
    [self.webView setTitleFont:font];
}

- (void)anWebView:(ANWebView *)webview didFailToLoadURL:(NSURL *)URL error:(NSError *)error {
    
}
@end
