//
//  UserCenterTableViewCell.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/23.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "UserCenterHeadTableViewCell.h"

@implementation UserCenterHeadTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubview];
    }
    return self;
}

- (void)createSubview {
    self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 80.0, 80.0)];
    [self.iconImageView setContentMode:UIViewContentModeScaleAspectFill];
    [self.iconImageView setClipsToBounds:YES];
    [self.iconImageView setImage:[UIImage imageNamed:@"example"]];
    [self.iconImageView.layer setCornerRadius:self.iconImageView.frame.size.width/2.0];
    [self.contentView addSubview:self.iconImageView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 20, 150, 20)];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.font = [UIFont systemFontOfSize:17];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:self.titleLabel];
    
    self.userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 50, 100, 20)];
    self.userNameLabel.backgroundColor = [UIColor clearColor];
    self.userNameLabel.font = [UIFont systemFontOfSize:14];
    self.userNameLabel.textAlignment = NSTextAlignmentLeft;
    self.userNameLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:self.userNameLabel];
}

@end
