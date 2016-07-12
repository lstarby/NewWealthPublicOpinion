//
//  DisclosureTabelViewCell.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/7/4.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "DisclosureTabelViewCell.h"
#import "UtilsHeader.h"

@implementation DisclosureTabelViewCell

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
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, self.bgView.frame.size.width - 20, 40)];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.numberOfLines = 2;
    [self.bgView addSubview:self.titleLabel];
    
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bgView.frame.size.width - 100, 55, 100, 20)];
    self.timeLabel.backgroundColor = [UIColor clearColor];
    self.timeLabel.font = [UIFont systemFontOfSize:14];
    self.timeLabel.textAlignment = NSTextAlignmentLeft;
    self.timeLabel.textColor = [UIColor lightGrayColor];
    self.timeLabel.numberOfLines = 1;
    [self.bgView addSubview:self.timeLabel];
    
}
@end
