//
//  UserDetailInfo.h
//  Just_Run
//
//  Created by aoyolo on 15/9/7.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FocusModel;
@protocol UserDetailInfoCtlDelegate <NSObject>

- (void)dismissUserDetail;

@end
@interface UserDetailInfoCtl : UIViewController
@property (nonatomic, weak) id<UserDetailInfoCtlDelegate> delegate;
@property (nonatomic, strong) FocusModel *model;
@end
