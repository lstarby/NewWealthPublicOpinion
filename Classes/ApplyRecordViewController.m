//
//  ApplyRecordViewController.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/27.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "ApplyRecordViewController.h"
#import "UICommon.h"
#import "UtilsHeader.h"
#import "HttpManager.h"
#import "MBProgressHUD+Extend.h"
#import "DBManager.h"
#import "ApplyRecordTableViewCell.h"

@interface ApplyRecordViewController ()
//数据

@property (strong, nonatomic) NSArray *applyingData;
@property (strong, nonatomic) NSArray *finishedData;

@property (nonatomic, strong) UITableView *tableView ;

@end

static NSString *applyRecordCell = @"ApplyRecordCell";

@implementation ApplyRecordViewController

- (id)initWithApplyFoucsType:(ApplyFoucsType)applyFoucsType {
    self = [super init];
    if (self) {
        self.applyFoucsType = applyFoucsType;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *title = nil;
    if (self.applyFoucsType == ApplyFoucsCompany) {
        title = @"申请公司记录";
    } else if (self.applyFoucsType == ApplyFoucsCharacter) {
        title = @"申请关注人物";
    }
    [UICommon setNavBarTitle:self.navigationItem title:title];
    [self createSubview];
    [self loadApplyRecordTable];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    __weak typeof(self) weakSelf = self;
    [HttpManager requestApplyRecordAapplyFoucsType:self.applyFoucsType SuccessBlock:^(NSDictionary *returnData) {
        if (returnData == nil) {
            return ;
        }
        if ([returnData[kStatus] intValue] == kSuccess) {
            NSArray*array = [returnData objectForKey:@"items"];
            for (NSDictionary *dict in array) {
                NSError *error = nil;
                ApplyRecordModel *applyRecord = [[ApplyRecordModel alloc] initWithDictionary:dict error:&error];
                if (!error) {
                    [applyRecord saveToDB];
                }
            }
            [weakSelf loadApplyRecordTable];
        } else {
            [MBProgressHUD showError:returnData[kMessage]];
        }
    } failureBlock:nil];
}

- (void)loadApplyRecordTable {
    NSArray *types = @[@"0", @"1"];
    self.applyingData = [DBManager searchApplyRecord:types[self.applyFoucsType] status:0];
    self.finishedData = [DBManager searchApplyRecord:types[self.applyFoucsType] status:1];
    [self.tableView reloadData];
}

- (void)createSubview {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height ) style:UITableViewStylePlain];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = COLOR_BKGROUND;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[ApplyRecordTableViewCell class] forCellReuseIdentifier:applyRecordCell];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ApplyRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:applyRecordCell forIndexPath:indexPath];

    if (indexPath.row == 0 ) {
        cell.titleLabel.text = @"待审核";
        cell.dataSource = self.applyingData;
    } else if (indexPath.row == 1) {
        cell.titleLabel.text = @"审核通过";
        cell.dataSource = self.finishedData;
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    static ApplyRecordTableViewCell *cell = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cell = [[ApplyRecordTableViewCell alloc] init];
    });
    if (indexPath.row == 0 ) {
        cell.dataSource = self.applyingData;
    } else if (indexPath.row == 1) {
        cell.dataSource = self.finishedData;
    }
    return cell.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
