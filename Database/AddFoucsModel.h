//
//  AddFoucsModel.h
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/13.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import <LKDBHelper/LKDBHelper.h>

@interface AddFoucsModel : JSONModel

@property (assign, nonatomic) int      rowindex;
@property (copy, nonatomic  ) NSString *name;
@property (assign, nonatomic) int      dataType;
@property (assign, nonatomic) int      parentId;
@property (assign, nonatomic) int      refId;
@property (assign, nonatomic) int      roleId;
@property (assign, nonatomic) int      sequence;
@property (assign, nonatomic) int      type;

@end
