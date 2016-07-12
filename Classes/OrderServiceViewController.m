//
//  OrderServiceViewController.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/24.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "OrderServiceViewController.h"
#import "UICommon.h"
#import "UtilsHeader.h"
#import "ApplyFoucsViewController.h"

@interface OrderServiceViewController ()
@property (strong, nonatomic) NSArray *dataSource;
@end

static NSString *orderServiceCell = @"orderServiceCell";

@implementation OrderServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    [UICommon setNavBarTitle:self.navigationItem title:@"定制服务"];
    self.dataSource = @[@"申请关注公司", @"申请关注人物"];
    [self createSubview];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    [self.mm_drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeNone];
}

- (void)createSubview {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [[UIView alloc] init];
    tableView.backgroundColor = COLOR_BKGROUND;
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:tableView];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:orderServiceCell];
    tableView.rowHeight = 44;
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:orderServiceCell forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *applyFoucsVC;
    switch (indexPath.row) {
        case 0:
            applyFoucsVC = [[ApplyFoucsViewController alloc] initWithApplyFoucsType:ApplyFoucsCompany];
            break;
        case 1:
            applyFoucsVC = [[ApplyFoucsViewController alloc] initWithApplyFoucsType:ApplyFoucsCharacter];
            break;
        default:
            applyFoucsVC = [[ApplyFoucsViewController alloc] initWithApplyFoucsType:ApplyFoucsCompany];;
            break;
    }
    [self.navigationController pushViewController:applyFoucsVC animated:YES];
}

@end
