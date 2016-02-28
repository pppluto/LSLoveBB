//
//  UserModel.h
//  Just_Run
//
//  Created by aoyolo on 15/9/7.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject
@property (nonatomic, readonly, copy) NSString *agreeCount;
@property (nonatomic, readonly, copy) NSString *area;
@property (nonatomic, readonly, copy) NSString *city;
@property (nonatomic, readonly, copy) NSString *focusUserCount;
@property (nonatomic, readonly, copy) NSString *fansCount;
@property (nonatomic, readonly, copy) NSString *weChat;
@property (nonatomic, readonly, copy) NSString *userTeam;
@property (nonatomic, readonly, copy) NSString *userHeight;
@property (nonatomic, readonly, copy) NSString *userId;
@property (nonatomic, readonly, copy) NSString *userImg;
@property (nonatomic, readonly, copy) NSString *userName;
@property (nonatomic, readonly, copy) NSString *userWeight;
@property (nonatomic, readonly, assign) BOOL userSex;
@property (nonatomic, readwrite, assign) BOOL isFocused;
+ (instancetype)userModelWithDictionary:(NSDictionary *)dic;
- (instancetype)initWithDictionary:(NSDictionary *)dic;
- (void)setInfoWithDictionary:(NSDictionary *)dic;
@end
