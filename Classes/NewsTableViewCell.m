//
//  NewsTableViewCell.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/28.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "NewsTableViewCell.h"
#import "UtilsHeader.h"

@implementation NewsTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubview];
    }
    return self;
}

- (void)createSubview {
    self.bgView = [[UIView alloc] init];
    self.bgView.backgroundColor = [UIColor whiteColor];
    self.bgView.frame = CGRectMake(10, 5, self.frame.size.width-20, 80);
    self.bgView.layer.cornerRadius = 4.0f;
    [self.bgView.layer setBorderColor:COLOR_CELL_BORDER];
    [self.bgView.layer setBorderWidth:1.0];
    [self.contentView addSubview:self.bgView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 5, self.frame.size.width-30, 21)];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.titleLabel.numberOfLines = 0;
    //self.titleLabel.text = @"用户ID";
    [self.bgView addSubview:self.titleLabel];
    
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.backgroundColor = [UIColor clearColor];
    self.timeLabel.font = [UIFont systemFontOfSize:12];
    self.timeLabel.textAlignment = NSTextAlignmentLeft;
    self.timeLabel.textColor = [UIColor lightGrayColor];
    [self.bgView addSubview:self.timeLabel];
    
    self.sourceLabel = [[UILabel alloc] init];
    self.sourceLabel.backgroundColor = [UIColor clearColor];
    self.sourceLabel.font = [UIFont systemFontOfSize:14];
    self.sourceLabel.textAlignment = NSTextAlignmentRight;
    self.sourceLabel.textColor = [UIColor lightGrayColor];
    [self.bgView addSubview:self.sourceLabel];
    
    self.entityNameLabel = [[UILabel alloc] init];
    self.entityNameLabel.backgroundColor = [UIColor clearColor];
    self.entityNameLabel.font = [UIFont systemFontOfSize:12];
    //self.entityNameLabel.textAlignment = NSTextAlignmentRight;
    self.entityNameLabel.textColor = [UIColor lightGrayColor];
    [self.bgView addSubview:self.entityNameLabel];
    self.entityNameLabel.hidden = YES;
    
}

- (void)setBType:(BOOL)bType {
    _bType = bType;
    self.entityNameLabel.hidden = bType;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    if (!_bType) {
        self.bgView.frame = CGRectMake(10, 5, kSCREEN_WIDTH - 20, self.height + 55);
    }
    else {
        self.bgView.frame = CGRectMake(10, 5, kSCREEN_WIDTH - 20, self.height + 35);
    }
    self.titleLabel.frame = CGRectMake(12, 5, kSCREEN_WIDTH - 40, self.height);
    self.timeLabel.frame = CGRectMake(12, self.height + 10, 160, 20);
    self.sourceLabel.frame = CGRectMake(kSCREEN_WIDTH - 140, self.height + 10, 100, 20);
    
    if (!_bType) {
        self.sourceLabel.frame = CGRectMake(kSCREEN_WIDTH - 140, self.height + 30, 100, 20);
        self.entityNameLabel.frame = CGRectMake(12, self.height + 30, kSCREEN_WIDTH - 20, 20);
        self.entityNameLabel.hidden = NO;
    }
}

- (void)setIsSeleted:(BOOL)isSeleted {
    _isSeleted = isSeleted;
    if (isSeleted) {
        self.bgView.backgroundColor = COLOR_BKGROUND;
        self.titleLabel.textColor = [UIColor lightGrayColor];
    } else {
        self.bgView.backgroundColor = [UIColor whiteColor];
        self.titleLabel.textColor = [UIColor blackColor];
    }
}


@end
