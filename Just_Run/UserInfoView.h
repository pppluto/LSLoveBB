//
//  UserInfoView.h
//  Just_Run
//
//  Created by aoyolo on 15/9/7.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UserModel;
@protocol UserInfoViewDelegate <NSObject>

@optional
- (void)rightButtonClicked;
- (void)backButtonClicked;
- (void)iconButtonClicked:(UIButton *)button;
- (void)focusButtonClicked:(UIButton *)button;
- (void)dynamicButtonClicked:(UIButton *)button;
@end
@interface UserInfoView : UIView
@property (nonatomic, weak) id<UserInfoViewDelegate> delegate;
- (void)configureWithModel:(UserModel *)model;
- (void)addDynamicView:(NSArray *)arr;
- (void)setRightButtonHidden:(BOOL)rHidden leftButtonHidden:(BOOL)lHidden;
@end
