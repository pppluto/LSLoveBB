//
//  DetailViewCtl.h
//  Just_Run
//
//  Created by aoyolo on 15/9/5.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FocusModel;
@protocol NewsDetailViewDelegate;
@interface NewsDetailViewCtl : UIViewController
@property (nonatomic, strong) FocusModel *model;
@property (nonatomic, copy) UIImage *headerImage;
@property (nonatomic, copy) NSString *dynamicId;
@property (nonatomic, weak) id<NewsDetailViewDelegate> delegate;
@end
@protocol NewsDetailViewDelegate <NSObject>
@optional
- (void)dismiss;

@end