//
//  MyTransitionDismissAnimation.m
//  testTransition
//
//  Created by aoyolo on 15/9/3.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import "MyTransitionDismissAnimation.h"

@implementation MyTransitionDismissAnimation
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 1.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    CGRect initRect = [transitionContext initialFrameForViewController:fromVC];
    CGRect finalRect = CGRectOffset(initRect,[UIScreen mainScreen].bounds.size.width,0);
    UIView *containView = [transitionContext containerView];
    [containView addSubview:toVC.view];
    [containView sendSubviewToBack:toVC.view];
    containView.backgroundColor = [UIColor whiteColor];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        fromVC.view.alpha = 0;
        fromVC.view.frame = finalRect;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

@end