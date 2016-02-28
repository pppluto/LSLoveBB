//
//  PlayVideo.m
//  Just_Run
//
//  Created by aoyolo on 15/8/30.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import "PlayVideoCtl.h"
#import "FocusModel.h"
@interface PlayVideoCtl ()
{
    UIWebView *_webView;
    UIView *_naviBar;
}
@end

@implementation PlayVideoCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setUp{
    [self addNaviBar];
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64)];
    [self.view addSubview:_webView];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.videoUrl]];
    [_webView loadRequest:request];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    NSLog(@"视频消失");

}
- (void)addNaviBar{
    _naviBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 64)];
    _naviBar.backgroundColor = TopicColor;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 30, 50, 30);
    [button setImage:[UIImage imageNamed:@"navi-back.png"] forState:UIControlStateNormal];
    [button addTarget:self.delegate action:@selector(dismissPlay) forControlEvents:UIControlEventTouchUpInside];
    [_naviBar addSubview:button];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(_naviBar.center.x-50,_naviBar.center.y-10, 100, 30)];
    label.font = TopicFont(20);
    label.textColor = [UIColor whiteColor];
    label.text = @"详情";
    label.textAlignment = NSTextAlignmentCenter;
    [_naviBar addSubview:label];
    [self.view addSubview:_naviBar];
}
@end
