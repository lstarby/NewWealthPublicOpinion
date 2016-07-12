//
//  GuideView.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/17.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "GuideView.h"
#import "UtilsHeader.h"

@implementation GuideView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        EAIntroPage *page1 = [EAIntroPage page];
        page1.title = @"";
        page1.desc = @"";
        //page1.bgImage = [UIImage imageNamed:@"guide1"];
        page1.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guide1"]];
        page1.titleIconPositionY = 0.0f;
        
        EAIntroPage *page2 = [EAIntroPage page];
        page2.title = @"";
        page2.desc = @"";
        //page2.bgImage = [UIImage imageNamed:@"guide2"];
        page2.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guide2"]];
        page2.titleIconPositionY = 0.0f;
        
        EAIntroPage *page3 = [EAIntroPage page];
        page3.title = @"";
        page3.desc = @"";
        //page3.bgImage = [UIImage imageNamed:@"guide3"];
        page3.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guide3"]];
        page3.titleIconPositionY = 0.0f;
        
        self.pages = @[page1,page2,page3];
        
        self.pageControl.currentPageIndicatorTintColor = COLOR_REDDEF;
        self.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        self.pageControlY = 40;
        self.skipButton = nil;
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        [btn setFrame:CGRectMake((320-230)/2, [UIScreen mainScreen].bounds.size.height - 60, 230, 40)];
//        [btn setTitle:@"SKIP" forState:UIControlStateNormal];
//        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//        self.skipButton = btn;
    }
    return self;
}

@end
