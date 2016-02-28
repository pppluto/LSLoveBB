//
//  MatchDetailChoseView.m
//  Just_Run
//
//  Created by aoyolo on 15/9/6.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import "MatchDetailChoseView.h"
static CGFloat marginW = 30;
@interface MatchDetailChoseView()
{
    UIView *_navigationBar;
    UITableView *_newsTableView;
    CALayer *_buttonBottomLayer;

}
@end

@implementation MatchDetailChoseView



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setView];
    }
    return self;
}
- (void)setView{
    NSArray *arr = @[@"简介",@"赛程",@"资讯",@"球队"];
    CGFloat buttonW = (WIDTH-5*marginW)/4.0;

    self.backgroundColor = TopicColor;
    for (int i = 0; i<arr.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(marginW+(marginW+buttonW)*i,10,buttonW,30);
        button.titleLabel.font = TopicFont(20);
        [button setTitleColor:TopicColor forState:UIControlStateNormal];
        [button setTitle:arr[i] forState:UIControlStateNormal];
        button.tag = 70+i;
        [button addTarget:self.delegate action:@selector(choseButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    UIButton *tmp = (UIButton *)[self viewWithTag:70];
    _buttonBottomLayer = [CALayer layer];
    _buttonBottomLayer.position = CGPointMake(tmp.center.x,45);
    _buttonBottomLayer.bounds = CGRectMake(0, 0, buttonW/2, 5);
    _buttonBottomLayer.backgroundColor = MYRGB(53, 140, 250).CGColor;
    _buttonBottomLayer.cornerRadius = 2.5;
    [self.layer addSublayer:_buttonBottomLayer];
    
}
- (void)setSelectedButton:(UIButton *)button{
//    UIButton *selectedButton = (UIButton *)[self viewWithTag:button.tag];
    _buttonBottomLayer.position = CGPointMake(button.center.x,45);
}


@end
