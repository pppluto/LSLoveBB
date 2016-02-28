//
//  MatchModel.h
//  Just_Run
//
//  Created by aoyolo on 15/9/1.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MatchModel : NSObject
@property (nonatomic, copy) NSString *area;
@property (nonatomic, copy) NSString *areaDetail;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *introduceUrl;
@property (nonatomic, copy) NSString *nationalId;
+ (instancetype)matchModelWithDictionary:(NSDictionary *)dic;
- (instancetype)initWithDictionary:(NSDictionary *)dic;
- (void)setInfoWithDictionary:(NSDictionary *)dic;
@end
