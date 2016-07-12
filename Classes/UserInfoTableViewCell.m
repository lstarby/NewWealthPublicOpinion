//
//  UserInfoTableViewCell.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/23.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "UserInfoTableViewCell.h"

@implementation UserInfoTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubview];
    }
    return self;
}

- (void)createSubview {
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 80, 24)];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:self.titleLabel];
    
    self.valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, 180, 24)];
    self.valueLabel.backgroundColor = [UIColor clearColor];
    self.valueLabel.font = [UIFont systemFontOfSize:15];
    self.valueLabel.textAlignment = NSTextAlignmentRight;
    self.valueLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:self.valueLabel];
    
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

@end
