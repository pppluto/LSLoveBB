//
//  ShowTimeViewController.m
//  Just_Run
//
//  Created by aoyolo on 15/8/24.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import "ShowTimeViewController.h"
#import "UserInfoView.h"
#import "UserModel.h"
#import "NetDataManager.h"
#import "MyAlertObject.h"
#import "ConfigureCtl.h"
@interface ShowTimeViewController () <NetDataManagerDelegate, UserInfoViewDelegate, ConfigureCtlDelegate>
{
    UserInfoView *_myInfoView;
    NetDataManager *_netManager;
}
@end

@implementation ShowTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setUp{
    self.navigationController.navigationBarHidden = YES;
//    self.title = @"p_Pluto";
//    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:TopicFont(20)};
//    self.navigationController.navigationBar.barTintColor = TopicColor;
    _myInfoView = [[UserInfoView alloc] initWithFrame:self.view.frame];
    [_myInfoView setRightButtonHidden:NO leftButtonHidden:YES];
    _myInfoView.delegate = self;
    [self.view addSubview:_myInfoView];
    _netManager = [[NetDataManager alloc] init];
    _netManager.netDataDelegate = self;
    [_netManager postRequsetWithUrl:[NSURL URLWithString:getUserInfo_Url] parameters:@"clickUserId=16724&userId=16724" key:getUserInfo_Url];
}
#pragma mark -net delegate
- (void)fecthFailuredForKey:(NSString *)key{
    //保留环测试
    UIAlertController *alert = [MyAlertObject
                                alertWithMessage:@"网络错误"
                                sure:@"重试"
                                handler:^(UIAlertAction *action) {
                                    [_netManager
                                     postRequsetWithUrl:[NSURL URLWithString:getUserInfo_Url]
                                         parameters:@"clickUserId=16724&userId=16724" key:getUserInfo_Url];
                                }
                                destructive:nil
                                handler:nil cancel:@"取消"
                                canelHandle:nil];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)fecthNetData:(NSData *)data key:(NSString *)key{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    UserModel *model = [UserModel userModelWithDictionary:dic];
    [_myInfoView configureWithModel:model];
    
}
- (void)rightButtonClicked{
    ConfigureCtl *ctl = [[ConfigureCtl alloc] init];
    ctl.delegate = self;
    [self presentViewController:ctl animated:YES completion:nil];
    NSLog(@"配置");
}
- (void)dismissConfigureCtl{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)iconButtonClicked:(UIButton *)button{
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
    effectView.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
    CGRect rect = button.frame;
    rect.origin.y += 65;
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:rect];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconBack:)];
    imgView.userInteractionEnabled = YES;
    [imgView addGestureRecognizer:tap];
    imgView.image = button.imageView.image;
    [effectView addSubview:imgView];
    [UIView animateWithDuration:0.5 animations:^{
        imgView.transform = CGAffineTransformTranslate(imgView.transform, 0, 200);
        imgView.transform = CGAffineTransformScale(imgView.transform, 3, 3);
    }];
    [self.view addSubview:effectView];
}
- (void)iconBack:(UITapGestureRecognizer *)tapGesture{
    UIImageView *tmp = (UIImageView *)tapGesture.view;
    UIVisualEffectView *tmpVisual = (UIVisualEffectView *)tmp.superview;
    [UIView animateWithDuration:0.5 animations:^{
        tmp.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [tmp removeFromSuperview];
        [tmpVisual removeFromSuperview];
    }];
}
@end











