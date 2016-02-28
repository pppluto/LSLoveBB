//
//  BKDataSource.m
//  Just_Run
//
//  Created by aoyolo on 15/8/23.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import "BKDataSource.h"
#import "UITableViewCell+myCell.h"
@implementation BKDataSource 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"数据源");
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_identifier];
    id dic = self.dataArray[indexPath.row];
    [cell configureCellWithDictionary:dic];

    return cell;
}
- (instancetype)initWithIdentifier:(NSString *)identifier{
    self = [super init];
    if (self) {
        _identifier = identifier;
    }
    return self;
}
- (id)itemForTableView:(UITableView *)tableview atIndexPath:(NSIndexPath *)indexPath{
    return self.dataArray[indexPath.row];
}
@end
