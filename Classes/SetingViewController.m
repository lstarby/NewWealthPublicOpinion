//
//  SetingViewController.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/7/12.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "SetingViewController.h"
#import "UICommon.h"
#import "UtilsHeader.h"
#import "DownSheet.h"
#import "HttpManager.h"
#import "MBProgressHUD+Extend.h"
#import "HelpManager.h"
#import "LoginViewController.h"
#import "BaseNavigationController.h"
#import "SetingTableViewCell.h"

@interface SetingViewController ()<UITableViewDelegate, UITableViewDataSource,
    DownSheetDelegate>

@property (strong, nonatomic) NSArray *dataSource;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) DownSheet *sheet;

@end

static NSString *setingCell = @"SetingTableViewCell";

@implementation SetingViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [UICommon setNavBarTitle:self.navigationItem title:@"设置"];
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
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = COLOR_BKGROUND;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[SetingTableViewCell class] forCellReuseIdentifier:setingCell];
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
    footerView.backgroundColor = COLOR_BKGROUND;
    self.tableView.tableFooterView = footerView;
    
    UIButton *logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [logoutButton setTitle:@"退出账号" forState:UIControlStateNormal];
    [logoutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [logoutButton setBackgroundColor:COLOR_REDDEF];
    [logoutButton addTarget:self action:@selector(logOutClicked) forControlEvents:UIControlEventTouchUpInside];
    logoutButton.frame = CGRectMake(10, 10, self.view.frame.size.width-20, 40);
    [logoutButton.layer setCornerRadius:4.0f];
    [footerView  addSubview:logoutButton];
}

- (void)logOutClicked {
    NSMutableArray *menuList = [NSMutableArray array];
    
    UIButton *logoutButton=  [UIButton buttonWithType:UIButtonTypeCustom];
    
    [logoutButton setBackgroundImage:[UIImage imageNamed:@"sheet_del_normal"] forState:UIControlStateNormal];
    [logoutButton setBackgroundImage:[UIImage imageNamed:@"sheet_del_sel"] forState:UIControlStateHighlighted];
    [logoutButton.layer setCornerRadius:4.0f];
    [logoutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [logoutButton setTitle:@"确定退出" forState:UIControlStateNormal];
    [logoutButton addTarget:self action:@selector(logoutAction) forControlEvents:UIControlEventTouchUpInside];
    [menuList addObject:logoutButton];
    
    UIButton *cancelButton=  [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setBackgroundImage:[UIImage imageNamed:@"sheet_cancel_normal"] forState:UIControlStateNormal];
    [cancelButton setBackgroundImage:[UIImage imageNamed:@"sheet_cancel_normal_sel"] forState:UIControlStateHighlighted];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelButton.layer setCornerRadius:4.0f];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [menuList addObject:cancelButton];
    
    self.sheet = [[DownSheet alloc]initWithlist:menuList height:150];
    self.sheet.delegate = self;
    [self.sheet showInView:nil];
}

- (void)logoutAction {
    __weak typeof(self) weakSelf = self;
    [HttpManager requestLogoutSuccessBlock:^(NSDictionary *returnData) {
        if (returnData == nil) {
            [MBProgressHUD showError:@"退出失败，请检查网络"];
            return ;
        }
        [weakSelf.sheet tappedCancel];
        if ([returnData[kStatus] intValue] == kSuccess) {
            [HelpManager userLogOut];
            LoginViewController *loginVC = [[LoginViewController alloc] init];
            BaseNavigationController *baseNav = [[BaseNavigationController alloc] initWithRootViewController:loginVC];
            [UIApplication sharedApplication].keyWindow.rootViewController = baseNav;
        }
    } failureBlock:^(NSError *error) {
        [MBProgressHUD showError:@"退出失败"];
    }];
}

- (void)cancelAction {
    [self.sheet tappedCancel];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    } else if (section == 1) {
        return 4;
    } else if (section == 2) {
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
