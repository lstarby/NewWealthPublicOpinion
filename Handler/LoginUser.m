//
//  LoginUser.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/16.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "LoginUser.h"

@implementation LoginUser

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.address forKey:@"address"];
    [aCoder encodeObject:self.clientType forKey:@"clientType"];
    [aCoder encodeObject:self.email forKey:@"email"];
    [aCoder encodeBool:self.isPush forKey:@"isPush"];
    [aCoder encodeBool:self.isPushInformation forKey:@"isPushInformation"];
    [aCoder encodeBool:self.isPushReport forKey:@"isPushReport"];
    [aCoder encodeBool:self.isPushWarning forKey:@"isPushWarning"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.nickname forKey:@"nickname"];
    [aCoder encodeObject:self.orgId forKey:@"orgId"];
    [aCoder encodeObject:self.password forKey:@"password"];
    [aCoder encodeObject:self.permission forKey:@"permission"];
    [aCoder encodeObject:self.photo forKey:@"photo"];
    [aCoder encodeObject:self.roleId forKey:@"roleId"];
    [aCoder encodeObject:self.tel forKey:@"tel"];
    [aCoder encodeObject:self.truename forKey:@"truename"];
    [aCoder encodeObject:self.type forKey:@"type"];
    [aCoder encodeObject:self.uk forKey:@"uk"];
    [aCoder encodeObject:self.userId forKey:@"userId"];
    [aCoder encodeObject:self.username forKey:@"username"];
    
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.address           = [aDecoder decodeObjectForKey:@"address"];
        self.clientType        = [aDecoder decodeObjectForKey:@"clientType"];
        self.email             = [aDecoder decodeObjectForKey:@"email"];
        self.isPush            = [aDecoder decodeBoolForKey:@"isPush"];
        self.isPushInformation = [aDecoder decodeBoolForKey:@"isPushInformation"];
        self.isPushReport      = [aDecoder decodeBoolForKey:@"isPushReport"];
        self.isPushWarning     = [aDecoder decodeBoolForKey:@"isPushWarning"];
        self.name              = [aDecoder decodeObjectForKey:@"name"];
        self.nickname          = [aDecoder decodeObjectForKey:@"nickname"];
        self.orgId             = [aDecoder decodeObjectForKey:@"orgId"];
        self.password          = [aDecoder decodeObjectForKey:@"password"];
        self.permission        = [aDecoder decodeObjectForKey:@"permission"];
        self.photo             = [aDecoder decodeObjectForKey:@"photo"];
        self.roleId            = [aDecoder decodeObjectForKey:@"roleId"];
        self.tel               = [aDecoder decodeObjectForKey:@"tel"];
        self.truename          = [aDecoder decodeObjectForKey:@"truename"];
        self.type              = [aDecoder decodeObjectForKey:@"type"];
        self.uk                = [aDecoder decodeObjectForKey:@"uk"];
        self.userId            = [aDecoder decodeObjectForKey:@"userId"];
        self.username          = [aDecoder decodeObjectForKey:@"username"];
        
    }
    return self;
}

@end
