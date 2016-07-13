//
//  SetingFontViewController.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/7/12.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "SetingFontViewController.h"
#import "UICommon.h"
#import "SetingFontTableViewCell.h"
#import "UserManager.h"


@interface SetingFontViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate>

@property (strong, nonatomic) NSArray     *dataSource;
@property (strong, nonatomic) UITableView *tableView;

@end

static NSString *setingFontCell = @"SetingFontTableViewCell";

@implementation SetingFontViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [UICommon setNavBarTitle:self.navigationItem title:@"新闻详情页面字体"];
    
    [self.view addSubview:self.tableView];
    
    self.dataSource = @[@"小", @"默认", @"大"];
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
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[SetingFontTableViewCell class] forCellReuseIdentifier:setingFontCell];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SetingFontTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:setingFontCell forIndexPath:indexPath];
    cell.titleLabel.text = self.dataSource[indexPath.row];
    if (indexPath.row == [[UserManager getSystemFont] intValue]) {
        cell.selectImageView.image = [UIImage imageNamed:@"check_system"];
    } else {
        cell.selectImageView.image = [UIImage imageNamed:@"check_sel_system"];
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *font = [NSString stringWithFormat:@"%ld",indexPath.row];
    [UserManager SaveSystemFont:font];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
