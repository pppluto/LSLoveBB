//
//  DetailTableViewController.m
//  Just_Run
//
//  Created by aoyolo on 15/8/26.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import "DetailsController.h"

@interface DetailsController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *_allKeys;
    UITableView *_tableView;
}
@end
static NSString *detailCellIdentifier = @"detailCellIdentifier";
@implementation DetailsController
#pragma mark - event cycle
- (void)viewWillDisappear:(BOOL)animated{
    [self.navigationController popViewControllerAnimated:NO];
    [super viewWillDisappear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [(NSArray *)_placesDict[_allKeys[section]] count];;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _allKeys.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:detailCellIdentifier forIndexPath:indexPath];
    NSArray *tmp = (NSArray *)_placesDict[_allKeys[indexPath.section]];
    cell.textLabel.font = TopicFont(20);
    cell.textLabel.text = tmp[indexPath.row];
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return _allKeys[section];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *tmp = (NSArray *)_placesDict[_allKeys[indexPath.section]];
    _block(tmp[indexPath.row]);
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark event response
- (void)panGesture:(UIPanGestureRecognizer *)gesture{
    CGPoint point = [gesture velocityInView:self.view];
    if (gesture.state == UIGestureRecognizerStateEnded) {
        if (point.x>0) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }
}

#pragma mark private
- (void)setUp{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, WIDTH, HEIGHT-40) style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:detailCellIdentifier];
    _allKeys = [_placesDict.allKeys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSCaseInsensitiveSearch];
    }];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    [self.view addGestureRecognizer:pan];
    self.edgesForExtendedLayout = UIRectEdgeTop;
}
@end








