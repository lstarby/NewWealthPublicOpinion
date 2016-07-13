//
//  DownSheet.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/7/12.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "DownSheet.h"
#import "UtilsHeader.h"

@implementation DownSheet

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

-(id)initWithlist:(NSArray *)list height:(CGFloat)height {
    self = [super init];
    if(self){
        self.frame = CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT);
        self.backgroundColor = [UIColor clearColor];
        self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height,self.frame.size.width , height)];
        self.bgView.backgroundColor = COLOR_SHEET_VIEW;
        self.listData = list;
        
        for (int i = 0; i < list.count; i++) {
            UIButton *button = [list objectAtIndex:i];
            button.frame = CGRectMake(20, 20 + i* 70, self.bgView.frame.size.width-40, 40);
            [self.bgView addSubview:button];
            
        }
        
        [self addSubview:self.bgView];
        [self animeData];
    }
    return self;
}

-(void)animeData {
    //self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedCancel)];
    [self addGestureRecognizer:tapGesture];
    tapGesture.delegate = self;
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:.25 animations:^{
        weakSelf.backgroundColor = COLOR_SHEET_BKGROUND;
        [UIView animateWithDuration:.25 animations:^{
            [weakSelf.bgView setFrame:CGRectMake(weakSelf.bgView.frame.origin.x, kSCREEN_HEIGHT - weakSelf.bgView.frame.size.height, weakSelf.bgView.frame.size.width, weakSelf.bgView.frame.size.height)];
        }];
    } completion:^(BOOL finished) {
    }];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if([touch.view isKindOfClass:[self class]]){
        return YES;
    }
    return NO;
}

-(void)tappedCancel {
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:.25 animations:^{
        [weakSelf.bgView setFrame:CGRectMake(0, kSCREEN_HEIGHT, kSCREEN_WIDTH, 0)];
        weakSelf.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [weakSelf removeFromSuperview];
        }
    }];
}

- (void)showInView:(UIViewController *)viewController {
    if(viewController == nil) {
        [[UIApplication sharedApplication].delegate.window.rootViewController.view addSubview:self];
    }
    else {
        [viewController.view addSubview:self];
    }
}



@end
