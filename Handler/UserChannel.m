//
//  UserChannel.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/16.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "UserChannel.h"

@implementation UserChannel


- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.itemId forKey:@"itemId"];
    [aCoder encodeObject:self.inforType forKey:@"inforType"];
    [aCoder encodeObject:self.type forKey:@"type"];
    [aCoder encodeObject:self.name forKey:@"name"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.itemId    = [aDecoder decodeObjectForKey:@"itemId"];
        self.inforType = [aDecoder decodeObjectForKey:@"inforType"];
        self.type      = [aDecoder decodeObjectForKey:@"type"];
        self.name      = [aDecoder decodeObjectForKey:@"name"];
        
    }
    return self;
}

@end
