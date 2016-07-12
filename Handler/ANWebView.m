//
//  ANWebView.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/29.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "ANWebView.h"

#define iOS8 [[[UIDevice currentDevice] systemVersion] floatValue]>=8.0
static void *KINWebBrowserContext = &KINWebBrowserContext;

@interface ANWebView ()<UIAlertViewDelegate>

@property (nonatomic, strong) NSTimer *fakeProgressTimer;
@property (nonatomic, assign) BOOL webViewIsLoading;
@property (nonatomic, strong) NSURL *webViewCurrentURL;
@property (nonatomic, strong) NSString *webViewURLString;
@end

@implementation ANWebView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if(iOS8) {
            self.wkWebView = [[WKWebView alloc] init];
        }
        else {
            self.uiWebView = [[UIWebView alloc] init];
        }
        self.backgroundColor = [UIColor clearColor];
        
        if(self.wkWebView) {
            [self.wkWebView setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
            [self.wkWebView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
            [self.wkWebView setNavigationDelegate:self];
            [self.wkWebView setUIDelegate:self];
            [self.wkWebView setMultipleTouchEnabled:YES];
            [self.wkWebView setAutoresizesSubviews:YES];
            [self.wkWebView.scrollView setAlwaysBounceVertical:YES];
            [self addSubview:self.wkWebView];
            self.wkWebView.scrollView.bounces = NO;
            [self.wkWebView addObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress)) options:0 context:KINWebBrowserContext];
        }
        else  {
            [self.uiWebView setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
            [self.uiWebView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
            [self.uiWebView setDelegate:self];
            [self.uiWebView setMultipleTouchEnabled:YES];
            [self.uiWebView setAutoresizesSubviews:YES];
            [self.uiWebView setScalesPageToFit:YES];
            [self.uiWebView.scrollView setAlwaysBounceVertical:YES];
            self.uiWebView.scrollView.bounces = NO;
            [self addSubview:self.uiWebView];
        }
        
        self.progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        [self.progressView setTrackTintColor:[UIColor colorWithWhite:1.0f alpha:0.0f]];
        [self.progressView setFrame:CGRectMake(0, 0, self.frame.size.width, self.progressView.frame.size.height)];
        [self.progressView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin];
        
        //设置进度条颜色
        [self setTintColor:[UIColor colorWithRed:0.100 green:0.433 blue:0.763 alpha:1.000]];
        [self addSubview:self.progressView];
        
    }
    return self;
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    if(webView == self.uiWebView) {
        if ([self.delegate respondsToSelector:@selector(anWebView:didStartLoadWithURL:)]) {
            [self.delegate anWebView:self didStartLoadWithURL:self.uiWebView.request.URL];
        }
    }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if(webView == self.uiWebView) {
        self.webViewCurrentURL = request.URL;
        self.webViewIsLoading = YES;
        
        [self fakeProgressViewStartLoading];
        if ([self.delegate respondsToSelector:@selector(anWebView:shouldStartLoadWithURL:)]) {
            [self.delegate anWebView:self shouldStartLoadWithURL:request.URL];
        }
        return YES;
    }
    return NO;
}


- (void)webViewDidFinishLoad:(UIWebView *)webView {
    if(webView == self.uiWebView) {
        if(!self.uiWebView.isLoading) {
            self.webViewIsLoading = NO;
            [self fakeProgressBarStopLoading];
        }
        if ([self.delegate respondsToSelector:@selector(anWebView:didFinishLoadingURL:)]) {
            [self.delegate anWebView:self didFinishLoadingURL:self.uiWebView.request.URL];
        }
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    if(webView == self.uiWebView) {
        if(!self.uiWebView.isLoading) {
            self.webViewIsLoading = NO;
            [self fakeProgressBarStopLoading];
        }
        if ([self.delegate respondsToSelector:@selector(anWebView:didFailToLoadURL:error:)]) {
        [self.delegate anWebView:self didFailToLoadURL:self.uiWebView.request.URL error:error];
        }
    }
}

#pragma mark - WKNavigationDelegate


- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    if(webView == self.wkWebView) {
        if ([self.delegate respondsToSelector:@selector(anWebView:didStartLoadWithURL:)]) {
            [self.delegate anWebView:self didStartLoadWithURL:self.wkWebView.URL];
        }        
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    if(webView == self.wkWebView) {
        if ([self.delegate respondsToSelector:@selector(anWebView:didFinishLoadingURL:)]) {
            [self.delegate anWebView:self didFinishLoadingURL:self.wkWebView.URL];
        }
    }
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
      withError:(NSError *)error {
    if(webView == self.wkWebView) {
        if ([self.delegate respondsToSelector:@selector(anWebView:didFailToLoadURL:error:)]) {
            [self.delegate anWebView:self didFailToLoadURL:self.wkWebView.URL error:error];
        }
    }
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation
      withError:(NSError *)error {
    if(webView == self.wkWebView) {
        if ([self.delegate respondsToSelector:@selector(anWebView:didFailToLoadURL:error:)]) {
            [self.delegate anWebView:self didFailToLoadURL:self.wkWebView.URL error:error];
        }
    }
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    if(webView == self.wkWebView) {
        
        NSURL *URL = navigationAction.request.URL;
        if(!navigationAction.targetFrame) {
            [self loadURL:URL];
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }
        self.webViewCurrentURL = webView.URL;
        [self callback_webViewShouldStartLoadWithRequest:navigationAction.request navigationType:navigationAction.navigationType];
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (BOOL)callback_webViewShouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(NSInteger)navigationType
{
    if ([self.delegate respondsToSelector:@selector(anWebView:shouldStartLoadWithURL:)]) {
        [self.delegate anWebView:self shouldStartLoadWithURL:request.URL];
    }
    return YES;
}

#pragma mark - WKUIDelegate

- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}

#pragma mark - Estimated Progress KVO (WKWebView)

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))] && object == self.wkWebView) {
        [self.progressView setAlpha:1.0f];
        BOOL animated = self.wkWebView.estimatedProgress > self.progressView.progress;
        [self.progressView setProgress:self.wkWebView.estimatedProgress animated:animated];
        
        __weak typeof(self) weakSelf = self;
        if(self.wkWebView.estimatedProgress >= 1.0f) {
            [UIView animateWithDuration:0.3f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                [weakSelf.progressView setAlpha:0.0f];
            } completion:^(BOOL finished) {
                [weakSelf.progressView setProgress:0.0f animated:NO];
            }];
        }
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - Fake Progress Bar Control (UIWebView)

