//
//  ApplyFoucsViewController.h
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/24.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "BaseViewController.h"
#import "TypeHeader.h"

@interface ApplyFoucsViewController : BaseViewController
//公司company  个人 character
@property (nonatomic, assign) ApplyFoucsType applyFoucsType;

- (id)initWithApplyFoucsType:(ApplyFoucsType)applyFoucsType;

@end
