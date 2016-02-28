//
//  CommentModel.h
//  Just_Run
//
//  Created by aoyolo on 15/9/5.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentModel : NSObject
@property (nonatomic, copy) NSString *add_time;
@property (nonatomic, copy) NSString *dynamic_id;
@property (nonatomic, copy) NSString *leave_content;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *userImg;
@property (nonatomic, copy) NSString *userName;
// 回复的那条评论
@property (nonatomic, copy) NSString *replyLeaveContent;
@property (nonatomic, copy) NSString *replyUserName;
@property (nonatomic, copy) NSString *replyUserId;
+ (instancetype)commentModelWithDictionary:(NSDictionary *)dic;
- (instancetype)initWithDictionary:(NSDictionary *)dic;
- (void)setInfoWithDictionary:(NSDictionary *)dic;

@end
