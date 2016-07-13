//
//  PushNoticeTableViewCell.h
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/7/12.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "BaseTableViewCell.h"

typedef void(^SwitchBlock)(NSString *pushID, BOOL isPush);
@interface PushNoticeTableViewCell : BaseTableViewCell

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UISwitch *pushSwitch;
@property (nonatomic, copy  )  NSString *pushID;

@property (nonatomic, copy) SwitchBlock switchBlock;

- (void)switchChange:(SwitchBlock)switchBlock;

@end
