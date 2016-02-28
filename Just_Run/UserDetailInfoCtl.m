//
//  UserDetailInfo.m
//  Just_Run
//
//  Created by aoyolo on 15/9/7.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import "UserDetailInfoCtl.h"
#import "UserInfoView.h"
#import "UserModel.h"
#import "NetDataManager.h"
#import "NewsDetailViewCtl.h"
#import "FocusModel.h"
typedef NS_ENUM(NSInteger, UserInfoType) {
    UserDynamicInfo = 0,
    UserFocusInfo,
    UserDetailInfo
};
@interface UserDetailInfoCtl () <UserInfoViewDelegate, NetDataManagerDelegate, NewsDetailViewDelegate>
{
    NetDataManager *_userInfoManager;
    UserInfoView *_userDetailView;
}
@end

@implementation UserDetailInfoCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    _userInfoManager = [[NetDataManager alloc] init];
    _userInfoManager.netDataDelegate = self;
    NSString *parameters = [NSString stringWithFormat:@"clickUserId=%@&userId=16724",self.model.userID];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [_userInfoManager postRequsetWithUrl:[NSURL URLWithString:getUserInfo_Url] parameters:parameters key:getUserInfo_Url];
        [_userInfoManager postRequsetWithUrl:[NSURL URLWithString:getUserDynamics_Url] parameters:[NSString stringWithFormat:@"pageNo=1&pageSize=15&userId=%@",self.model.userID] key:getUserDynamics_Url];
    });
    _userDetailView = [[UserInfoView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:_userDetailView];
}
#pragma mark -delegate
- (void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)backButtonClicked {
    [self.delegate dismissUserDetail];
}
- (void)dynamicButtonClicked:(UIButton *)button {
    NewsDetailViewCtl *detail = [[NewsDetailViewCtl alloc]init];
    detail.delegate = self;
    detail.headerImage = button.imageView.image;
    detail.dynamicId = [NSString stringWithFormat:@"%ld",button.tag];
    [self presentViewController:detail animated:YES completion:nil];
}
- (void)focusButtonClicked:(UIButton *)button {
    if (button.selected) {
        return;
    }
    button.selected = !button.selected;
    if (button.selected) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [_userInfoManager postRequsetWithUrl:[NSURL URLWithString:addFocus_Url] parameters:[NSString stringWithFormat:@"focusUserId=%@&userId=16724",self.model.userID] key:addFocus_Url];
        });
    }
}
- (void)iconButtonClicked:(UIButton *)button{
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
    effectView.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
    effectView.alpha = 0;
    
    CGRect rect = button.frame;
    rect.origin.y += 65;
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:rect];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconBack:)];
    imgView.userInteractionEnabled = YES;
    [imgView addGestureRecognizer:tap];
    imgView.image = button.imageView.image;
    [effectView addSubview:imgView];
    
    [UIView animateWithDuration:0.5 animations:^{
        effectView.alpha = 1;
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
        tmpVisual.alpha = 0;
    } completion:^(BOOL finished) {
        [tmp removeFromSuperview];
        [tmpVisual removeFromSuperview];
    }];
}
- (void)fecthFailuredForKey:(NSString *)key{
    [self userAlert:@"网络不给力"];
    
}
- (void)fecthNetData:(NSData *)data key:(NSString *)key{
    if ([key isEqualToString:addFocus_Url]) {
        [self userAlert:@"操作成功"];
        return;
    }
    if ([key isEqualToString:getUserDynamics_Url]) {
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        [_userDetailView addDynamicView:arr];
        return;
    }
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    UserModel *model = [UserModel userModelWithDictionary:dic];
    [_userDetailView configureWithModel:model];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)userAlert:(NSString *)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        ;
    }];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}
@end
