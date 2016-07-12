//
//  WebViewController.h
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/29.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "BaseViewController.h"
#import "TypeHeader.h"

@interface WebViewController : BaseViewController

@property (nonatomic, strong) NSString    *url;
@property (nonatomic, assign) WebViewType webViewType;

@property (nonatomic, assign) ShareType shareType;

@property (nonatomic, strong) NSDictionary *collectDict;

- (id)initWithURL:(NSString *)url type:(WebViewType)webViewType;

@end
