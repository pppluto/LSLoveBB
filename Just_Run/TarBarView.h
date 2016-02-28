//
//  TarBarView.h
//  Just_Run
//
//  Created by aoyolo on 15/8/18.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TarBarViewDelegate <NSObject>

- (void)buttonClicked:(UIButton *)button;
@end

@interface TarBarView : UIView
@property (nonatomic, weak) id<TarBarViewDelegate> delegate;
- (void)startLayerAnimation;
- (void)loadView;
@end

