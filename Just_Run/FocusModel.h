//
//  FocusModel.h
//  Just_Run
//
//  Created by aoyolo on 15/8/29.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FocusModel : NSObject
@property (nonatomic, copy) NSString *userIcon;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *userID;
@property (nonatomic, copy) NSString *describle;
@property (nonatomic, copy) NSString *postTime;
@property (nonatomic, copy) NSString *likeCount;
@property (nonatomic, copy) NSString *leaveCount;
@property (nonatomic, copy) NSString *dynamicImg;
@property (nonatomic, copy) NSString *dynamicVideo;
@property (nonatomic, copy) NSString *dynamicID;
@property (nonatomic, assign) CGFloat imgHeight;
@property (nonatomic, assign) BOOL isLiked;
+ (instancetype)focusModelWithDictionary:(NSDictionary *)dic;
- (instancetype)initWithDictionary:(NSDictionary *)dic;
- (void)setInfoWithDictionary:(NSDictionary *)dic;
@end
