//
//  UserCenterTableViewCell.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/23.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "UserCenterTableViewCell.h"

@implementation UserCenterTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubview];
    }
    return self;
}

- (void)createSubview {
    self.iconImageView = [[UIImageView alloc] init];
    self.iconImageView.frame = CGRectMake(20, 10, 28, 28);
    self.iconImageView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.iconImageView];
      
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(58, 14, self.frame.size.width-48, 21)];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.font = [UIFont systemFontOfSize:17];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:self.titleLabel];
}
@end
