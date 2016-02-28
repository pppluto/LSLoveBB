//
//  MatchDetailNewsModel.m
//  Just_Run
//
//  Created by aoyolo on 15/9/6.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import "MatchDetailNewsModel.h"

@implementation MatchDetailNewsModel
+ (instancetype)detailNewsModelWithDictionary:(NSDictionary *)dic{
    return [[MatchDetailNewsModel alloc] initWithDictionary:dic];

}
- (instancetype)initWithDictionary:(NSDictionary *)dic{
    [self setInfoWithDictionary:dic];
    return self;
}
- (void)setInfoWithDictionary:(NSDictionary *)dic{
    self.newsID = dic[@"id"];
    self.name = dic[@"name"];
    self.resourceHref = [NSString stringWithFormat:@"%@%@",SERVER_IP,dic[@"resourceHref"]];
    self.resourceType = dic[@"resourceType"];
    self.leaveCount = dic[@"leaveCount"];
    self.img = dic[@"img"];
}
@end
