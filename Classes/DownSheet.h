//
//  DownSheet.h
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/7/12.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DownSheetDelegate <NSObject>
@optional
-(void)didSelectIndex:(NSInteger)index;
@end

@interface DownSheet : UIView<UIGestureRecognizerDelegate>

@property(nonatomic,assign) id <DownSheetDelegate> delegate;

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) NSArray *listData;

- (id)initWithlist:(NSArray *)list height:(CGFloat)height;
- (void)showInView:(UIViewController *)viewController;
- (void)tappedCancel;
@end
