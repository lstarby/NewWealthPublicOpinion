//
//  UserCenterViewController.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/21.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "UserCenterViewController.h"
#import "UtilsHeader.h"
#import "UserCenterModel.h"
#import "UserCenterTableViewCell.h"
#import "UserCenterHeadTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UserHandler.h"
#import "UserInfoViewController.h"
#import "OrderServiceViewController.h"
#import "FavoriteViewController.h"

@interface UserCenterViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;

@end

static NSString *userCenterHeadCell = @"userCenterHeadCell";
static NSString *userCenterCell     = @"userCenterCell";

@implementation UserCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_USER_BKGROUND;
    self.dataSource = [UserCenterModel getUserSource];
    [self createSubView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)createSubView {
    UIImageView *bgImageView = [[UIImageView alloc] init];
    bgImageView.frame = CGRectMake(0, 0, kSCREEN_WIDTH, 144);
    bgImageView.image = [UIImage imageNamed:@"mybaseBk"];
    [self.view addSubview:bgImageView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UserCenterHeadTableViewCell class] forCellReuseIdentifier:userCenterHeadCell];
    [self.tableView registerClass:[UserCenterTableViewCell class] forCellReuseIdentifier:userCenterCell];
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 50)];
    [headView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    self.tableView.tableHeaderView = headView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        UserCenterHeadTableViewCell *headCell = [tableView dequeueReusableCellWithIdentifier:userCenterHeadCell forIndexPath:indexPath];
        LoginUser *loginUser = [UserHandler sharedUserHandler].loginUser;
        NSString *headImage = loginUser.photo
        ;
        if (headImage != nil && ![headImage isEqualToString:@""]) {
            [headCell.iconImageView sd_setImageWithURL:[NSURL URLWithString:headImage] placeholderImage:[UIImage imageNamed:@"example"]];
        }
        headCell.titleLabel.text = loginUser.name;
        headCell.userNameLabel.text = loginUser.username;
        return headCell;
    }
    else {
        UserCenterTableViewCell *userCell = [tableView dequeueReusableCellWithIdentifier:userCenterCell forIndexPath:indexPath];
        UserCenterModel *userCenterModel = self.dataSource[indexPath.row - 1];
        userCell.iconImageView.image = [UIImage imageNamed:userCenterModel.userImg];
        userCell.titleLabel.text = userCenterModel.userInfo;
        return userCell;
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 90;
    }
    return 48;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *pushVC;
    switch (indexPath.row) {
        case 1:
            pushVC = [[UserInfoViewController alloc] init];
            break;
        case 2:
            pushVC = [[OrderServiceViewController alloc] init];
            break;
        case 3:
            pushVC = [[FavoriteViewController alloc] init];
            break;
        default:
            pushVC = [[UserInfoViewController alloc] init];
            break;
    }
    [(UINavigationController *)self.mm_drawerController.centerViewController pushViewController:pushVC animated:YES];
    [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
