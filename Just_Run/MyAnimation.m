//
//  MyAnimation.m
//  Just_Run
//
//  Created by aoyolo on 15/8/31.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import "MyAnimation.h"

@implementation MyAnimation
+ (CAKeyframeAnimation *)getKeyFrameAnimationWithKeyPath:(NSString *)keyPath andValues:(NSArray *)valuesArray{
    
    CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:keyPath];
    keyFrameAnimation.duration = 1.0f;
    keyFrameAnimation.beginTime = CACurrentMediaTime() ;//延迟一秒
    
    if (valuesArray) {
        
        keyFrameAnimation.values = valuesArray;
        
    } else {
        
        CGRect initalBounds = CGRectMake(0, 0, 1, 1);
        CGRect secondBounds = CGRectMake(0, 0, 50, 50);
        CGRect finalBounds  = CGRectMake(0, 0, 2000, 2000);
        keyFrameAnimation.values = @[[NSValue valueWithCGRect:initalBounds],[NSValue valueWithCGRect:secondBounds],[NSValue valueWithCGRect:finalBounds]];
    }
    
    keyFrameAnimation.keyTimes = @[@(0),@(0.5),@(1)];
    keyFrameAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    keyFrameAnimation.removedOnCompletion = NO;
    keyFrameAnimation.fillMode = kCAFillModeForwards;
    
    return keyFrameAnimation;
}

@end
