//
//  OtherNewsTableViewCell.h
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/7/4.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface OtherNewsTableViewCell : BaseTableViewCell

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *timeLabel;
@property (strong, nonatomic) UILabel *detailLabel;
@property (strong, nonatomic) UILabel *sourceLabel;
@property (strong, nonatomic) UIView *bgView;

@end
