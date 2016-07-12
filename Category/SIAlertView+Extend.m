//
//  SIAlertView+Extend.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/15.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "SIAlertView+Extend.h"
#import "UIImage+Extend.h"
#import "UtilsHeader.h"

@implementation SIAlertView (Extend)


+ (void)alertViewAppearance{
    [[SIAlertView appearance] setMessageFont:[UIFont systemFontOfSize:16]];
    [[SIAlertView appearance] setTitleColor:[UIColor blackColor]];
    [[SIAlertView appearance] setMessageColor:[UIColor grayColor]];
    [[SIAlertView appearance] setCornerRadius:12];
    //[[SIAlertView appearance] setShadowRadius:30];
    [[SIAlertView appearance] setViewBackgroundColor:COLOR_BKGROUND];
    [[SIAlertView appearance] setButtonColor:[UIColor blackColor]];
    [[SIAlertView appearance] setCancelButtonColor:[UIColor grayColor]];
    [[SIAlertView appearance] setDestructiveButtonColor:[UIColor whiteColor]];
    
    [[SIAlertView appearance] setDefaultButtonImage:[UIImage stretchableImage:@"SIAlertView.bundle/button-default"]  forState:UIControlStateNormal];
    [[SIAlertView appearance] setDefaultButtonImage:[UIImage stretchableImage:@"SIAlertView.bundle/button-default-d"] forState:UIControlStateHighlighted];
    [[SIAlertView appearance] setCancelButtonImage:[UIImage stretchableImage:@"SIAlertView.bundle/button-cancel"] forState:UIControlStateNormal];
    [[SIAlertView appearance] setCancelButtonImage:[UIImage stretchableImage:@"SIAlertView.bundle/button-cancel-d"] forState:UIControlStateHighlighted];
    [[SIAlertView appearance] setDestructiveButtonImage:[UIImage stretchableImage:@"SIAlertView.bundle/button-destructive"] forState:UIControlStateNormal];
    [[SIAlertView appearance] setDestructiveButtonImage:[UIImage stretchableImage:@"SIAlertView.bundle/button-destructive-d"] forState:UIControlStateHighlighted];
}

+ (SIAlertView *)createOneButtonAlertView:(NSString *)title message:(NSString *)message buttonName:(NSString *)buttonName clicked:(AlertViewClicked)clickedBlock{
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:title andMessage:message];
    alertView.transitionStyle = SIAlertViewTransitionStyleFade;
    [alertView addButtonWithTitle:buttonName
                             type:SIAlertViewButtonTypeDestructive
                          handler:clickedBlock];
    [alertView show];
    return alertView;
}

+ (SIAlertView *)createTwoButtonAlertView:(NSString *)title message:(NSString *)message cancelButton:(NSString *)cancel defineButton:(NSString *)define cancelClicked:(AlertViewClicked)cancelClickedBlock defineClicked:(AlertViewClicked)defineClickedBlock{
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:title andMessage:message];
    alertView.transitionStyle = SIAlertViewTransitionStyleFade;
    [alertView addButtonWithTitle:cancel
                             type:SIAlertViewButtonTypeCancel
                          handler:cancelClickedBlock];
    [alertView addButtonWithTitle:define
                             type:SIAlertViewButtonTypeDestructive
                          handler:defineClickedBlock];
    [alertView show];
    return alertView;
}

+ (SIAlertView *)createThreeButtonAlertView:(NSString *)title message:(NSString *)message cancelButton:(NSString *)cancel defineButton:(NSString *)define threeButton:(NSString *)three cancelClicked:(AlertViewClicked)cancelClickedBlock defineClicked:(AlertViewClicked)defineClickedBlock threeClicked:(AlertViewClicked)threeClickedBlock{
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:title andMessage:message];
    alertView.transitionStyle = SIAlertViewTransitionStyleSlideFromBottom;
    [alertView addButtonWithTitle:cancel
                             type:SIAlertViewButtonTypeDestructive
                          handler:cancelClickedBlock];
    [alertView addButtonWithTitle:define
                             type:SIAlertViewButtonTypeDestructive
                          handler:defineClickedBlock];
    [alertView addButtonWithTitle:three
                             type:SIAlertViewButtonTypeDestructive
                          handler:threeClickedBlock];
    [alertView show];
    return alertView;
}

+ (SIAlertView *)createFourButtonAlertView:(NSString *)title message:(NSString *)message cancelButton:(NSString *)cancel defineButton:(NSString *)define threeButton:(NSString *)three fourButton:(NSString *)four cancelClicked:(AlertViewClicked)cancelClickedBlock defineClicked:(AlertViewClicked)defineClickedBlock threeClicked:(AlertViewClicked)threeClickedBlock fourClicked:(AlertViewClicked)fourClickedBlock{
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:title andMessage:message];
    alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
    
    [alertView addButtonWithTitle:define
                             type:SIAlertViewButtonTypeDefault
                          handler:defineClickedBlock];
    [alertView addButtonWithTitle:three
                             type:SIAlertViewButtonTypeDefault
                          handler:threeClickedBlock];
    [alertView addButtonWithTitle:four
                             type:SIAlertViewButtonTypeDefault
                          handler:fourClickedBlock];
    [alertView addButtonWithTitle:cancel
                             type:SIAlertViewButtonTypeDestructive
                          handler:cancelClickedBlock];
    [alertView show];
    return alertView;
}

@end
