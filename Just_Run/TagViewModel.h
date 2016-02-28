//
//  TagViewModel.h
//  Just_Run
//
//  Created by aoyolo on 15/9/10.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TagViewModel : NSObject
@property (nonatomic, copy) NSString *dynamic_ID;
@property (nonatomic, copy) NSString *tag_ID;
@property (nonatomic, copy) NSString *tag_name;
@property (nonatomic, copy) NSString *x_position;
@property (nonatomic, copy) NSString *y_posotion;
+ (instancetype)tagViewModelWithDictionary:(NSDictionary *)dic;
- (instancetype)initWithDictionary:(NSDictionary *)dic;
- (void)setInfoWithDictionary:(NSDictionary *)dic;
@end
