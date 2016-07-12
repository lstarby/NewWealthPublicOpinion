//
//  ANWebView.h
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/29.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

typedef NS_ENUM(NSInteger, FontType ) {
    SmallFont = 0,      //小
    MediumFont,         //中
    LargeFont           //大
};

@class ANWebView;
@protocol ANWebViewDelegate <NSObject>
@optional
- (void)anWebView:(ANWebView *)webview didFinishLoadingURL:(NSURL *)URL;
- (void)anWebView:(ANWebView *)webview didFailToLoadURL:(NSURL *)URL error:(NSError *)error;
- (void)anWebView:(ANWebView *)webview shouldStartLoadWithURL:(NSURL *)URL;
- (void)anWebView:(ANWebView *)webview didStartLoadWithURL:(NSURL *)URL;

@end

@interface ANWebView : UIView<WKNavigationDelegate, WKUIDelegate, UIWebViewDelegate>

@property (nonatomic, weak) id <ANWebViewDelegate> delegate;

@property (nonatomic, strong) UIProgressView *progressView;

// The web views
@property (nonatomic, strong) WKWebView *wkWebView;
@property (nonatomic, strong) UIWebView *uiWebView;


//Initializers
- (instancetype)initWithFrame:(CGRect)frame;

// Load a NSURLURLRequest to web view
- (void)loadRequest:(NSURLRequest *)request;

// Load a NSURL to web view
- (void)loadURL:(NSURL *)URL;

// Loads a URL as NSString to web view
- (void)loadURLString:(NSString *)URLString;

// Loads an string containing HTML to web view
- (void)loadHTMLString:(NSString *)HTMLString;

//set font
- (void)setTitleFont:(FontType)fontType;

//get URL(NSString)
- (NSString *)getURLString;

//get URL(NSURL)
- (NSURL *)getURL;

//get title
- (NSString *)getWebViewTitle;

#pragma mark - web
- (void)goBack;
- (void)goForward;
- (void)refresh;
- (void)stopLoading;

@end
