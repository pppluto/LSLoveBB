//
//  MatchViewCtl.m
//  Just_Run
//
//  Created by aoyolo on 15/8/30.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//
//发现 联赛
#define Look_Url @"http://121.41.25.90/review/lbnational/GetLBNationalList?__client__=android&pageNo=1&pageSize=20"



#import "MatchViewCtl.h"
#import "NetDataManager.h"
#import "BKDataSource.h"
#import "MatchCell.h"
#import "MatchModel.h"
#import "MatchDetailCtl.h"
#import "MyTransition.h"
#import "MyTransitionDismissAnimation.h"
static NSString * const matchCellIdentifier = @"matchIdentifier";
@interface MatchViewCtl () <NetDataManagerDelegate, MatchDetailCtlDelegate, UIViewControllerTransitioningDelegate, UITableViewDelegate>
{
    NetDataManager *_matchNetDataManager;
    BKDataSource *_matchDataSource;
    UITableView *_matchTableView;
    
    NSMutableArray *_matchDataArray;
}
@property (nonatomic, strong) MyTransition *presentAnimation;
@property (nonatomic, strong) MyTransitionDismissAnimation *dismissAnimation;
@end

@implementation MatchViewCtl
#pragma mark - event cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - uitableview delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MatchModel *matchModel = (MatchModel *)[_matchDataSource itemForTableView:tableView atIndexPath:indexPath];
    MatchDetailCtl *detailCtl = [[MatchDetailCtl alloc] init];
    detailCtl.model = matchModel;
    detailCtl.transitioningDelegate = self;
    detailCtl.delegate = self;
    [self presentViewController:detailCtl animated:YES completion:nil];
}
#pragma mark - netManager delegate
- (void)fecthFailuredForKey:(NSString *)key{
    [self showAlertWith:@"网络不给力"];
}
- (void)fecthNetData:(NSData *)data key:(NSString *)key{
    NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    if (_matchDataArray == nil) {
        _matchDataArray = [[NSMutableArray alloc] init];
    } else {
        [_matchDataArray removeAllObjects];
    }
    for (NSDictionary *dic in arr) {
        MatchModel *model = [MatchModel matchModelWithDictionary:dic];
        [_matchDataArray addObject:model];
    }
    _matchDataSource.dataArray = [_matchDataArray mutableCopy];
    [_matchTableView reloadData];
}
#pragma mark - private
- (void)showAlertWith:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        ;
    }];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)setUp{
    
    self.title = @"联赛";
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:TopicFont(20)};
    
    self.presentAnimation = [[MyTransition alloc] init];
    self.dismissAnimation = [[MyTransitionDismissAnimation alloc] init];

    _matchNetDataManager = [[NetDataManager alloc] init];
    _matchNetDataManager.netDataDelegate = self;
    
    _matchDataSource = [[BKDataSource alloc] init];
    _matchDataSource.identifier = matchCellIdentifier;
    
    _matchTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-50) style:UITableViewStylePlain];
    [self.view addSubview:_matchTableView];
    _matchTableView.dataSource = _matchDataSource;
    _matchTableView.delegate = self;
    _matchTableView.rowHeight = 126;
    [_matchTableView registerNib:[MatchCell nib] forCellReuseIdentifier:matchCellIdentifier];
    
    [_matchNetDataManager sendRequestWithUrl:[NSURL URLWithString:newMatch_Url] key:newMatch_Url];
    
}
- (void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark transition delegate;
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return  self.presentAnimation;
}
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return  self.presentAnimation;//自定义去
}
@end
