//
//  DetailViewCtl.m
//  Just_Run
//
//  Created by aoyolo on 15/9/5.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import "NewsDetailViewCtl.h"
#import "NetDataManager.h"
#import "BKDataSource.h"
#import "CommentCell.h"
#import "CommentModel.h"
#import "UIImage+myImage.h"
#import "FocusModel.h"
#import "CommentHeaderView.h"
#import "UserDetailInfoCtl.h"
#import "MyAlertObject.h"
#import "TagViewModel.h"
@interface NewsDetailViewCtl () <NetDataManagerDelegate, CommentHeaderViewDelegate, UserDetailInfoCtlDelegate, UITableViewDelegate, UITextFieldDelegate>
{
    UITableView *_detailTableView;
    UITextField *_textField;
    UIView *_toolBar;
    CGRect _originalToolBarFrame;
    NetDataManager *_detailNetManager;
    BKDataSource *_detailDatasource;
    CommentHeaderView *_headerView;
    NSString *_replyLeavaID;
    BOOL keyboardShown;
}
@end
static NSString * const commentCellIdentifier = @"CommentCellIdentifier";
@implementation NewsDetailViewCtl
#pragma mark - cycle 
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super viewWillDisappear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark 启动
- (void)setUp{
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addNavigationBar];
    [self addToolBar];
    _detailNetManager = [[NetDataManager alloc] init];
    _detailNetManager.netDataDelegate = self;
    _detailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 65, WIDTH, HEIGHT-114) style:UITableViewStylePlain];
    [_detailTableView registerNib:[CommentCell nib] forCellReuseIdentifier:commentCellIdentifier];
    _detailTableView.estimatedRowHeight = 44;
    _detailTableView.rowHeight = UITableViewAutomaticDimension;
    [self.view addSubview:_detailTableView];
    _headerView = [[CommentHeaderView alloc] init];
    
    NSString *parameters = [NSString stringWithFormat:@"dynamicId=%@",self.model.dynamicID?self.model.dynamicID:self.dynamicId];
    if (self.model == nil) {
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, self.headerImage.size.width*WIDTH/self.headerImage.size.height)];
        image.image = self.headerImage;
        _headerView.frame = image.frame;
        [_headerView setPicImageView:image];
        _detailTableView.tableHeaderView = _headerView;
    } else {
        [_headerView configureWithModel:self.model];
        _detailTableView.tableHeaderView = _headerView;
    }
    _detailTableView.delegate = self;
    _detailDatasource = [[BKDataSource alloc] initWithIdentifier:commentCellIdentifier];
    _detailTableView.dataSource = _detailDatasource;


    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [_detailNetManager postRequsetWithUrl:[NSURL URLWithString:newDetail_Url] parameters:parameters key:newDetail_Url];
    });

    [self registerForKeyboardNotifications];

}
#pragma mark  delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentModel *model = (CommentModel *)[_detailDatasource itemForTableView:tableView atIndexPath:indexPath];
    if([model.userName isEqualToString:@"P_pLuto"]){
        return;
    }
    _textField.placeholder = [NSString stringWithFormat:@"回复 %@ ",model.userName];
    _replyLeavaID = model.userId;
    [_textField becomeFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    textField.placeholder =@"说点什么吧。";
    [textField resignFirstResponder];
    return YES;
}
- (void)dismissUserDetail{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark net delegate
- (void)fecthFailuredForKey:(NSString *)key{
    [self showAlertWith:@"网络不给力"];
}
- (void)fecthNetData:(NSData *)data key:(NSString *)key{
    NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    if (dataDic.count < 2) {
        [self handleSendCommentResponseWith:dataDic];
    } else {
        
        [self handleGetCommentResponseWith:dataDic];
    }
}

#pragma mark - event response
- (void)backButtonClicked{
    [self.delegate dismiss];
}
- (void)iconButtonClicked{
    UserDetailInfoCtl *userDetailCtl = [[UserDetailInfoCtl alloc] init];
    userDetailCtl.model = self.model;
    userDetailCtl.delegate = self;
    [self presentViewController:userDetailCtl animated:YES completion:nil];
}
- (void)commentSendButtonClicked{
    [_textField resignFirstResponder];
    if (!_textField.text.length) {
        return;
    }
    self.view.bounds = CGRectMake(0, 0, WIDTH, HEIGHT);
    
    NSString *parameters;
    if (![_textField.placeholder isEqual:@"说点什么吧。"]) {
        parameters = [NSString stringWithFormat:@"dynamicId=%@&leaveContent=%@&replyLeaveId=%@&replyUserId=%@&userId=16724",self.model.dynamicID,_textField.text,_replyLeavaID,self.model.userID];
    } else {
        parameters = [NSString stringWithFormat:@"dynamicId=%@&leaveContent=%@&replyUserId=%@&userId=16724",self.model.dynamicID,_textField.text,self.model.userID];
    }
    NSString *urlstr = [parameters stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    UIAlertController *alert = [MyAlertObject alertWithMessage:@"确定发送？"
                                                          sure:@"确定"
                                                       handler:^(UIAlertAction *action) {
                                                           [_detailNetManager postRequsetWithUrl:[NSURL URLWithString:addLeave_Url] parameters:urlstr key:addLeave_Url];
                                                       }
                                                   destructive:nil handler:nil cancel:@"取消" canelHandle:nil];
    _textField.text = nil;
    _textField.placeholder = @"说点什么吧。";
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark -private

- (void)handleSendCommentResponseWith:(NSDictionary *)dic{
    if ([dic[@"result"] integerValue] == 1) {
        [self sendRequest];
        [self showAlertWith:@"评论成功"];
        _textField.text = nil;
    } else {
        [self showAlertWith:@"网络错误"];
        _textField.text = nil;
    }
}
- (void)handleGetCommentResponseWith:(NSDictionary *)dic{
    NSArray *dynamicTagArr = dic[@"dynamicTag"];
    NSMutableArray *tagArr = [NSMutableArray array];
    NSLog(@"%ld",dynamicTagArr.count);
    for (NSDictionary *dic in dynamicTagArr) {
        TagViewModel *model = [TagViewModel tagViewModelWithDictionary:dic];
        [tagArr addObject:model];
    }
    [_headerView addTagWith:tagArr];
    
    NSArray *commentsArr = dic[@"dynamicLeave"];
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in commentsArr) {
        CommentModel *model = [CommentModel commentModelWithDictionary:dic];
        [arr addObject:model];
    }
    _detailDatasource.dataArray = arr;
    [_detailTableView reloadData];
}
- (void)sendRequest{
    //评论成功刷新视图
    NSString *parameters = [NSString stringWithFormat:@"dynamicId=%@",self.model.dynamicID];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [_detailNetManager postRequsetWithUrl:[NSURL URLWithString:newDetail_Url] parameters:parameters key:newDetail_Url];

    });
}

