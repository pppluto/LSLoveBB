//
//  MyAlertObject.h
//  Just_Run
//
//  Created by aoyolo on 15/9/8.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface MyAlertObject : NSObject
+ (UIAlertController *)alertWithMessage:(NSString *)message
                                       sure:(NSString *)sure
                                    handler:(void (^)(UIAlertAction *action))sureHandle
                                destructive:(NSString *)destructive
                                    handler:(void (^)(UIAlertAction *action))destructiveHandle
                                     cancel:(NSString *)cancel
                                canelHandle:(void (^)(UIAlertAction *action))cancelHandle;
@end
