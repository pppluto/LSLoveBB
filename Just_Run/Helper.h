//
//  Helper.h
//  Just_Run
//
//  Created by aoyolo on 15/8/29.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Helper : NSObject
+ (NSString *)dateStringFromTimeStamp:(NSTimeInterval)timeInterval;
+ (NSAttributedString *)combineUserName:(NSString *)userName replyName:(NSString *)repleyUserName;
+ (NSString *)stringWithString:(NSString *)string regexPattern:(NSString *)pattern;
@end
