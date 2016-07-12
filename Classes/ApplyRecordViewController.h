//
//  ApplyRecordViewController.h
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/27.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "BaseViewController.h"
#import "TypeHeader.h"

@interface ApplyRecordViewController : BaseViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) ApplyFoucsType applyFoucsType;

- (id)initWithApplyFoucsType:(ApplyFoucsType)applyFoucsType;

@end
