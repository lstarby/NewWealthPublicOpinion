//
//  PushNoticeViewController.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/7/12.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "PushNoticeViewController.h"
#import "UICommon.h"
#import "PushNoticeModel.h"
#import "PushNoticeTableViewCell.h"
#import "HelpManager.h"
#import "HttpManager.h"
#import "UserHandler.h"
#import "UserManager.h"
#import "MBProgressHUD+Extend.h"

@interface PushNoticeViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)  UITableView *tableView;
@property (strong, nonatomic) UISwitch *pushSwitch;
@property (strong, nonatomic) NSArray* dataSource;
@property (nonatomic, assign) int newflag;

@end

static NSString *pushNoticeCell = @"PushNoticeTableViewCell";

@implementation PushNoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [UICommon setNavBarTitle:self.navigationItem title:@"通知"];
    
    self.dataSource = [PushNoticeModel getDataSource];
    
    [self createSubview];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    [self.mm_drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeNone];
}

- (void)createSubview {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT ) style:UITableViewStylePlain];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 44;
    self.tableView.scrollEnabled = NO;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[PushNoticeTableViewCell class] forCellReuseIdentifier:pushNoticeCell];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PushNoticeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:pushNoticeCell forIndexPath:indexPath];
    PushNoticeModel *pushNotice = self.dataSource[indexPath.row];
    cell.titleLabel.text = pushNotice.titleName;
    cell.pushSwitch.on = pushNotice.isOnflag;
    cell.pushID = pushNotice.pushID;
    __weak typeof(self) weakSelf = self;
    [cell switchChange:^(NSString *pushID, BOOL isPush) {
        [weakSelf push:pushID isPush:isPush];
    }];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)push:(NSString *)pushID isPush:(BOOL)isPush {
    if ([pushID isEqualToString:@"0"]) {
        if ([HelpManager isVisitor]) {
            
        } else {
            [HttpManager requestPush:isPush SuccessBlock:^(NSDictionary *returnData) {
                if (returnData != nil) {
                    if ([returnData[kStatus] integerValue] == kSuccess) {
                        DLog(@"设置成功");
                        NSDictionary *dic = [returnData objectForKey:@"items"];
                        NSString * isPush = [dic objectForKey:@"isPush"];
                        [UserHandler sharedUserHandler].loginUser.isPush = [isPush boolValue];
                        [UserManager saveUserInfo:[UserHandler sharedUserHandler].loginUser];
                        return ;
                    }
                }
                [MBProgressHUD showError:@"操作失败"];
                [self.tableView reloadData];
            } failureBlock:^(NSError *error) {
                [MBProgressHUD showError:@"操作失败"];
                [self.tableView reloadData];
            }];
        }
    }
    else {
        [HttpManager requestOtherPush:pushID isPush:isPush SuccessBlock:^(NSDictionary *returnData) {
            if (returnData != nil) {
                if ([returnData[kStatus] integerValue] == kSuccess) {
                    NSDictionary* dic = [returnData objectForKey:@"items"];
                    [UserHandler sharedUserHandler].loginUser.isPushWarning = [dic [@"isPushWarning"] boolValue];
                    [UserHandler sharedUserHandler].loginUser.isPushReport = [dic [@"isPushReport"] boolValue];
                    [UserHandler sharedUserHandler].loginUser.isPushInformation = [dic [@"isPushInformation"] boolValue];
                     [UserManager saveUserInfo:[UserHandler sharedUserHandler].loginUser];
                    DLog(@"设置成功");
                    return ;
                }
            }
            [MBProgressHUD showError:@"操作失败"];
            [self.tableView reloadData];
        } failureBlock:^(NSError *error) {
            [MBProgressHUD showError:@"操作失败"];
            [self.tableView reloadData];
        }];
    }
}

@end
