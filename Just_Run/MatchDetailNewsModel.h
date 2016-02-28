//
//  MatchDetailNewsModel.h
//  Just_Run
//
//  Created by aoyolo on 15/9/6.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MatchDetailNewsModel : NSObject
@property (nonatomic, copy) NSString *newsID;
@property (nonatomic, copy) NSString *leaveCount;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *resourceHref;
@property (nonatomic, copy) NSString *resourceType;
+ (instancetype)detailNewsModelWithDictionary:(NSDictionary *)dic;
- (instancetype)initWithDictionary:(NSDictionary *)dic;
- (void)setInfoWithDictionary:(NSDictionary *)dic;
@end
