//
//  DBManager.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/13.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "DBManager.h"

@implementation DBManager

/**
 *  删除列表
 */
+ (void)clearDB {
    LKDBHelper* dbHelper = [LKDBHelper getUsingLKDBHelper];
    [dbHelper dropAllTable];
}

/**
 *  根据Class创建表
 *
 *  @param modelClass 类名
 */
+ (void)createTableWithClass:(Class)modelClass {
    LKDBHelper* dbHelper = [LKDBHelper getUsingLKDBHelper];
    BOOL isTable = [dbHelper createTableWithModelClass:modelClass];
    if (isTable) {
        DLog(@"创建%@表格成功",[modelClass getTableName]);
    }
    else {
        DLog(@"创建%@表格失败",[modelClass getTableName]);
    }
}

/**
 *  异步插入不存在的数据
 *
 *  @param object 插入对象
 */
+ (void)asynInsertObjectWhenNotExists:(id)object {
    LKDBHelper* dbHelper = [LKDBHelper getUsingLKDBHelper];
    [dbHelper insertWhenNotExists:object callback:^(BOOL result) {
        if (result) {
            DLog(@"插入数据成功");
        }
        else {
            DLog(@"插入数据失败");
        }
    }];
}

/**
 *  同步插入不存在的数据
 *
 *  @param object 插入对象
 */
+ (void)synInsertObjectWhenNotExists:(id)object {
    LKDBHelper* dbHelper = [LKDBHelper getUsingLKDBHelper];
    BOOL success = [dbHelper insertWhenNotExists:object];
    if (success) {
        DLog(@"插入数据成功");
    }
    else {
        DLog(@"插入数据失败");
    }
}

/**
 *  修改
 *
 *  @param object 修改对象
 *  @param where  哪里
 */
+ (void)updateTable:(id)object where:(NSString *)where {
    LKDBHelper* dbHelper = [LKDBHelper getUsingLKDBHelper];
//    BOOL success = [dbHelper updateToDB:object where:where];
//    if (success) {
//        DLog(@"修改数据成功");
//    }
//    else {
//        DLog(@"修改数据失败");
//    }
    [dbHelper updateToDB:object where:where callback:^(BOOL result) {
        if (result) {
            DLog(@"修改数据成功");
        }
        else {
            DLog(@"修改数据失败");
        }
    }];
}

/**
 *  异步查询
 *
 *  @param modelClass Class
 *  @param where      where
 *  @param count      个数
 *  @param block      返回的block
 */
+ (void)searchTable:(Class)modelClass where:(NSString *)where count:(int)count callback:(SearchBlock)block{
    LKDBHelper* dbHelper = [LKDBHelper getUsingLKDBHelper];
    [dbHelper search:modelClass where:where orderBy:nil offset:0 count:count callback:block];
}

/**
 *  同步搜索
 *
 *  @param modelClass modelClass description
 *  @param where      where description
 *  @param orderBy    orderBy description
 *  @param count      count description
 *
 *  @return return value description
 */
+ (NSArray *)searchTable:(Class)modelClass where:(NSString *)where orderBy:(NSString *)orderBy count:(int)count {
    LKDBHelper* dbHelper = [LKDBHelper getUsingLKDBHelper];
    NSArray *array = [dbHelper search:modelClass where:where orderBy:orderBy offset:0 count:count];
    return array;
}

/**
 *  删除数据
 *
 *  @param modelClass modelClass
 *  @param where      where
 */
+ (void)deleteTable:(Class)modelClass where:(NSString *)where {
     LKDBHelper* dbHelper = [LKDBHelper getUsingLKDBHelper];
    [dbHelper deleteWithClass:modelClass where:where callback:^(BOOL result) {
        if (result) {
            DLog(@"删除数据成功");
        } else {
            DLog(@"删除数据失败");
        }
    }];
}

/**
 *  重建表
 */
+ (void)deleteDB { 
    [DBManager clearDB];
    [DBManager initAllTbale];
}

+ (void)initAllTbale {
    [self initAddAttentionDB];
    [self initNewsDB];
    [self initLikeNewsDB];
    [self initStockDB];
    [self initEntityNewsDB];
    [self initPublicNoticeDB];
    [self initMenuDB];
    [self initPublicEntityNoticeDB];
    [self initResearchDB];
    [self initResearchEntityDB];
}

