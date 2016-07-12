//
//  ApplyRecordTableViewCell.h
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/27.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "BaseTableViewCell.h"
#import <SKTagView/SKTagView.h>

@interface ApplyRecordTableViewCell : BaseTableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) SKTagView *tagView;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, assign) CGFloat height;

@end
