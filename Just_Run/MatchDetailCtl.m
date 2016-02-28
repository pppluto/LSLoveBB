//
//  MatchDetailCtl.m
//  Just_Run
//
//  Created by aoyolo on 15/9/1.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import "MatchDetailCtl.h"
#import "UIImageView+WebCache.h"
#import "MatchModel.h"
#import "UIImage+myImage.h"
#import "MatchDetailChoseView.h"
#import "MatchDetailView.h"
#import "Helper.h"
#import "NetDataManager.h"
#import "BKDataSource.h"
#import "PlayVideoCtl.h"
#import "MatchDetailNewsModel.h"
@interface MatchDetailCtl () <MatchDetailChoseViewDelegate, NetDataManagerDelegate, PlayVideoDelegate, UIScrollViewDelegate, UITableViewDelegate>
{
    MatchDetailChoseView *_choseBar;
    MatchDetailView *_detailScrollView;
    BKDataSource *_detailNewsDataSource;
    NetDataManager *_detailMatchNetManager;
    NSInteger _currentButtonTag;
    
}
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@end

@implementation MatchDetailCtl

#pragma mark event cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark private
- (void)getIntroduce{
    
    NSString *pattern = @"[\\u4e00-\\u9fa5]+";
   NSString *str = [NSString stringWithContentsOfURL:[NSURL URLWithString:self.model.introduceUrl] encoding:NSUTF8StringEncoding error:nil];
    if (str == nil) {
        [_detailScrollView.introduceView performSelectorOnMainThread:@selector(setText:) withObject:@"服务器异常" waitUntilDone:NO];
        return;
    }
    NSString *string = [Helper stringWithString:str regexPattern:pattern];
    [_detailScrollView.introduceView performSelectorOnMainThread:@selector(setText:) withObject:string waitUntilDone:NO];
}
- (void)setUp{
    
    [NSThread detachNewThreadSelector:@selector(getIntroduce) toTarget:self withObject:nil];  
    
    _currentButtonTag = 70;//第一个
    _choseBar = [[MatchDetailChoseView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, 50)];
    _choseBar.backgroundColor = MYRGB(245,245,245);
    _choseBar.delegate = self;
    [self.view addSubview:_choseBar];
    
    _detailScrollView = [[MatchDetailView alloc] initWithFrame:CGRectMake(0, 115, WIDTH, HEIGHT-115)];
    [self.view addSubview:_detailScrollView];
    
    _nameLabel.text = self.model.name;
    
    _detailNewsDataSource = [[BKDataSource alloc] initWithIdentifier:matchDetailNewsCellIndetifier];
    _detailScrollView.detailNewsTableView.dataSource = _detailNewsDataSource;
    _detailScrollView.detailNewsTableView.delegate = self;
    _detailScrollView.delegate = self;
    _detailMatchNetManager = [[NetDataManager alloc] init];
    _detailMatchNetManager.netDataDelegate = self;
    
}
#pragma mark -tableView scrollView delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger pageNum = scrollView.contentOffset.x/WIDTH;
    NSLog(@"%ld",pageNum);
    if (_detailNewsDataSource.dataArray.count == 0 && pageNum == 2) {
        [self sendRequest];
    }
    UIButton *button = (UIButton *)[_choseBar viewWithTag:70+pageNum];
    [_choseBar setSelectedButton:button];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MatchDetailNewsModel *model = (MatchDetailNewsModel *)[_detailNewsDataSource itemForTableView:tableView atIndexPath:indexPath];
    PlayVideoCtl *playCtl = [[PlayVideoCtl alloc] init];
    playCtl.videoUrl = model.resourceHref;
    playCtl.delegate = self;
    [self presentViewController:playCtl animated:YES completion:nil];
}
#pragma mark - net delegate
- (void)fecthFailuredForKey:(NSString *)key{
    [self showAlertWith:@"网络不给力"];
}
- (void)fecthNetData:(NSData *)data key:(NSString *)key{
    NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSMutableArray *mutableArr = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in arr) {
        MatchDetailNewsModel *model = [[MatchDetailNewsModel alloc] initWithDictionary:dic];
        [mutableArr addObject:model];
    }
    _detailNewsDataSource.dataArray = mutableArr;
    [_detailScrollView.detailNewsTableView reloadData];
}
#pragma mark -present delegate
- (void)dismissPlay{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark -event response
- (void)choseButtonClicked:(UIButton *)button {
    if (button.tag == _currentButtonTag) {
        return;
    }
    _currentButtonTag = button.tag;
    
    if (_detailNewsDataSource.dataArray.count == 0 && button.tag==72) {
        [self sendRequest];
    }
    [_choseBar setSelectedButton:button];
    [_detailScrollView setContentOffset:CGPointMake((button.tag-70)*WIDTH, 0) animated:YES];
}
- (IBAction)backButtonClicked:(UIButton *)sender {
    [self.delegate dismiss];
}
- (void)showAlertWith:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        ;
    }];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)sendRequest{
    NSString *urlString = [NSString stringWithFormat:@"http://www.lanqiure.com/review/lbnational_news/GetNewsList?nationalId=%@&pageNo=1&pageSize=20",self.model.nationalId];
    [_detailMatchNetManager sendRequestWithUrl:[NSURL URLWithString:urlString] key:urlString];
}
@end
