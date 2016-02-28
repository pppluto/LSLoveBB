//
//  NewsTableView.m
//  Just_Run
//
//  Created by aoyolo on 15/9/5.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import "NewsTableView.h"
#import "FocusCell.h"
@implementation NewsTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize{
    [self registerNib:[FocusCell nib] forCellReuseIdentifier:focusCellIdentifier];
    self.rowHeight = UITableViewAutomaticDimension;
    self.estimatedRowHeight = 500;
//    self.rowHeight = 550;
}
@end
