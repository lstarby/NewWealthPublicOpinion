//
//  AddAttentionModel.h
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/13.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import <LKDBHelper/LKDBHelper.h>

@interface AddAttentionModel : JSONModel

@property (assign, nonatomic  ) int      id;
@property (copy, nonatomic    ) NSString *refId;
@property (assign, nonatomic  ) int      roleId;
@property (copy, nonatomic    ) NSString *parentId;
@property (copy, nonatomic    ) NSString *orgId;
@property (assign, nonatomic  ) int      sequence;
@property (copy, nonatomic    ) NSString *dataType;
@property (assign, nonatomic  ) int      type;
@property (copy, nonatomic    ) NSString *code;
@property (copy, nonatomic    ) NSString *name;
@property (copy, nonatomic    ) NSString *pinyin;
@property (copy, nonatomic    ) NSString *orgType;
@property (copy, nonatomic    ) NSString *alarm;
@property (copy, nonatomic    ) NSString *visible;

@end