- (void)showAlertWith:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        ;
    }];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}
#pragma mark kvo
- (void)registerForKeyboardNotifications {
    keyboardShown = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasHidden:) name:UIKeyboardDidHideNotification object:nil];
}

- (void)keyboardWasShown:(NSNotification *)notification {
    NSLog(@"键盘弹起");
    if (keyboardShown) {
        return;
    }
    CGRect rect = _originalToolBarFrame;
    rect.origin.y -= 235;
    [UIView animateWithDuration:0.5 animations:^{
        self.view.frame = rect;
    }];
    keyboardShown = YES;
}
- (void)keyboardWasHidden:(NSNotification *)notification {
    _textField.placeholder = @"说点什么吧。";
    [UIView animateWithDuration:0.5 animations:^{
        self.view.frame = _originalToolBarFrame;
    }];
    keyboardShown = NO;
}
#pragma mark - UI
- (void)addNavigationBar{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 64)];
    [self.view addSubview:view];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH/2-30, 25, 60, 30)];
    label.font = TopicFont(20);
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"评论";
    [view addSubview:label];
    view.backgroundColor = TopicColor;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"navi-back.png"] forState:UIControlStateNormal];
    button.frame = CGRectMake(10, 20,40,40);
    [view addSubview:button];
    [button addTarget:self action:@selector(backButtonClicked) forControlEvents:UIControlEventTouchUpInside];
}
- (void)addToolBar{
    _toolBar = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT-50, WIDTH, 50)];
    _toolBar.backgroundColor = TopicColor;
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(20, 10, WIDTH*2/3, 30)];
    _textField.placeholder = @"说点什么吧。";
    _textField.backgroundColor = [UIColor whiteColor];
    _textField.delegate = self;
    _textField.borderStyle = UITextBorderStyleRoundedRect;
    [_toolBar addSubview:_textField];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"status-comment-send.png"] forState:UIControlStateNormal];
    button.frame = CGRectMake(WIDTH-70, 10, 50, 30);
    [button addTarget:self action:@selector(commentSendButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [_toolBar addSubview:button];
    [self.view addSubview:_toolBar];
    _originalToolBarFrame = self.view.frame;
    
}
@end