- (void)fakeProgressViewStartLoading {
    [self.progressView setProgress:0.0f animated:NO];
    [self.progressView setAlpha:1.0f];
    
    if(!self.fakeProgressTimer) {
        self.fakeProgressTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f/60.0f target:self selector:@selector(fakeProgressTimerDidFire:) userInfo:nil repeats:YES];
    }
}

- (void)fakeProgressBarStopLoading {
    if(self.fakeProgressTimer) {
        [self.fakeProgressTimer invalidate];
    }
    __weak typeof(self) weakSelf = self;
    if(self.progressView) {
        [self.progressView setProgress:1.0f animated:YES];
        [UIView animateWithDuration:0.3f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
            [weakSelf.progressView setAlpha:0.0f];
        } completion:^(BOOL finished) {
            [weakSelf.progressView setProgress:0.0f animated:NO];
        }];
    }
}

- (void)fakeProgressTimerDidFire:(id)sender {
    CGFloat increment = 0.005/(self.progressView.progress + 0.2);
    if([self.uiWebView isLoading]) {
        CGFloat progress = (self.progressView.progress < 0.75f) ? self.progressView.progress + increment : self.progressView.progress + 0.0005;
        if(self.progressView.progress < 0.95) {
            [self.progressView setProgress:progress animated:YES];
        }
    }
}


#pragma mark - Public Interface
- (void)loadRequest:(NSURLRequest *)request {
    if(self.wkWebView) {
        [self.wkWebView loadRequest:request];
    }
    else  {
        [self.uiWebView loadRequest:request];
    }
}

- (void)loadURL:(NSURL *)URL {
    NSURL *lastURl = [self cleanURL:URL];
    [self loadRequest:[NSURLRequest requestWithURL:lastURl]];
}

- (void)loadURLString:(NSString *)URLString {
    NSURL *URL = [NSURL URLWithString:URLString];
    [self loadURL:URL];
}

- (void)loadHTMLString:(NSString *)HTMLString {
    if(self.wkWebView) {
        [self.wkWebView loadHTMLString:HTMLString baseURL:nil];
    }
    else if(self.uiWebView) {
        [self.uiWebView loadHTMLString:HTMLString baseURL:nil];
    }
}

- (NSURL *)cleanURL:(NSURL *)url {
    //If no URL scheme was supplied, defer back to HTTP.
    if (url.scheme.length == 0) {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@", [url absoluteString]]];
    }
    return url;
}

- (NSString *)getURLString {
    NSString *URLString = [self.webViewCurrentURL absoluteString];
    if ([self.webViewCurrentURL scheme].length) {
        URLString = [URLString substringFromIndex:[self.webViewCurrentURL scheme].length + 3];
    }
    return URLString;
}

- (NSURL *)getURL {
    return self.webViewCurrentURL;
}

- (NSString *)getWebViewTitle{
    NSString *title;
    if(self.wkWebView) {
        title = self.wkWebView.title;
    }
    else if(self.uiWebView) {
        title = [self.uiWebView stringByEvaluatingJavaScriptFromString:@"document.title"];
    }
    return title;
}

#pragma mark - setFont
- (void)setTitleFont:(FontType)fontType {
    NSString *string = nil;
    switch (fontType) {
        case SmallFont:
            string = @"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust='80%'";
            break;
        case MediumFont:
            string = @"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust='100%'";
            break;
        case LargeFont:
            string = @"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust='120%'";
            break;
        default:
            break;
    }
    if (self.uiWebView) {
        [self.uiWebView stringByEvaluatingJavaScriptFromString:string];
    } else if (self.wkWebView) {
        [self.wkWebView evaluateJavaScript:string completionHandler:nil];
    }
}

#pragma mark - out
- (void)goBack {
    if(self.wkWebView) {
        [self.wkWebView goBack];
    }
    else if(self.uiWebView) {
        [self.uiWebView goBack];
    }
}

- (void)goForward {
    if(self.wkWebView) {
        [self.wkWebView goForward];
    }
    else if(self.uiWebView) {
        [self.uiWebView goForward];
    }
}

- (void)refresh {
    if(self.wkWebView) {
        [self.wkWebView stopLoading];
        [self.wkWebView reload];
    }
    else if(self.uiWebView) {
        [self.uiWebView stopLoading];
        [self.uiWebView reload];
    }
}

- (void)stopLoading {
    if(self.wkWebView) {
        [self.wkWebView stopLoading];
    }
    else if(self.uiWebView) {
        [self.uiWebView stopLoading];
    }
}



#pragma mark - Dealloc

- (void)dealloc {
    self.uiWebView.delegate = nil;
    self.wkWebView.navigationDelegate = nil;
    self.wkWebView.UIDelegate = nil;
    [self.wkWebView removeObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
}

@end
