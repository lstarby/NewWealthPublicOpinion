//
//  UserCenterModel.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/23.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "UserCenterModel.h"

@implementation UserCenterModel

- (id)initWithUserInfo:(NSString *)userInfo userImg:(NSString *)userImg {
    self = [super init];
    if (self) {
        self.userInfo = userInfo;
        self.userImg = userImg;
    }
    return self;
}

+ (id)initWithUserInfo:(NSString *)userInfo userImg:(NSString *)userImg {
    return [[self alloc] initWithUserInfo:userInfo userImg:userImg];
}


+ (NSArray *)getUserSource {
    NSMutableArray *dataSource = [NSMutableArray array];
    [dataSource addObject:[self initWithUserInfo:@"用户信息"
                                         userImg:@"userdefault"]];
    [dataSource addObject:[self initWithUserInfo:@"定制服务"
                                         userImg:@"dingzhi"]];
    [dataSource addObject:[self initWithUserInfo:@"收藏夹"
                                         userImg:@"collect"]];
    [dataSource addObject:[self initWithUserInfo:@"设置"
                                         userImg:@"setting"]];
    return dataSource;

}

@end
