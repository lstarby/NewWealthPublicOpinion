//
//  UITableView+Extend.h
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/28.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ClickedBlock)();

typedef void (^RefreshBlock)();

@interface UITableView (Extend)

@property (nonatomic, copy) ClickedBlock clickedBlock;

/**
 *  显示表尾暂无数据
 *
 *  @param isEmptyData  是否有数据
 *  @param clickedBlock 点击会调
 */
- (void)tableViewIsEmptyData:(BOOL)isEmptyData clickedBlock:(ClickedBlock)clickedBlock;

/**
 *  添加下拉刷新
 *
 *  @param refreshBlock refreshBlock description
 *  @param isRefreshing 是否刷新
 */
- (void)addHeaderRefresh:(RefreshBlock)refreshBlock beginRefreshing:(BOOL)isRefreshing;


/**
 *  添加上拉刷新
 *
 *  @param refreshBlock refreshBlock description
 */
- (void)addFooterRefresh:(RefreshBlock)refreshBlock;

/**
 *  加载完数据了
 */
- (void)noMoreData;

- (void)beginHeaderRefresh;
- (void)beginFooderRefresh;

- (void)endHeaderRefresh;
- (void)endFooderRefresh;

@end
