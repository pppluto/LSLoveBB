//
//  CourtCell.h
//  Just_Run
//
//  Created by aoyolo on 15/8/30.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CourtCell : UITableViewCell
+ (UINib *)nib;
- (void)configureCellWithDictionary:(id)model;
@end
