//
//  MatchDetilView.h
//  Just_Run
//
//  Created by aoyolo on 15/9/6.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const matchDetailNewsCellIndetifier = @"matchDetailNewsCellIndetifier";
@interface MatchDetailView : UIScrollView
- (UITextView *)introduceView;
- (UIScrollView *)detailRoutingView;
- (UITableView *)detailNewsTableView;
- (UIView *)detailTeamsView;
@end
