//
//  OtherNewsViewController.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/7/4.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "OtherNewsViewController.h"
#import "UITableView+Extend.h"
#import "HttpManager.h"
#import "InfoModel.h"
#import "OtherNewsTableViewCell.h"
#import <DBImageView/DBImageView.h>
#import "NSString+Extend.h"
#import "UtilsHeader.h"

@interface OtherNewsViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) int currentPage;
@property (strong, nonatomic) NSMutableArray    *dataSource;
@property (strong, nonatomic) UITableView       *tableView;

@end

static NSString *otherNewsCell   = @"OtherNewsTableViewCell";

@implementation OtherNewsViewController

- (id)init {
    self = [super init];
    if (self) {
        [self createSubView];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setUserChannel:(UserChannel *)userChannel {
    _userChannel = userChannel;
    self.dataSource = [NSMutableArray array];
    self.currentPage = 1;
}

- (void)createSubView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT) style:UITableViewStylePlain];
    self.tableView.backgroundColor = COLOR_BKGROUND;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[OtherNewsTableViewCell class] forCellReuseIdentifier:otherNewsCell];
    
    __weak typeof(self) weakSelf = self;
    [self.tableView addHeaderRefresh:^{
        weakSelf.currentPage = 1;
        [weakSelf.dataSource removeAllObjects];
        [weakSelf requestInformation];
        
    } beginRefreshing:NO];
    [self.tableView addFooterRefresh:^{
        weakSelf.currentPage++;
        [weakSelf requestInformation];
    }];
    
}

- (void)requestInformation {
    __weak typeof(self) weakSelf = self;
    if ([self.userChannel.type isEqualToString:@"default"]) {
        [HttpManager requestDefaultInformation:self.currentPage type:self.userChannel.inforType SuccessBlock:^(NSDictionary *returnData) {
            if (returnData == nil) {
                return ;
            }
            if ([returnData[kStatus] intValue] == kSuccess) {
                NSError* error = nil;
                NSArray *array = [returnData objectForKey:@"items"];
                for (NSDictionary *dict in array)
                {
                    InfoModel *info = [[InfoModel alloc] initWithDictionary:dict error:&error];
                    if (error == nil) {
                        if (weakSelf.currentPage > 1) {
                            InfoModel *oldInfo = [self.dataSource lastObject];
                            if (![oldInfo.url isEqualToString:info.url]) {
                                [weakSelf.dataSource addObject:info];
                            }
                        } else {
                            [weakSelf.dataSource addObject:info];
                        }
                    }
                }
            }
            [weakSelf reload];
            
        } failureBlock:^(NSError *error) {
            [weakSelf reload];
        }];
    } else {
        [HttpManager requestCustomInformation:self.currentPage itemId:self.userChannel.itemId  SuccessBlock:^(NSDictionary *returnData) {
            if (returnData == nil) {
                return ;
            }
            if ([returnData[kStatus] intValue] == kSuccess) {
                NSError* error = nil;
                NSArray *array = [returnData objectForKey:@"items"];
                for (NSDictionary *dict in array)
                {
                    InfoModel *info = [[InfoModel alloc] initWithDictionary:dict error:&error];
                    if (error == nil) {
                        if (weakSelf.currentPage > 1) {
                            InfoModel *oldInfo = [self.dataSource lastObject];
                            if (![oldInfo.url isEqualToString:info.url]) {
                                [weakSelf.dataSource addObject:info];
                            }
                        } else {
                            [weakSelf.dataSource addObject:info];
                        }                    }
                }
            }
            [weakSelf reload];
            
        } failureBlock:^(NSError *error) {
            [weakSelf reload];
        }];
    }
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView beginHeaderRefresh];
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    [self.mm_drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeNone];
}

- (void)viewDidDisappear:(BOOL)animated {
    [HttpManager cancelAllNetWorking];
}


- (void)reload {
    BOOL isEmptyData = self.dataSource.count ? NO : YES;
    [self.tableView tableViewIsEmptyData:isEmptyData clickedBlock:nil];
    [self.tableView reloadData];
    [self.tableView endHeaderRefresh];
    [self.tableView endFooderRefresh];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OtherNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:otherNewsCell forIndexPath:indexPath];
    InfoModel *info = self.dataSource[indexPath.row];
    cell.titleLabel.text = info.title;
    if ([info.summary isEqualToString:@""]) {
        cell.detailLabel.text = info.content;
    }else {
        cell.detailLabel.text = info.summary;
    }
    cell.sourceLabel.text = info.source;
    cell.timeLabel.text = [info.publishedAt getTimeStr];
    return cell;
}



#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


#pragma mark - VTMagicReuseProtocol
- (void)vtm_prepareForReuse
{
    self.currentPage = 1;
    [self.dataSource removeAllObjects];
    [self.tableView reloadData];
    
}

@end
