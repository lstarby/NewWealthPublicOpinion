//
//  PushNoticeTableViewCell.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/7/12.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "PushNoticeTableViewCell.h"

@implementation PushNoticeTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubview];
    }
    return self;
}

- (void)createSubview {
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15,10,120, 20)];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:self.titleLabel];
    
    self.pushSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(self.contentView.frame.size.width - 55, 10, 40, 10)];
    self.pushSwitch.transform = CGAffineTransformMakeScale(0.75, 0.75);
    self.pushSwitch.on = NO;
    [self.pushSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    [self.contentView addSubview:self.pushSwitch];
}

- (void)switchAction:(id)sender {
    UISwitch* pushSwitch = (UISwitch*)sender;
    if (self.switchBlock) {
        self.switchBlock(self.pushID, pushSwitch.isOn);
    }
}

- (void)switchChange:(SwitchBlock)switchBlock {
    self.switchBlock = switchBlock;
}
@end
