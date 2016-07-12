//
//  UIImage+Extend.h
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/15.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extend)

/**
 *  拉伸图片
 *
 *  @param imageName 图片名称
 *
 *  @return 拉伸后的图片
 */
+ (UIImage *)stretchableImage:(NSString *)imageName;

@end
