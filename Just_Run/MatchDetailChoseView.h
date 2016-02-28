//
//  MatchDetailChoseView.h
//  Just_Run
//
//  Created by aoyolo on 15/9/6.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MatchDetailChoseViewDelegate;
@interface MatchDetailChoseView : UIView
@property (nonatomic, weak) id<MatchDetailChoseViewDelegate> delegate;
- (void)setSelectedButton:(UIButton *)button;
@end
@protocol MatchDetailChoseViewDelegate <NSObject>

- (void)choseButtonClicked:(UIButton *)button;

@end