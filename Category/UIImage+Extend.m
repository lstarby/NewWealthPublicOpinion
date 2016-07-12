//
//  UIImage+Extend.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/15.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "UIImage+Extend.h"

@implementation UIImage (Extend)

+ (UIImage *)stretchableImage:(NSString *)imageName{
    // 加载图片
    UIImage *image = [UIImage imageNamed:imageName];
    
    // 设置左边端盖宽度
    NSInteger leftCapWidth = image.size.width * 0.5;
    // 设置上边端盖高度
    NSInteger topCapHeight = image.size.height * 0.5;
    
    UIImage *newImage = [image stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
    
    return newImage;
}

@end
