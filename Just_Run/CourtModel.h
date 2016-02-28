//
//  CourtModel.h
//  Just_Run
//
//  Created by aoyolo on 15/8/30.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CourtModel : NSObject
@property (nonatomic, copy) NSString *area;
@property (nonatomic, copy) NSString *areaDetail;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *count;
@property (nonatomic, copy) NSString *distance;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *latitude;
@property (nonatomic, copy) NSString *longitude;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *source_href;
@property (nonatomic, copy) NSString *workTime;
+ (instancetype)courtModelWithDictionary:(NSDictionary *)dic;
- (instancetype)initWithDictionary:(NSDictionary *)dic;
- (void)setInfoWithDictionary:(NSDictionary *)dic;
@end
