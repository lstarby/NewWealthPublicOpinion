//
//  UserInfoTableHeadView.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/23.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "UserInfoTableHeadView.h"

@implementation UserInfoTableHeadView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubview];
    }
    return self;
}

- (void)createSubview {
    self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 20, 80.0, 80.0)];
    [self.iconImageView setContentMode:UIViewContentModeScaleAspectFill];
    [self.iconImageView setClipsToBounds:YES];
    [self.iconImageView setImage:[UIImage imageNamed:@"example"]];
    //[iconImageView.layer setBorderColor:[UIColor whiteColor].CGColor];
    // [iconImageView.layer setBorderWidth:2.0];
    [self.iconImageView.layer setCornerRadius:self.iconImageView.frame.size.width/2.0];
    [self addSubview:self.iconImageView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, self.center.y - 10, 160, 21)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont systemFontOfSize:17];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.text = @"修改头像";
    [self addSubview:titleLabel];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = self.frame;
    button.backgroundColor = [UIColor clearColor];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
}

- (void)headClickedBlock:(ClickedBlock)clickedBlock {
    self.clickedBlock = clickedBlock;
}

- (void)buttonClicked:(UIButton *)sender {
    if (self.clickedBlock) {
        self.clickedBlock(sender);
    }
}

@end
