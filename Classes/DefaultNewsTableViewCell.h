//
//  DefaultNewsTableViewCell.h
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/7/4.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "BaseTableViewCell.h"
#import <DBImageView/DBImageView.h>

@interface DefaultNewsTableViewCell : BaseTableViewCell

@property (nonatomic, strong) DBImageView *headImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIView  *bgView;

@end
