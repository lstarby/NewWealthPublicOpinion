//
//  SetingFontTableViewCell.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/7/12.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "SetingFontTableViewCell.h"

@implementation SetingFontTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubview];
    }
    return self;
}

- (void)createSubview {
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 100, 21)];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:self.titleLabel];
    
    self.selectImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width-40, 10, 25, 25)];
    self.selectImageView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.selectImageView];
}


@end
