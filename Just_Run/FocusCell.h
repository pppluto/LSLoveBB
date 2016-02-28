//
//  FocusCell.h
//  Just_Run
//
//  Created by aoyolo on 15/8/29.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FocusModel.h"
@protocol FocusCellDelegate <NSObject>

- (void)cellLikeButtonClicked:(UIButton *)button;
- (void)cellShareButtonClicked:(UIButton *)button;
- (void)cellMoreButtonClicked:(UIButton *)button;
- (void)cellVideoPlayButtonClicked:(UIButton *)button;

@end
@interface FocusCell : UITableViewCell
@property (nonatomic, weak) id<FocusCellDelegate> cellDelegate;
+ (UINib *)nib;
//数据源不同
- (void)configureCellWithDictionary:(id)model;
@end
