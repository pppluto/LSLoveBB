//
//  CourtModel.m
//  Just_Run
//
//  Created by aoyolo on 15/8/30.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import "CourtModel.h"

@implementation CourtModel
+ (instancetype)courtModelWithDictionary:(NSDictionary *)dic{
    return [[CourtModel alloc] initWithDictionary:dic];
}
- (instancetype)initWithDictionary:(NSDictionary *)dic{
    [self setInfoWithDictionary:dic];
    return self;
}
- (void)setInfoWithDictionary:(NSDictionary *)dic{
    self.workTime = dic[@"worktime"];
    self.latitude = [dic[@"lat"] stringValue];
    self.longitude = [dic[@"lng"] stringValue];
    self.name = dic[@"name"];
    self.img = dic[@"img"];
    self.area = dic[@"area"];
    self.areaDetail = dic[@"areaDetail"];
    self.count = dic[@"count"];
    self.distance = dic[@"distance"];
}
@end
