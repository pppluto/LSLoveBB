//
//  BKDataSource.h
//  Just_Run
//
//  Created by aoyolo on 15/8/23.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void (^ConfigureCellBlock)(UITableViewCell *,NSDictionary *);

@interface BKDataSource : NSObject <UITableViewDataSource>
@property (nonatomic, copy) NSArray *dataArray;
//@property (nonatomic, copy) ConfigureCellBlock block;
@property (nonatomic, copy) NSString *identifier;
- (instancetype)initWithIdentifier:(NSString *)identifier;
- (id)itemForTableView:(UITableView *)tableview atIndexPath:(NSIndexPath *)indexPath;
@end
