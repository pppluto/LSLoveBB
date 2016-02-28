//
//  MessageViewController.m
//  Just_Run
//
//  Created by aoyolo on 15/8/26.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import "MessageViewController.h"
#import "BKDataSource.h"
#import "NetDataManager.h"
#import "MessageCell.h"
@interface MessageViewController ()
{
    UIButton *_currentButton;
    BKDataSource *_messageDataSource;
    NetDataManager *_messageNetDataManager;
}
@property (weak, nonatomic) IBOutlet UITableView *messageTableView;
@end
static NSString *messageIdentifier = @"messageIdentifier";
@implementation MessageViewController

#pragma mark event cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark event response
- (IBAction)buttonClicked:(UIButton *)sender {
    if (_currentButton == sender) {
        return;
    }
    _currentButton.selected = NO;
    _currentButton.layer.shadowOpacity = 0;
    _currentButton = sender;
    _currentButton.selected = YES;
    _currentButton.layer.shadowOffset = CGSizeMake(1, 3);
    _currentButton.layer.shadowColor = [UIColor grayColor].CGColor;
    _currentButton.layer.shadowOpacity = 0.9;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //修复点击视图 底部按钮旋转问题
    UITouch *touch = [touches anyObject];
    if (touch.view == _currentButton.superview) {
        return;
    }
}
#pragma mark private method
- (void)setUp{
    self.title = @"消息";
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:TopicFont(20)};
    self.navigationController.navigationBar.barTintColor = TopicColor;
    if (_currentButton) {
        _currentButton.selected = NO;
    }
    _messageDataSource = [[BKDataSource alloc] init];
    [_messageTableView registerNib:[UINib nibWithNibName:@"MessageCell" bundle:nil] forCellReuseIdentifier:messageIdentifier];
    
    _messageDataSource.identifier = messageIdentifier;
    _messageTableView.dataSource = _messageDataSource;
    UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, WIDTH*2/3)];
    view.center = self.view.center;
    view.image = [UIImage imageNamed:@"sticker3.png"];
    [self.view addSubview:view];
    
    _messageNetDataManager = [[NetDataManager alloc] init];
}

@end
