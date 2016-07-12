//
//  DBManager.h
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/13.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PublicSenModel.h"
#import "GroupBaseInfo.h"
#import "AddFoucsModel.h"
#import "ConsulationModel.h"
#import "NewsModel.h"
#import "AddAttentionModel.h"
#import "DefCompanyModel.h"
#import "DefGroupModel.h"
#import "MyGroupModel.h"
#import "PersonModel.h"
#import "StockPriceModel.h"
#import "EntityNewsModel.h"
#import "LikeNewsModel.h"
#import "PublicNoticeModel.h"
#import "MenuModel.h"
#import "PublicNoticeEntityModel.h"
#import "ResearchEntityModel.h"
#import "ResearchModel.h"
#import "ApplyRecordModel.h"

typedef void (^SearchBlock)(NSMutableArray *resutAray);

@interface DBManager : NSObject

+ (void)clearDB;

+ (void)deleteDB;

+ (void)initAllTbale;

+ (void)initAddAttentionDB;
+ (void)initNewsDB;
+ (void)initLikeNewsDB;
+ (void)initStockDB;
+ (void)initEntityNewsDB;
+ (void)initPublicNoticeDB;
+ (void)initMenuDB;
+ (void)initPublicEntityNoticeDB;
+ (void)initResearchDB;
+ (void)initResearchEntityDB;

+ (void)insertLikeNewsWhenNotExists:(LikeNewsModel*)likeNewsModel;
+ (void)insertMenuWhenNotExists:(MenuModel *)menuModel;
+ (void)insertAddAttentionWhenNotExists:(AddAttentionModel *)attentionModel;



+ (void)clearAllPermission;


+ (void)updateMenuTable:(NSString *)permission;


+ (BOOL)searchMenuByWhere:(NSString *)where;
+ (NSArray *)searchApplyRecord:(NSString *)type status:(int) status;
+ (NSArray *)searchLikeNews;
+ (NSArray *)searchLikeNewsByUrl:(NSString *)urlString;

@end