#pragma mark - 初始化

//初始化已被关注AddAttentiontable
+ (void)initAddAttentionDB {
    [self createTableWithClass:[AddAttentionModel class]];
}

//初始化新闻Newstable
+ (void)initNewsDB {
    [self createTableWithClass:[NewsModel class]];
}

//初始化新闻收藏LikeNewstable
+ (void)initLikeNewsDB {
    [self createTableWithClass:[LikeNewsModel class]];
}

//初始化股价StockPricetable
+ (void)initStockDB {
    [self createTableWithClass:[StockPriceModel class]];
}

//初始化新闻实体EntityNewstable
+ (void)initEntityNewsDB {
    [self createTableWithClass:[EntityNewsModel class]];
}

//初始化公告PublicNoticetable
+ (void)initPublicNoticeDB {
    [self createTableWithClass:[PublicNoticeModel class]];
}

//初始化菜单管理Menutable
+ (void)initMenuDB {
    [self createTableWithClass:[MenuModel class]];
}

//初始化公告实体PublicNoticeEntitytable
+ (void)initPublicEntityNoticeDB {
    [self createTableWithClass:[PublicNoticeEntityModel class]];
}

//初始化研报Researchtable
+ (void)initResearchDB {
    [self createTableWithClass:[ResearchModel class]];
}

//初始化研报实体ResearchEntitytable
+ (void)initResearchEntityDB {
    [self createTableWithClass:[ResearchEntityModel class]];
}

#pragma mark - 插入

//插入收藏新闻信息
+ (void)insertLikeNewsWhenNotExists:(LikeNewsModel*)likeNewsModel {
    [self synInsertObjectWhenNotExists:likeNewsModel];
}

//插入菜单权限
+ (void)insertMenuWhenNotExists:(MenuModel *)menuModel {
    [self asynInsertObjectWhenNotExists:menuModel];
}

//插入舆情关注
+ (void)insertAddAttentionWhenNotExists:(AddAttentionModel *)attentionModel {
    [self asynInsertObjectWhenNotExists:attentionModel];
}

#pragma mark - 修改

//清除用户权限
+ (void)clearAllPermission {
    NSArray *resutAray = [self searchTable:[MenuModel class] where:@"itemOwen=1" orderBy:nil count:1000];
    for (MenuModel * menu in resutAray) {
        menu.itemOwen = 0;
        [menu updateToDB];
    }
}

//更新用户权限
+ (void)updateMenuTable:(NSString *)permission {
    NSArray *array = [permission componentsSeparatedByString:@","];
    for (NSString *itemId in array) {
        NSString *where = [NSString stringWithFormat:@"itemId=%@", itemId];
        NSArray *resutAray = [self searchTable:[MenuModel class] where:where orderBy:nil count:1];
        if (resutAray.count) {
            MenuModel * menu = resutAray[0];
            menu.itemOwen = 1;
            //[self updateTable:menu where:where];
            [menu updateToDB];
        }
    }
}


#pragma mark - 查询
//查询是否有权限
+ (BOOL)searchMenuByWhere:(NSString *)where {
    NSArray *array = [self searchTable:[MenuModel class] where:where orderBy:nil count:1];
    if (array.count) {
        return YES;
    }
    return NO;
}

//查询定制记录
+ (NSArray *)searchApplyRecord:(NSString *)type status:(int) status{
    NSString *where = [NSString stringWithFormat:@"type=%@ and status=%d",type,status];
    NSString * orderBy = @"time";
    return [self searchTable:[ApplyRecordModel class] where:where orderBy:orderBy count:10000];
}

//查询收藏新闻
+ (NSArray *)searchLikeNews {
    NSString * orderBy = @"createTime desc";
    return [self searchTable:[LikeNewsModel class] where:nil orderBy:orderBy count:10000];
}

//根据url查询收藏
+ (NSArray *)searchLikeNewsByUrl:(NSString *)urlString {
    NSString *orderBy = @"publishTime asc";
    NSString *where = [NSString stringWithFormat:@"url='%@'",urlString];
    return [self searchTable:[LikeNewsModel class] where:where orderBy:orderBy count:1000];
}

#pragma mark - 删除


@end
