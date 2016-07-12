//
//  NewsTableViewCell.h
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/28.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface NewsTableViewCell : BaseTableViewCell

@property (strong, nonatomic) UIView  *bgView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *timeLabel;
@property (strong, nonatomic) UILabel *sourceLabel;
@property (strong, nonatomic) UILabel *entityNameLabel;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) BOOL    bType;
@property (nonatomic, assign) BOOL    isSeleted;

@end
