//
//  CommentHeaderView.h
//  Just_Run
//
//  Created by aoyolo on 15/9/7.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FocusModel;
@protocol CommentHeaderViewDelegate <NSObject>

- (void)iconButtonClicked;

@end
@interface CommentHeaderView : UIView
@property (nonatomic, assign) CGFloat headerViewHeight;
@property (nonatomic, weak) id<CommentHeaderViewDelegate> delegate;
- (instancetype)initWithModel:(FocusModel *)model;
- (void)configureWithModel:(FocusModel *)model;
- (void)addTagWith:(NSArray *)arr;
- (CGFloat)headerViewHeight;
- (void)setPicImageView:(UIImageView *)imgView;

@end
