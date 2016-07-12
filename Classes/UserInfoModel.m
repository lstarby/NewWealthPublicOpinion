//
//  UserInfoModel.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/23.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "UserInfoModel.h"
#import "UserHandler.h"

@implementation UserInfoModel

- (id)initWithTitle:(NSString *)title value:(NSString *)value{
    self = [super init];
    if (self) {
        self.title = title;
        self.value = value;
    }
    return self;
}
+ (id)initWithTitle:(NSString *)title value:(NSString *)value {
    return [[self alloc] initWithTitle:title value:value];
}

+ (NSArray *)getUserInfoSource {
    NSMutableArray *dataSource = [NSMutableArray array];
    LoginUser *loginUser = [UserHandler sharedUserHandler].loginUser;
    [dataSource addObject:[self initWithTitle:@"昵称"
                                        value:loginUser.nickname]];
    [dataSource addObject:[self initWithTitle:@"手机号码"
                                        value:loginUser.mobile]];
    [dataSource addObject:[self initWithTitle:@"修改密码"
                                        value:@""]];
    return dataSource;
}


@end
