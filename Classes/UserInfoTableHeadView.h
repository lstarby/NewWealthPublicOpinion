//
//  UserInfoTableHeadView.h
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/23.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ClickedBlock)(UIButton *button);

@interface UserInfoTableHeadView : UIView

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, copy) ClickedBlock clickedBlock;

- (void)headClickedBlock:(ClickedBlock)clickedBlock;

@end
