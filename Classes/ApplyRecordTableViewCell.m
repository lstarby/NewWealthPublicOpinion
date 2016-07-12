//
//  ApplyRecordTableViewCell.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/27.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "ApplyRecordTableViewCell.h"
#import "ApplyRecordModel.h"
#import <SKTagView/SKTag.h>
#import "UtilsHeader.h"

@implementation ApplyRecordTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubview];
    }
    return self;
}

- (void)createSubview {
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 30)];
    self.titleLabel.layer.cornerRadius = 4.0f;
    self.titleLabel.layer.masksToBounds = YES;
    self.titleLabel.backgroundColor = COLOR_REDDEF;
    self.titleLabel.font = [UIFont systemFontOfSize:17];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor whiteColor];
    [self.contentView addSubview:self.titleLabel];
    
    self.tagView = [[SKTagView alloc] init];
    self.tagView.backgroundColor = [UIColor clearColor];
    self.tagView.preferredMaxLayoutWidth = kSCREEN_WIDTH - 20;
    self.tagView.padding = UIEdgeInsetsMake(10, 10, 10, 10);
    self.tagView.interitemSpacing = 15;
    self.tagView.lineSpacing = 15;
    self.tagView.singleLine = NO;
    [self.contentView addSubview:self.tagView];
}

- (void)setDataSource:(NSArray *)dataSource {
    [self.tagView removeAllTags];

    __weak typeof(self) weakSelf = self;
    [dataSource enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ApplyRecordModel *applyRecord = obj;
        SKTag *tag = [SKTag tagWithText: applyRecord.content];
        tag.bgColor = COLOR_REDDEF;
        tag.textColor = [UIColor whiteColor];
        tag.fontSize = 15;
        //tag.font = [UIFont fontWithName:@"Courier" size:15];
        tag.enable = NO;
        tag.padding = UIEdgeInsetsMake(5, 10, 5, 10);
        tag.cornerRadius = 5;
        [weakSelf.tagView addTag:tag];
    }];
    CGFloat tagHeight = self.tagView.intrinsicContentSize.height;
    self.tagView.frame = CGRectMake(0, 40, kSCREEN_WIDTH, tagHeight);
}

- (CGFloat)height {
    if (self.tagView.intrinsicContentSize.height == 0) {
        return 80;
    }
    return self.tagView.intrinsicContentSize.height + 40;
}


@end
