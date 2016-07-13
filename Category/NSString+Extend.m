//
//  NSString+Extend.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/24.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "NSString+Extend.h"

@implementation NSString (Extend)

//昵称格式是否正确
- (NSString *)isNickName {
    if (self == nil || [self isEqualToString:@""]) {
        return @"请输入昵称";
    }
    int nLen = [self getStringLen];
    if (nLen > 16 || nLen < 1 ) {
        return @"请输入1-16个字母、数字或1-8个汉字";
    }
    //中文、字母或数字
    NSString *regex = @"[a-zA-Z0-9\u4e00-\u9fa5]+";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if(![pred evaluateWithObject:self]) {
        return @"昵称只能由中文、字母或数字组成";
    }
    return nil;
}

//获取字符串长度
- (int)getStringLen {
    int strlength = 0;
    // 这里一定要使用gbk的编码方式，网上有很多用Unicode的，但是混合的时候都不行
    NSStringEncoding gbkEncoding =CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    char* p = (char*)[self cStringUsingEncoding:gbkEncoding];
    for (int i=0 ; i<[self lengthOfBytesUsingEncoding:gbkEncoding] ;i++) {
        if (p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return strlength;
}

- (NSString *)isValiMobile {
    if ([self isEqualToString:@""] || self == nil) {
        return @"请输入新手机号";
    }
    if (self.length < 11) {
        return @"请控制手机号11位";
    }
    // 移动号段正则表达式
    NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";

     //联通号段正则表达式
    NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";

    // 电信号段正则表达式
    NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
    
    NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
    BOOL isMatch1 = [pred1 evaluateWithObject:self];
    NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
    BOOL isMatch2 = [pred2 evaluateWithObject:self];
    NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
    BOOL isMatch3 = [pred3 evaluateWithObject:self];
    
    if (!isMatch1 && !isMatch2 && !isMatch3) {
        return @"请输入正确的手机号码";
    }
    return nil;
}

//确认密码
- (NSString *)sureNewPassword:(NSString *)newPassword surePassword:(NSString *)surePassword {
    if ([self isEqualToString:@""] || self == nil) {
        return @"旧密码不能为空";
    }
    if ([newPassword isEqualToString:@""] || newPassword == nil) {
        return @"新密码不能是空";
    }
    if ([surePassword isEqualToString:@""] || surePassword == nil) {
        return @"确认密码不能是空";
    }
    if (![newPassword isEqualToString:surePassword]) {
        return @"新密码和确认密码不一致";
    }
    return nil;
}

//计算字符串size
- (CGSize)sizeForFont:(UIFont*)font constrainedToSize:(CGSize)constraint {

    NSDictionary *attributes = @{NSFontAttributeName:font};
    
    CGSize boundingBox = [self boundingRectWithSize:constraint options: NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    return CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
}

//获取时间date
- (NSDate *)getDate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    //设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    //设置时区,这个对于时间的处理有时很重要
    NSTimeZone* timeZone = [NSTimeZone localTimeZone];;
    [formatter setTimeZone:timeZone];
    //将字符串按formatter转成NSDate
    NSDate* date = [formatter dateFromString:self];
    return date;
}

//获取时间戳
- (NSNumber *)getTime {
    
    NSDate* date = [self getDate];
    //时间转时间戳的方法:
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    DLog(@"timeSp:%@",timeSp); //时间戳的值
    return [NSNumber numberWithDouble:[date timeIntervalSince1970]];
}

//获取展示时间
- (NSString *)getTimeStr {
    
    NSDate *date = [self getDate];
    NSDate *now = [NSDate date];
    
    NSCalendar *dateCalendar = [NSCalendar currentCalendar];
    NSCalendarUnit type = NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitYear| NSCalendarUnitHour| NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [dateCalendar components:type fromDate:date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *component = [calendar components:type fromDate:date toDate:now options:0];
    
    NSInteger year = [component year];
    NSInteger month = [component month];
    NSInteger day = [component day];
    
    NSInteger hour = [component hour];
    NSInteger minute = [component minute];
    
    NSString *string = nil;
    if (year) {
        string=[NSString stringWithFormat:@"%ld-%ld-%ld", dateComponent.year, dateComponent.month, dateComponent.day];
    } else if (month) {
        string=[NSString stringWithFormat:@"%02ld-%02ld %ld:%02ld", dateComponent.month, dateComponent.day, dateComponent.hour, dateComponent.minute];
    } else if (day) {
        string=[NSString stringWithFormat:@"%ld天前",day];
    } else if (hour) {
        string=[NSString stringWithFormat:@"%ld小时前",hour];
    } else if (minute >= 5) {
        string=[NSString stringWithFormat:@"%ld分钟前",minute];
    } else {
        string=@"刚刚";
    }
    return string;
}

- (NSString *)encodeToPercentEscapeString {
    // Encode all the reserved characters, per RFC 3986
    // (<http://www.ietf.org/rfc/rfc3986.txt>)
    NSString *outputStr = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)self,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    return outputStr;
}


@end
