//
//  TagViewModel.m
//  Just_Run
//
//  Created by aoyolo on 15/9/10.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import "TagViewModel.h"

@implementation TagViewModel
+ (instancetype)tagViewModelWithDictionary:(NSDictionary *)dic{
    return [[TagViewModel alloc] initWithDictionary:dic];
}
- (instancetype)initWithDictionary:(NSDictionary *)dic{
    [self setInfoWithDictionary:dic];
    return self;
}
- (void)setInfoWithDictionary:(NSDictionary *)dic{
    self.tag_ID = [dic[@"tag_id"] stringValue];
    self.dynamic_ID = [dic[@"dynamic_id"] stringValue];
    self.tag_name = dic[@"tag_name"];
    self.x_position = dic[@"x_position"];
    self.y_posotion = dic[@"y_position"];
}

@end
