//
//  MatchDetilView.m
//  Just_Run
//
//  Created by aoyolo on 15/9/6.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import "MatchDetailView.h"
#import "MatchDetailNewsCell.h"
@implementation MatchDetailView{
    UITextView *_introduceView;
    UIScrollView *_detailRoutingView;
    UITableView *_matchDetailNewsTableView;
    UIView *_matchDetailTeamsView;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setView];
    }
    return self;
}
- (void)setView {
    self.pagingEnabled = YES;
    self.contentSize = CGSizeMake(4*WIDTH, 0);
    [self addIntroduceView];
    [self addDetailRoutingView];
    [self addDetailNewsTableView];
    [self addDetailTeamView];
}
- (void)addIntroduceView {
    _introduceView = [[UITextView alloc] initWithFrame:self.bounds];
    _introduceView.userInteractionEnabled = NO;
    _introduceView.font = TopicFont(25);
    [self addSubview:_introduceView];
}
- (void)addDetailRoutingView{
    _detailRoutingView = [[UIScrollView alloc] initWithFrame:CGRectMake(WIDTH, 0, WIDTH, self.bounds.size.height)];
    _detailRoutingView.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    label.text = @"长草期。。。";
    label.center = CGPointMake(WIDTH/2, HEIGHT/2-30);
    [_detailRoutingView addSubview:label];
    _detailRoutingView.pagingEnabled = NO;
    [self addSubview:_detailRoutingView];
}
- (void)addDetailNewsTableView {
    _matchDetailNewsTableView = [[UITableView alloc] initWithFrame:CGRectMake(2*WIDTH, 0, WIDTH, self.bounds.size.height)];
    
    [_matchDetailNewsTableView registerNib:[MatchDetailNewsCell nib] forCellReuseIdentifier:matchDetailNewsCellIndetifier];
    _matchDetailNewsTableView.rowHeight = 80;
    [self addSubview:_matchDetailNewsTableView];
}
- (void)addDetailTeamView{
    _matchDetailTeamsView = [[UIView alloc] initWithFrame:CGRectMake(3 * WIDTH, 0, WIDTH, self.bounds.size.height)];
    UILabel *label = [[UILabel alloc] initWithFrame:(CGRect){self.center,{100,50}}];
    label.text = @"暂无球队";
    label.font = TopicFont(25);
    [_matchDetailTeamsView addSubview:label];
    [self addSubview:_matchDetailTeamsView];
}
- (UITextView *)introduceView {
    return _introduceView;
}
- (UIScrollView *)detailRoutingView{
    return  _detailRoutingView;
}
- (UITableView *)detailNewsTableView {
    return _matchDetailNewsTableView;
}
- (UIView *)detailTeamsView{
    return  _matchDetailTeamsView;
}
@end
