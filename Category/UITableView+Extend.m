//
//  UITableView+Extend.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/28.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "UITableView+Extend.h"
#import <objc/runtime.h>
#import <MJRefresh/MJRefresh.h>
#import "UtilsHeader.h"

@interface UITableView ()

@property (nonatomic, strong) UIView *footView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UILabel *titleLabel;

@end

static const char footViewKey;
static const char contentViewKey;
static const char buttonKey;
static const char titlelabelKey;
id (^block)();

#define kFrame CGRectMake(0, 0, kSCREEN_WIDTH, 40)
#define kContentFrame CGRectMake(10, 5, kSCREEN_WIDTH - 20, 30)
#define kOtherFrame CGRectMake(0, 0, kSCREEN_WIDTH - 20, 30)
@implementation UITableView (Extend)

- (UIView *)footView {
    UIView *footView = objc_getAssociatedObject(self, &footViewKey);
    if (!footView) {
        footView = [[UIView alloc] init];
        footView.backgroundColor = [UIColor clearColor];
        [footView addSubview:self.contentView];
        self.tableFooterView = footView;
        objc_setAssociatedObject(self, &footViewKey, footView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return footView;
}

- (void)setFootView:(UIView *)footView {
    objc_setAssociatedObject(self, &footViewKey, footView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)contentView {
    UIView *contentView = objc_getAssociatedObject(self, &contentViewKey);
    if (!contentView) {
        contentView = [[UIView alloc] initWithFrame:kContentFrame];
        contentView.backgroundColor = [UIColor whiteColor];
        contentView.layer.cornerRadius = 4.0f;
        [contentView.layer setBorderColor:COLOR_CELL_BORDER];
        [contentView.layer setBorderWidth:1.0];
        contentView.layer.masksToBounds = YES;
        [contentView addSubview:self.titleLabel];
        [contentView addSubview:self.button];
        objc_setAssociatedObject(self, &contentViewKey, contentView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return contentView;
}

- (void)setContentView:(UIView *)contentView {
    objc_setAssociatedObject(self, &contentViewKey, contentView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIButton *)button {
    UIButton *button = objc_getAssociatedObject(self, &buttonKey);
    if (!button) {
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = kOtherFrame;
        button.backgroundColor = [UIColor clearColor];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        objc_setAssociatedObject(self, &buttonKey, button, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return button;
}

- (void)setButton:(UIButton *)button {
    objc_setAssociatedObject(self, &buttonKey, button, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UILabel *)titleLabel {
    UILabel *titleLabel = objc_getAssociatedObject(self, &buttonKey);
    if (!titleLabel) {
        titleLabel = [[UILabel alloc] initWithFrame:kOtherFrame];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = [UIFont systemFontOfSize:15];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor lightGrayColor];
        titleLabel.text = @"暂无数据";
        objc_setAssociatedObject(self, &titlelabelKey, titleLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return titleLabel;
}

- (ClickedBlock)clickedBlock {
    return objc_getAssociatedObject(self, &block);
}

-(void)setClickedBlock:(ClickedBlock)clickedBlock
{
    if (!self.clickedBlock) {
        objc_setAssociatedObject(self, &block, clickedBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
}


- (void)buttonClicked:(UIButton *)sender {
    if (self.clickedBlock) {
        self.clickedBlock();
    }
}


- (void)tableViewIsEmptyData:(BOOL)isEmptyData clickedBlock:(ClickedBlock)clickedBlock {
    if (isEmptyData) {
        self.footView.frame = kFrame;
        self.footView.hidden = NO;
    } else {
        self.footView.frame = CGRectZero;
        self.footView.hidden = YES;
    }
    self.clickedBlock = clickedBlock;
}

- (void)addHeaderRefresh:(RefreshBlock)refreshBlock beginRefreshing:(BOOL)isRefreshing {
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        refreshBlock();
    }];
    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"松开刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    if (isRefreshing) {
        [header beginRefreshing];
    }
    
    self.mj_header = header;
}

- (void)addFooterRefresh:(RefreshBlock)refreshBlock {
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        refreshBlock();
    }];
    [footer setTitle:@"" forState:MJRefreshStateIdle];
    [footer setTitle:@"松开加载更多数据" forState:MJRefreshStatePulling];
    [footer setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"没有更多数据" forState:MJRefreshStateNoMoreData];
    self.mj_footer = footer;
}

- (void)noMoreData {
    [self.mj_footer endRefreshingWithNoMoreData];
}

- (void)beginHeaderRefresh {
    [self.mj_header beginRefreshing];
}

- (void)beginFooderRefresh {
    [self.mj_footer beginRefreshing];
}


- (void)endHeaderRefresh {
    [self.mj_header endRefreshing];
}

- (void)endFooderRefresh {
    [self.mj_footer endRefreshing];
}

@end
