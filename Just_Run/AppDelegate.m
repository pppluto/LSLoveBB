//
//  AppDelegate.m
//  Just_Run
//
//  Created by aoyolo on 15/8/18.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//
#import "BKTabBarCtlViewController.h"
#import "AppDelegate.h"
#import "UMSocial.h"
#import "UIViewController+Swizzled.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [UMSocialData setAppKey:uMengAppKey];
//    SWIZZ_IT;
    return YES;
    //测试代码。。。。。
    [self.window makeKeyAndVisible];
    self.window.backgroundColor = TopicColor;
    BKTabBarCtlViewController *tab = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateInitialViewController];
    self.window.rootViewController = tab;
    CALayer *maskLayer = [CALayer layer];
    maskLayer.contents = (id)[UIImage imageNamed:@"logo"].CGImage;
    maskLayer.position = tab.view.center;
    maskLayer.bounds = CGRectMake(0, 0, 60, 60);
    tab.view.layer.mask = maskLayer;
    //logo mask background view
    UIView *maskBackgroundView = [[UIView alloc]initWithFrame:tab.view.bounds];
    maskBackgroundView.backgroundColor = [UIColor clearColor];
    [tab.view addSubview:maskBackgroundView];
    [tab.view bringSubviewToFront:maskBackgroundView];

    
    //logo mask animation
    CAKeyframeAnimation *logoMaskAnimaiton = [CAKeyframeAnimation animationWithKeyPath:@"bounds"];
    logoMaskAnimaiton.duration = 1.0f;
    logoMaskAnimaiton.beginTime = CACurrentMediaTime() ;//延迟一秒
    
    CGRect initalBounds = maskLayer.bounds;
    CGRect secondBounds = CGRectMake(0, 0, 50, 50);
    CGRect finalBounds  = CGRectMake(0, 0, 2000, 2000);
    logoMaskAnimaiton.values = @[[NSValue valueWithCGRect:initalBounds],[NSValue valueWithCGRect:secondBounds],[NSValue valueWithCGRect:finalBounds]];
    logoMaskAnimaiton.keyTimes = @[@(0),@(0.5),@(1)];
    logoMaskAnimaiton.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    logoMaskAnimaiton.removedOnCompletion = NO;
    logoMaskAnimaiton.fillMode = kCAFillModeForwards;
    [tab.view.layer.mask addAnimation:logoMaskAnimaiton forKey:@"logoMaskAnimaiton"];
    
    
    //    maskBackgroundView fade animation
    [UIView animateWithDuration:0.1 delay:1.35 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        maskBackgroundView.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        
        [maskBackgroundView removeFromSuperview];
        
    }];
    //
    //
    //navc.view bounce animation
    [UIView animateWithDuration:0.25 delay:1.3 options:UIViewAnimationOptionTransitionNone animations:^{
        
        tab.view.transform = CGAffineTransformMakeScale(1.05, 1.05);
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            tab.view.transform = CGAffineTransformIdentity;
            
        } completion:^(BOOL finished) {
            
            tab.view.layer.mask = nil;
            
        }];
    }];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
