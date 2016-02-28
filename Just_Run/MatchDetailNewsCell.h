//
//  MatchDetailNewsCell.h
//  Just_Run
//
//  Created by aoyolo on 15/9/6.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MatchDetailNewsCell : UITableViewCell
+ (UINib *)nib;
- (void)configureCellWithDictionary:(id)model;
@end
