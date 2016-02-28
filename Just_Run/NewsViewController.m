//
//  NewsViewController.m
//  Just_Run
//
//  Created by aoyolo on 15/8/29.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import "NewsViewController.h"
#import "BKTabBarCtlViewController.h"
#import "PlayVideoCtl.h"
#import "NetDataManager.h"
#import "BKDataSource.h"
#import "NewsNaviBar.h"
#import "NewsTableView.h"
#import "FocusModel.h"
#import "FocusCell.h"
#import "MyAnimation.h"
#import "SVPullToRefresh.h"
#import "NewsDetailViewCtl.h"
#import "MyTransition.h"
#import "MyTransitionDismissAnimation.h"
#import "MyAlertObject.h"
#import "UMSocial.h"
//[[UIApplication sharedApplication] openURL:url];用手机safari打开连接

@interface NewsViewController () <NewsNaviBarDelegate, NetDataManagerDelegate, FocusCellDelegate, NewsDetailViewDelegate, PlayVideoDelegate, UMSocialUIDelegate, UIViewControllerTransitioningDelegate, UITableViewDelegate>
{
    NewsNaviBar *_newsNaviBar;
    NewsTableView *_newsTableView;
    NetDataManager *_netDataManager;
    BKDataSource *_newsDataSource;
    
    CGPoint _currentContenoffset;
    UIButton *_currentButton;
    
    NSMutableDictionary *_dataModelDictionary;
    NSMutableDictionary *_dataDictionary;
    NSArray *_keyArray;
    NSArray *_parametersArray;
    
}

@property (nonatomic, strong) MyTransition *presentAnimation;
@property (nonatomic, strong) MyTransitionDismissAnimation *dismissAnimation;
@end

@implementation NewsViewController
#pragma mark event cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
}

