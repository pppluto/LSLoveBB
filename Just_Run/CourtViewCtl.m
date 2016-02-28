//
//  CourtViewCtl.m
//  Just_Run
//
//  Created by aoyolo on 15/8/30.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//
//球场
#define Court_Url @"http://121.41.25.90/review/lbs/SearchBasketballCourt?__client__=android&pageNo=1&city=%E6%B7%B1%E5%9C%B3%E5%B8%82&area=&lat=22.582684&lng=113.870091&pageSize=20"
#define RecommendCourt_Url @"http://121.41.25.90/review/lbs/GetRecommendCourt?__client__=android"

#import "CourtViewCtl.h"
#import "RecommendCourtView.h"
#import "NetDataManager.h"
#import "BKDataSource.h"
#import "CourtModel.h"
#import "CourtCell.h"
#import "MapViewCtl.h"
@interface CourtViewCtl () <NetDataManagerDelegate, UITableViewDelegate>
{
    UITableView *_courtTableView;
    RecommendCourtView *_headerView;
    NetDataManager *_courtDataManager;
    BKDataSource *_courtDataSource;
}
@end
static NSString * const courtCellIdentifier = @"courtCellIdentifier";
@implementation CourtViewCtl
#pragma mark -event cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - netdatamanager delegate
- (void)fecthFailuredForKey:(NSString *)key{
    NSLog(@"渣渣网");
}
- (void)fecthNetData:(NSData *)data key:(NSString *)key{

    NSArray *tmp = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSMutableArray *arr = [@[] mutableCopy];
    if ([key hash] == [Court_Url hash]) {
        for (NSDictionary *dic in tmp) {
            CourtModel *model = [CourtModel courtModelWithDictionary:dic];
            [arr addObject:model];
        }
        _courtDataSource.dataArray = arr;
        [_courtTableView reloadData];
    } else {
        CourtModel *model = [CourtModel courtModelWithDictionary:tmp[0]];
            [_headerView configureViewWithModel:model];
    }
}
#pragma mark - tableview delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CourtModel *model = (CourtModel *)[_courtDataSource itemForTableView:tableView atIndexPath:indexPath];
    MapViewCtl *mapCtl = [[MapViewCtl alloc] init];
    mapCtl.model = model;
    [self.navigationController pushViewController:mapCtl animated:YES];
    
}
#pragma mark -private
- (void)setUp{
    self.title = @"深圳";
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:TopicFont(20)};
    _courtTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    _headerView = [[RecommendCourtView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 200)];
    _courtTableView.tableHeaderView = _headerView;
    [_courtTableView registerNib:[CourtCell nib] forCellReuseIdentifier:courtCellIdentifier];
    _courtTableView.rowHeight = 120;
    [self.view addSubview:_courtTableView];
    
    _courtDataSource = [[BKDataSource alloc] init];
    _courtDataSource.identifier = courtCellIdentifier;
    _courtTableView.dataSource = _courtDataSource;
    _courtTableView.delegate = self;

    _courtDataManager = [[NetDataManager alloc] init];
    _courtDataManager.netDataDelegate = self;
    [_courtDataManager sendRequestWithUrl:[NSURL URLWithString:RecommendCourt_Url] key:RecommendCourt_Url];
    [_courtDataManager sendRequestWithUrl:[NSURL URLWithString:Court_Url] key:Court_Url];
}
@end









