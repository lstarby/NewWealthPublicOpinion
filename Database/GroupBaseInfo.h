//
//  GroupBaseInfo.h
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/13.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import <LKDBHelper/LKDBHelper.h>

@interface GroupBaseInfo : JSONModel

@property (assign, nonatomic) int      rowindex;
@property (assign, nonatomic) int      groupid;
@property (copy, nonatomic  ) NSString *groupname;
@property (copy, nonatomic  ) NSString *comcode;
@property (copy, nonatomic  ) NSString *icon;
@property (assign, nonatomic) int      type;

@end
