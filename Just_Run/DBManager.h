//
//  DBManager.h
//  UI项目1
//
//  Created by aoyolo on 15/7/29.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface DBManager : NSObject
+ (id)sharedInstance;
- (BOOL)insertDataToDatabase:(NSData *)data key:(NSString *)key;
- (BOOL)deleteDataFromDatabase:(NSData *)data key:(NSString *)key;
- (BOOL)updataDataInDatabase:(NSData *)data key:(NSString *)key;
- (NSData *)dataWithKey:(NSString *)key;
@end
