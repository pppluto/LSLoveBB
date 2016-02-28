//
//  MyTransition.m
//  testTransition
//
//  Created by aoyolo on 15/9/3.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import "MyTransition.h"

@implementation MyTransition
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 1;
}
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    CGRect finalRect = [transitionContext finalFrameForViewController:toVC];
    toVC.view.frame = finalRect;
    UIView *containView = [transitionContext containerView];

    [containView addSubview:fromVC.view];
    [containView addSubview:toVC.view];
    [containView sendSubviewToBack:toVC.view];
    
    UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH/3, WIDTH*2/9)];
    view.center = CGPointMake(containView.center.x,containView.center.y);
    view.image = [UIImage imageNamed:@"sticker3.png"];
    [containView addSubview:view];
    [containView sendSubviewToBack:view];

    containView.backgroundColor = [UIColor whiteColor];
    CGFloat distance = WIDTH/2+100;
    [UIView animateWithDuration:0.7 animations:^{
        fromVC.view.transform = CGAffineTransformScale(fromVC.view.transform, 0.7, 0.7);
        toVC.view.transform = CGAffineTransformScale(toVC.view.transform, 0.7, 0.7);
        fromVC.view.transform = CGAffineTransformTranslate(fromVC.view.transform, -distance, 0);
        toVC.view.transform = CGAffineTransformTranslate(toVC.view.transform, distance, 0);
    } completion:^(BOOL finished) {
        [containView bringSubviewToFront:toVC.view];
        [UIView animateWithDuration:0.7 animations:^{
            fromVC.view.transform = CGAffineTransformTranslate(fromVC.view.transform, distance, 0);
            toVC.view.transform = CGAffineTransformTranslate(toVC.view.transform, -distance, 0);
            
            fromVC.view.transform = CGAffineTransformIdentity;
            toVC.view.transform = CGAffineTransformIdentity;
    
        } completion:^(BOOL finished) {
            fromVC.view.frame = finalRect;
            [transitionContext completeTransition:YES];
        }];
        
    }];
}
/*
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    CGRect finalRect = [transitionContext finalFrameForViewController:toVC];
    //    CGRect initRect = [transitionContext initialFrameForViewController:toVC];
    
    toVC.view.frame = finalRect;
    toVC.view.layer.anchorPoint = CGPointMake(0.5, 0);
    fromVC.view.layer.anchorPoint = CGPointMake(0.5, 0);
    //修改锚点后。viewframe会改变，需要重设。
    fromVC.view.frame = fromVC.view.layer.bounds;
    toVC.view.frame = toVC.view.layer.bounds;
    [[transitionContext containerView] addSubview:fromVC.view];
    [[transitionContext containerView] addSubview:toVC.view];
    [[transitionContext containerView] sendSubviewToBack:toVC.view];
    UIView *containView = [transitionContext containerView];
    containView.backgroundColor = [UIColor whiteColor];
    UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH/3, WIDTH*2/9)];
    view.center = CGPointMake(containView.center.x,containView.center.y+80);
    view.image = [UIImage imageNamed:@"sticker3.png"];
    [containView addSubview:view];
    [containView sendSubviewToBack:view];
    [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.8 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        fromVC.view.transform = CGAffineTransformRotate(fromVC.view.transform, M_PI_4);
        toVC.view.transform = CGAffineTransformRotate(toVC.view.transform, -M_PI_4);
        
    } completion:^(BOOL finished) {
        [[transitionContext containerView] sendSubviewToBack:fromVC.view];
        [UIView animateWithDuration:0.5 animations:^{
            fromVC.view.transform = CGAffineTransformRotate(fromVC.view.transform, -M_PI_4);
            toVC.view.transform = CGAffineTransformRotate(toVC.view.transform,M_PI_4);
        } completion:^(BOOL finished) {
            fromVC.view.frame = finalRect;
            [view removeFromSuperview];
            [transitionContext completeTransition:YES];
        }];
        
    }];
}*/
@end