- (void)viewWillAppear:(BOOL)animated{
    [_newsTableView setContentOffset:_currentContenoffset];
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}
#pragma mark detailCtl delegate
- (void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)dismissPlay{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark newsTableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _currentContenoffset = tableView.contentOffset;
    
    FocusModel *focus =(FocusModel *)[_newsDataSource itemForTableView:tableView atIndexPath:indexPath];
    NewsDetailViewCtl *detailCtl = [[NewsDetailViewCtl alloc] init];

    detailCtl.model = focus;
    detailCtl.delegate = self;
    detailCtl.transitioningDelegate = self;
    [self presentViewController:detailCtl animated:YES completion:nil];
}
#pragma mark net delegate
- (void)fecthFailuredForKey:(NSString *)key{
    UIAlertController *alert = [MyAlertObject alertWithMessage:@"网络不给力" sure:@"确定" handler:nil destructive:nil handler:nil cancel:nil canelHandle:nil];
    [self presentViewController:alert animated:YES completion:nil];
    [_newsTableView.pullToRefreshView stopAnimating];
}
- (void)fecthNetData:(NSData *)data key:(NSString *)key{
    NSLog(@"接收数据");
    id test = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    if ([test isKindOfClass:[NSDictionary class]]) {
        return;
    } 
    NSMutableArray *arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];

    NSMutableArray *oldDataArr = _dataDictionary[key];
    NSMutableArray *newDataArr = [[NSMutableArray alloc] initWithArray:arr];
    
    NSMutableArray *oldModelArr = _dataModelDictionary[key];
    NSMutableArray *newModelArr = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in arr)
    {
        [oldDataArr enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
            if (dic[@"dynamic_id"] == obj[@"dynamic_id"]) {
                [oldDataArr replaceObjectAtIndex:[oldDataArr indexOfObject:obj] withObject:dic];
                [newDataArr removeObject:dic];
            }
        }];
    }
    for (NSDictionary *obj in newDataArr) {
        FocusModel *model = [FocusModel focusModelWithDictionary:obj];
        [newModelArr addObject:model];
    }
    [newDataArr addObjectsFromArray:oldDataArr];
    [_dataDictionary setObject:newDataArr forKey:key];
    NSData *storeData = [NSJSONSerialization dataWithJSONObject:newDataArr options:NSJSONWritingPrettyPrinted error:nil];
    [_netDataManager storeData:storeData Key:key];
    
    [newModelArr addObjectsFromArray:oldModelArr];
    [_dataModelDictionary setObject:newModelArr forKey:key];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self loadDataWithKey:key];
    });
    
}
#pragma mark private
- (void)doRefresh{
    //根据需要修改参数
    NSInteger index = _currentButton.tag-30;
    NSString *parameters = _parametersArray[index];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.5 * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [_netDataManager postRequsetWithUrl:[NSURL URLWithString:_keyArray[index]] parameters:parameters key:_keyArray[index]];
    });
}
- (void)loadDataWithKey:(NSString *)key{
    _newsDataSource.dataArray = [_dataModelDictionary[key] mutableCopy];
    [_newsTableView.pullToRefreshView stopAnimating];
    static BOOL blog = NO;
    [_newsTableView setContentOffset:CGPointZero];
    [_newsTableView reloadData];
    if (!blog) {
        blog = YES;
        return;
    }
    [_newsTableView scrollRectToVisible:_newsTableView.bounds animated:NO];
    [self beginAnimationForView:_newsTableView superView:self.view backGroundView:[self.view snapshotViewAfterScreenUpdates:NO] maskImage:nil];
}
- (void)setUp{
    _currentContenoffset = CGPointMake(0, 0);
    
    self.presentAnimation = [[MyTransition alloc] init];
    self.dismissAnimation = [[MyTransitionDismissAnimation alloc] init];
    
    _newsDataSource = [[BKDataSource alloc] init];
    _newsDataSource.identifier = focusCellIdentifier;
    
    self.navigationController.navigationBarHidden = YES;
    BKTabBarCtlViewController *bkTabbarCtl = (BKTabBarCtlViewController *)self.tabBarController;
    bkTabbarCtl.tabBarBar.alpha = 0;
    _newsNaviBar = [[NewsNaviBar alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 64)];
    _newsNaviBar.newsDelegate = self;
    _newsNaviBar.alpha = 0;
    _currentButton = (UIButton *)[_newsNaviBar viewWithTag:30];
    [self.view addSubview:_newsNaviBar];
    
    _newsTableView = [[NewsTableView alloc] initWithFrame:CGRectMake(0,65, WIDTH, HEIGHT-115)];

    [self.view addSubview:_newsTableView];
    _newsTableView.dataSource = _newsDataSource;
    _newsTableView.delegate = self;
    __weak typeof(self) weakSelf = self;
    [_newsTableView addPullToRefreshWithActionHandler:^{
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf doRefresh];
        
    }];
    _newsTableView.pullToRefreshView.arrowColor = TopicColor;
    [_newsTableView.pullToRefreshView setTitle:@"IB玩命加载中。。。" forState:SVPullToRefreshStateLoading];
    
    //启动动画
    UIImageView *tmpImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    tmpImg.image = [UIImage imageNamed:@"login-back.png"];
    tmpImg.contentMode = UIViewContentModeScaleAspectFit;
    [self beginAnimationForView:_newsTableView superView:self.view backGroundView:tmpImg maskImage:nil];
    
    //数据容器
    _dataModelDictionary = [[NSMutableDictionary alloc] init];
    _dataDictionary = [[NSMutableDictionary alloc] init];
    _keyArray = @[newFocus_Url,newHot_Url,mostNew_Url];
    _parametersArray = @[focusP,hotP,newP];

    _netDataManager = [[NetDataManager alloc] init];
    _netDataManager.netDataDelegate = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [_netDataManager getDataWithUrl:[NSURL URLWithString:_keyArray[0]] parameters:_parametersArray[0] key:_keyArray[0]];

    });

}
#pragma mark - event response
//点赞 参数格式 @"dynamicId=7336&replyUserId=17005&userId=16724";// 返回1成功

