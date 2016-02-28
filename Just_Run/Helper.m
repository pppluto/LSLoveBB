//
//  Helper.m
//  Just_Run
//
//  Created by aoyolo on 15/8/29.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import "Helper.h"
static NSTimeInterval HOURS = 3600;
//1440990022057 1441077899162
@implementation Helper
+ (NSString *)dateStringFromTimeStamp:(NSTimeInterval)timeInterval{
    NSDate *currentDate = [NSDate date];
    NSTimeInterval currentTimeStamp = [currentDate timeIntervalSince1970];
    NSTimeInterval minusTime = currentTimeStamp- timeInterval/1000;
    if (minusTime < HOURS) {
        return @"刚刚";
    } else if (minusTime < 24 * HOURS) {
        return [NSString stringWithFormat:@"%d小时前",(int)(minusTime/HOURS)];
    } else if (minusTime < 48 * HOURS) {
        return @"昨天";
    } else if (minusTime < 24*7*HOURS){
        return [NSString stringWithFormat:@"%d天前",(int)(minusTime/HOURS/24)];
    } else {
        return @"上古年代";
    }
}
+ (NSAttributedString *)combineUserName:(NSString *)userName replyName:(NSString *)repleyUserName{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ 回复 %@",userName,repleyUserName]];
    [str setAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} range:NSMakeRange(userName.length, 3)];
    return str;
}
+ (NSString *)stringWithString:(NSString *)string regexPattern:(NSString *)pattern{
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    NSArray *results = [regex matchesInString:string options:0 range:NSMakeRange(0, string.length)];
    NSMutableString *str1 = [[NSMutableString alloc] init];
    
    for (NSTextCheckingResult *tmp in results) {
        [str1 appendString:[string substringWithRange:tmp.range]];
    }
    return  str1;
}
@end
