//
//  FocusModel.m
//  Just_Run
//
//  Created by aoyolo on 15/8/29.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import "FocusModel.h"
#import "Helper.h"

@implementation FocusModel
+ (instancetype)focusModelWithDictionary:(NSDictionary *)dic{
    return [[FocusModel alloc] initWithDictionary:dic];
}
- (instancetype)initWithDictionary:(NSDictionary *)dic{
    [self setInfoWithDictionary:dic];
    return self;
}
- (void)setInfoWithDictionary:(NSDictionary *)dic{
    self.isLiked = 0;
    self.dynamicImg = dic[@"dynamic_img"];
    self.dynamicID = [dic[@"dynamic_id"] stringValue];
    self.dynamicVideo = dic[@"dynamicVideo"];
    self.userIcon = dic[@"userImg"];
    self.userName = dic[@"userName"];
    self.userID = dic[@"userId"];
    self.likeCount = [dic[@"agreeCount"] stringValue];
    self.leaveCount = [dic[@"leaveCount"] stringValue];
    self.describle = dic[@"text_content"];
    self.postTime = [Helper dateStringFromTimeStamp:[dic[@"add_time"] doubleValue]];
}
@end
