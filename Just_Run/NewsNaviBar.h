//
//  NewsView.h
//  Just_Run
//
//  Created by aoyolo on 15/8/19.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol NewsNaviBarDelegate <NSObject>
- (void)newsButtonClicked:(UIButton *)button;
@end
@interface NewsNaviBar : UIView
- (void)setSelectedButton:(UIButton *)button;
@property (nonatomic, weak) id<NewsNaviBarDelegate> newsDelegate;
@end

