//
//  UserInfoModel.h
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/23.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *value;

- (id)initWithTitle:(NSString *)title value:(NSString *)value;
+ (id)initWithTitle:(NSString *)title value:(NSString *)value;

+ (NSArray *)getUserInfoSource ;

@end
