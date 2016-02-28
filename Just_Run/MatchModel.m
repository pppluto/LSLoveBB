//
//  MatchModel.m
//  Just_Run
//
//  Created by aoyolo on 15/9/1.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import "MatchModel.h"

@implementation MatchModel
+ (MatchModel *)matchModelWithDictionary:(NSDictionary *)dic{
    MatchModel *model = [[MatchModel alloc] initWithDictionary:dic];
    return model;
}
- (MatchModel *)initWithDictionary:(NSDictionary *)dic{
    [self setInfoWithDictionary:dic];
    return self;
}
- (void)setInfoWithDictionary:(NSDictionary *)dic{
    self.name = dic[@"name"];
    self.img = dic[@"img"];
    self.area = dic[@"area"];
    self.areaDetail = dic[@"areaDetail"];
    self.introduceUrl = [SERVER_IP stringByAppendingString:dic[@"introduce"]];
    self.phone = dic[@"phone"];
    self.province = dic[@"province"];
    self.nationalId = [dic[@"nationalId"] stringValue];
}
@end
