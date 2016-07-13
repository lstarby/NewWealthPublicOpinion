//
//  PDFViewController.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/7/13.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "PDFViewController.h"
#import "CacheManager.h"
#import "UICommon.h"
#import "MBProgressHUD+Extend.h"

@interface PDFViewController ()<UIWebViewDelegate>

@property (nonatomic, assign) BOOL isHas;
@property (nonatomic, copy  ) NSString *pathToDownload;
@property (nonatomic, strong) UIWebView *webView;

@end

@implementation PDFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createSubview];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)createSubview {

    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width , self.view.frame.size.height - 64)];
    self.webView.backgroundColor = [UIColor whiteColor];
    self.webView.scalesPageToFit = YES;
    self.webView.contentMode = UIViewContentModeScaleToFill;
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    [self.webView loadRequest:[self getRequest]];
}

- (NSURLRequest *)getRequest {
    NSURL *targetURL = [NSURL URLWithString:self.url];
    NSString *docPath = [CacheManager cachesPath];
    self.pathToDownload = [NSString stringWithFormat:@"%@/%@", docPath, [targetURL lastPathComponent]];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    self.isHas = [fileManager fileExistsAtPath:self.pathToDownload];
    if (self.isHas) {
        targetURL = [NSURL fileURLWithPath:self.pathToDownload];
    }
    return [NSURLRequest requestWithURL:targetURL];
}

- (void)saveFile:(NSURL *)ressourcesURL {
    NSString *fileExtension = [ressourcesURL pathExtension];
    fileExtension = [fileExtension lowercaseString];
    if ([fileExtension isEqualToString:@"pdf"] || [fileExtension isEqualToString:@"jpg"]) {

        NSData *tmp = [NSData dataWithContentsOfURL:ressourcesURL];
        if (tmp != nil) {
            NSError *error = nil;

            [tmp writeToFile:self.pathToDownload options:NSDataWritingAtomic error:&error];
            if (error != nil) {
                NSLog(@"缓存失败: %@", [error description]);
            }
        }
    }
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    if (!self.isHas) {
        [self saveFile:request.URL];
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [MBProgressHUD showMessage:@"加载中..." toView:self.view];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [UICommon setNavBarTitle:self.navigationItem title:self.pdfTitle];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

@end
