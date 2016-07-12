//
//  FavoriteViewController.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/28.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "FavoriteViewController.h"
#import "UICommon.h"
#import "UtilsHeader.h"
#import "UITableView+Extend.h"
#import "HelpManager.h"
#import "DBManager.h"
#import "NewsTableViewCell.h"
#import "NSString+Extend.h"
#import "UserHandler.h"
#import "WebViewController.h"

@interface FavoriteViewController ()
@property (strong, nonatomic) NSArray *dataSource;
@property (strong, nonatomic) UITableView *tableView;
@property (assign, nonatomic) BOOL type;
@end

static NSString *newsCell = @"NewsCell";

@implementation FavoriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [UICommon setNavBarTitle:self.navigationItem title:@"收藏夹"];
    [self createSubview];
    self.type = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.dataSource = [DBManager searchLikeNews];
    [self.tableView reloadData];
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    [self.mm_drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeNone];
}

- (void)createSubview {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT ) style:UITableViewStylePlain];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = COLOR_BKGROUND;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[NewsTableViewCell class] forCellReuseIdentifier:newsCell];
    __weak typeof(self) weakSelf = self;
    [self.tableView addHeaderRefresh:^{
        [HelpManager loadLikeNews:^(BOOL success) {
            [weakSelf reloadLikeNews];
        }];
    } beginRefreshing:NO];
}

- (void)reloadLikeNews {
    self.dataSource = [DBManager searchLikeNews];
    BOOL isEmptyData = self.dataSource.count ? NO : YES;
    [self.tableView tableViewIsEmptyData:isEmptyData clickedBlock:nil];
    [self.tableView reloadData];
    [self.tableView endHeaderRefresh];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:newsCell forIndexPath:indexPath];
    LikeNewsModel *likeNews = self.dataSource[indexPath.row];
    cell.height = [likeNews.height floatValue];
    cell.isSeleted = [likeNews.isSeleted boolValue];
    cell.titleLabel.text = likeNews.title;
    cell.timeLabel.text = [likeNews.publishDate getTimeStr];
    cell.sourceLabel.text = likeNews.sourceInfo;
    cell.bType =  self.type;
    cell.entityNameLabel.text = [NSString stringWithFormat:@"相关:%@",likeNews.entityName];
    return cell;
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    LikeNewsModel *likeNews = [self.dataSource objectAtIndex:indexPath.row];
    if (self.type) {
        return [likeNews.height floatValue] + 45;
    }
    return [likeNews.height floatValue] + 65;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LikeNewsModel *likeNews = self.dataSource[indexPath.row];
    likeNews.isSeleted = [NSNumber numberWithBool:YES];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
    [self goWebView:likeNews];
}

- (void)goWebView:(LikeNewsModel *)likeNews {
    NSString *docId = likeNews.docId;
    NSString *strUrl ;
    if ( docId != nil && ![docId isEqualToString:@""] && ![docId isEqualToString:@"0"]) {
        strUrl = docId;
    }
    else {
        strUrl = likeNews.url;
    }
    NSString *preUrl = [UserHandler sharedUserHandler].urlType[@"news"];
    if (preUrl == nil || [preUrl isEqualToString:@""]) {
        return;
    }
    strUrl = [preUrl stringByAppendingString:strUrl];
    
    WebViewController *webViewVC = [[WebViewController alloc] initWithURL:strUrl type:WebViewAllTool];
    NSString *userId = [UserHandler sharedUserHandler].loginUser.userId;
    webViewVC.collectDict = @{@"userId":userId,
                              @"title":likeNews.title,
                              @"docId":likeNews.docId,
                              @"url":likeNews.url,
                              @"publishDate":likeNews.publishDate,
                              @"sourceInfo":likeNews.sourceInfo,
                              @"entityName":likeNews.entityName};
    [self.navigationController pushViewController:webViewVC animated:YES];
}



@end
