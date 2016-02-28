//
//  MyAlertObject.m
//  Just_Run
//
//  Created by aoyolo on 15/9/8.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import "MyAlertObject.h"

@implementation MyAlertObject
+ (UIAlertController *)alertWithMessage:(NSString *)message
                        sure:(NSString *)sure
                     handler:(void (^)(UIAlertAction *action))sureHandle
                 destructive:(NSString *)destructive
                     handler:(void (^)(UIAlertAction *action))destructiveHandle
                      cancel:(NSString *)cancel
                 canelHandle:(void (^)(UIAlertAction *action))cancelHandle
{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    if (sure!=nil) {
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:sure style:UIAlertActionStyleDefault handler:sureHandle];
        [alert addAction:sureAction];
    }
    if (cancel!=nil) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancel style:UIAlertActionStyleCancel handler:cancelHandle];
        [alert addAction:cancelAction];
    }
    if (destructive!=nil) {
        UIAlertAction *destructiveAction = [UIAlertAction actionWithTitle:destructive style:UIAlertActionStyleDestructive handler:destructiveHandle];
        [alert addAction:destructiveAction];
    }
    return alert;
}
@end
