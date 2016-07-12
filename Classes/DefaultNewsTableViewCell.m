//
//  DefaultNewsTableViewCell.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/7/4.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "DefaultNewsTableViewCell.h"
#import "UtilsHeader.h"

@implementation DefaultNewsTableViewCell

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
    self.bgView.frame = CGRectMake(10, 5, self.frame.size.width-20, 90);
    self.bgView.layer.cornerRadius = 4.0f;
    [self.bgView.layer setBorderColor:COLOR_CELL_BORDER];
    [self.bgView.layer setBorderWidth:1.0];
//    self.backgroundColor = COLOR_BKGROUND;
    [self.contentView addSubview:self.bgView];
    
    self.headImageView = [[DBImageView alloc] initWithFrame:CGRectMake(8, 10, 70, 70)];
    self.headImageView.backgroundColor = [UIColor clearColor];
    [self.bgView addSubview:self.headImageView];
    
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(88, 5, self.bgView.frame.size.width - 96, 20)];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.titleLabel.numberOfLines = 1;
    [self.bgView addSubview:self.titleLabel];
    
    self.detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(88, 30, self.bgView.frame.size.width - 96, 40)];
    self.detailLabel.backgroundColor = [UIColor clearColor];
    self.detailLabel.font = [UIFont systemFontOfSize:14];
    self.detailLabel.textAlignment = NSTextAlignmentLeft;
    self.detailLabel.textColor = [UIColor lightGrayColor];
    self.detailLabel.numberOfLines = 2;
    [self.bgView addSubview:self.detailLabel];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(180, 70, self.bgView.frame.size.width - 180, 20)];
    self.timeLabel.backgroundColor = [UIColor clearColor];
    self.timeLabel.font = [UIFont systemFontOfSize:14];
    self.timeLabel.textAlignment = NSTextAlignmentLeft;
    self.timeLabel.textColor = [UIColor lightGrayColor];
    self.timeLabel.numberOfLines = 1;
    [self.bgView addSubview:self.timeLabel];
    
}
@end
