//
//  CommentModel.m
//  Just_Run
//
//  Created by aoyolo on 15/9/5.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import "CommentModel.h"
#import "Helper.h"
@implementation CommentModel
+ (instancetype)commentModelWithDictionary:(NSDictionary *)dic{
    return [[CommentModel alloc] initWithDictionary:dic];
}
- (instancetype)initWithDictionary:(NSDictionary *)dic{
    [self setInfoWithDictionary:dic];
    return  self;
}
- (void)setInfoWithDictionary:(NSDictionary *)dic{
    self.add_time = [Helper dateStringFromTimeStamp:[dic[@"add_time"] doubleValue]];
    self.leave_content = dic[@"leave_content"];
    self.dynamic_id = dic[@"dynamic_id"];
    self.userId = dic[@"userId"];
    self.userImg = dic[@"userImg"];
    self.userName = dic[@"userName"];
    self.replyLeaveContent = dic[@"replyLeaveContent"];
    self.replyUserId = dic[@"replyUserId"];
    self.replyUserName = dic[@"replyUserName"];
}
@end
