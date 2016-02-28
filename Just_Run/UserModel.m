//
//  UserModel.m
//  Just_Run
//
//  Created by aoyolo on 15/9/7.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel
+ (instancetype)userModelWithDictionary:(NSDictionary *)dic{
    return  [[UserModel alloc] initWithDictionary:dic];
}
- (instancetype)initWithDictionary:(NSDictionary *)dic{
    [self setInfoWithDictionary:dic];
    return self;
}
- (void)setInfoWithDictionary:(NSDictionary *)dic{
    _agreeCount = [NSString stringWithFormat:@"%@",dic[@"agreeCount"]];
    _area = dic[@"area"];
    _city = dic[@"city"];
    _fansCount = [NSString stringWithFormat:@"%@",dic[@"fansCount"]];
    _userHeight = [NSString stringWithFormat:@"%@",dic[@"height"]];
    _userWeight = [NSString stringWithFormat:@"%@",dic[@"weight"]];
    _weChat = dic[@"sign"];
    _userTeam = dic[@"team"];
    _userId = [NSString stringWithFormat:@"%@",dic[@"userId"]];
    _userImg = dic[@"userImg"];
    _userName = dic[@"userName"];
    if ([dic[@"sex"] integerValue] == 2) {
        _userSex = NO;
    } else {
        _userSex = YES;
    }
    if ([dic[@"ifFocus"] integerValue]) {
        _isFocused = YES;
    } else {
        _isFocused = NO;
    }
    
    
}
@end
