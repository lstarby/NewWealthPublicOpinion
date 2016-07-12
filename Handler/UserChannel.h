//
//  UserChannel.h
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/16.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import <JSONModel/JSONModel.h>

//资讯种类
@interface UserChannel : JSONModel<NSCoding>

@property (nonatomic, copy) NSString *itemId;
@property (nonatomic, copy) NSString *inforType;    //信息种类
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *name;         //名称

@end
