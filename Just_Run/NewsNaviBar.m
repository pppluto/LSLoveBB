//
//  NewsView.m
//  Just_Run
//
//  Created by aoyolo on 15/8/19.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import "NewsNaviBar.h"
#import "FocusCell.h"
#import "FocusCell.h"
static CGFloat buttonW = 60;
static CGFloat buttonH = 30;
@interface NewsNaviBar()
{
    UIView *_navigationBar;
    UITableView *_newsTableView;
    CALayer *_buttonBottomLayer;
    
}
@end
@implementation NewsNaviBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setView];
    }
    return self;
}
- (void)setView{
    NSArray *arr = @[@"关注",@"热门",@"最新"];
    
    self.backgroundColor = TopicColor;
    for (int i = 0; i<3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(WIDTH/2-buttonW*3/2+i*buttonW, 25, buttonW, buttonH);
        button.titleLabel.font = TopicFont(20);
        [button setTitle:arr[i] forState:UIControlStateNormal];
        button.tag = 30+i;
        [button addTarget:self.newsDelegate action:@selector(newsButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    UIButton *tmp = (UIButton *)[self viewWithTag:30];
    _buttonBottomLayer = [CALayer layer];
    _buttonBottomLayer.position = CGPointMake(tmp.center.x, tmp.center.y+15);
    _buttonBottomLayer.bounds = CGRectMake(0, 0, buttonW/2, 5);
    _buttonBottomLayer.backgroundColor = [UIColor whiteColor].CGColor;
    _buttonBottomLayer.cornerRadius = 2.5;
    [self.layer addSublayer:_buttonBottomLayer];
    
}
- (void)setSelectedButton:(UIButton *)button{
    UIButton *selectedButton = (UIButton *)[self viewWithTag:button.tag];
    _buttonBottomLayer.position = CGPointMake(selectedButton.center.x,selectedButton.center.y+15);
}


@end
