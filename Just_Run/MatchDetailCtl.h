//
//  MatchDetailCtl.h
//  Just_Run
//
//  Created by aoyolo on 15/9/1.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MatchModel;
@protocol MatchDetailCtlDelegate;
@interface MatchDetailCtl : UIViewController

@property (nonatomic, weak) id<MatchDetailCtlDelegate> delegate;
@property (nonatomic, strong) MatchModel *model;
@end
@protocol MatchDetailCtlDelegate <NSObject>

- (void)dismiss;

@end