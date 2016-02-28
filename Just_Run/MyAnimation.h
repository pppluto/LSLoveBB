//
//  MyAnimation.h
//  Just_Run
//
//  Created by aoyolo on 15/8/31.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface MyAnimation : NSObject
+ (CAKeyframeAnimation *)getKeyFrameAnimationWithKeyPath:(NSString *)keyPath andValues:(NSArray *)valuesArray;
@end