- (void)cellLikeButtonClicked:(UIButton *)button{
    button.selected = !button.selected;
    for (FocusModel *tmp in _newsDataSource.dataArray) {
        if ([tmp.dynamicID integerValue] == (button.tag)) {
            tmp.isLiked = button.selected;
            int like = button.selected? 1 : -1;
            tmp.likeCount = [NSString stringWithFormat:@"%ld",[tmp.likeCount integerValue]+like];
            [button setTitle:tmp.likeCount forState:UIControlStateNormal];
            NSString *parameters = [NSString stringWithFormat:@"dynamicId=%@&replyUserId=%@&userId=16724",tmp.dynamicID,tmp.userID];
            [_netDataManager postRequsetWithUrl:[NSURL URLWithString:addLike_Url] parameters:parameters key:addLike_Url];
            return;
        }
    }
    
}
//分享
- (void)cellShareButtonClicked:(UIButton *)button{
    for (FocusModel *tmp in _dataModelDictionary[_keyArray[_currentButton.tag-30]]) {
        if ([tmp.dynamicID integerValue] == button.tag) {
            [UMSocialSnsService presentSnsIconSheetView:self appKey:uMengAppKey shareText:@"P_pLuto" shareImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:tmp.dynamicImg]]] shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,nil] delegate:self];
        }
    }
}
//更多
- (void)cellMoreButtonClicked:(UIButton *)button{
    UIAlertController *alert = [MyAlertObject alertWithMessage:@"提示"
                                                          sure:nil
                                                       handler:nil
                                                   destructive:@"举报"
                                                       handler:^(UIAlertAction *action) {
                                                           NSLog(@"举报");
                                                       }
                                                        cancel:@"取消"
                                                   canelHandle:nil];
    [self presentViewController:alert animated:YES completion:nil];
}
//播放视频
- (void)cellVideoPlayButtonClicked:(UIButton *)button{
    for (FocusModel *tmp in _dataModelDictionary[_keyArray[_currentButton.tag-30]]) {
        if ([tmp.dynamicID integerValue] == button.tag) {
            PlayVideoCtl *play = [[PlayVideoCtl alloc] init];
            play.videoUrl = tmp.dynamicVideo;
            play.delegate = self;
            [self presentViewController:play animated:YES completion:nil];
            break;
        }
    }
}
//切换资源
- (void)newsButtonClicked:(UIButton *)button{
    if (button == _currentButton) {
        return;
    }
    _currentButton = button;
    [_newsNaviBar setSelectedButton:button];
    NSString *key = _keyArray[button.tag-30];
    NSString *parameters = _parametersArray[button.tag-30];
    [_netDataManager getDataWithUrl:[NSURL URLWithString:key] parameters:parameters key:key];
}
#pragma mark - 动画
- (void)beginAnimationForView:(UIView *)view superView:(UIView *)superView backGroundView:(UIView *)backGroundView maskImage:(UIImage *)maskImage{
    [self setMaskAtView:view maskImage:nil];

    [superView addSubview:backGroundView];
    [superView sendSubviewToBack:backGroundView];
    CAKeyframeAnimation *logoMaskAnimation = [MyAnimation getKeyFrameAnimationWithKeyPath:@"bounds" andValues:nil];
    [view.layer.mask addAnimation:logoMaskAnimation forKey:@"logo"];
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
                view.transform = CGAffineTransformMakeScale(1.05, 1.05);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _newsNaviBar.alpha = 1;

            BKTabBarCtlViewController *bkTabbarCtl = (BKTabBarCtlViewController *)self.tabBarController;
            bkTabbarCtl.tabBarBar.alpha = 1;
            view.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            view.layer.mask = nil;
            [backGroundView removeFromSuperview];
        }];
    }];
}
//蒙板
- (void)setMaskAtView:(UIView *)view maskImage:(UIImage *)maskImage{

    CALayer *maskLayer = [CALayer layer];
    if (maskImage == nil) {
        maskLayer.contents = (id)[UIImage imageNamed:@"logo"].CGImage;
    } else {
        maskLayer.contents = (id)maskImage.CGImage;
    }
    maskLayer.position = view.center;
    maskLayer.bounds = CGRectMake(0, 0, 1, 1);
    view.layer.mask = maskLayer;
}
#pragma mark -动画代理
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return  self.presentAnimation;
}
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return  self.presentAnimation;
}

@end
