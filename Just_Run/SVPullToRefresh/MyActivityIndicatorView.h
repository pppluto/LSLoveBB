//
//  MyActivityIndicatorView.h
//  Just_Run
//
//  Created by aoyolo on 15/9/7.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyActivityIndicatorView : UIView <UIScrollViewDelegate>
- (instancetype)initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyle)style;
- (void)startAnimating;
- (void)stopAnimating;
- (BOOL)isAnimating;
- (void)stopTimer;
@property (nonatomic, assign) UIActivityIndicatorViewStyle activityIndicatorViewStyle;
@property (nonatomic, assign) BOOL hidesWhenStopped;
@end
