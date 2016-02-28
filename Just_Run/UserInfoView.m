//
//  UserInfoView.m
//  Just_Run
//
//  Created by aoyolo on 15/9/7.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import "UserInfoView.h"
#import "UserModel.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
@implementation UserInfoView{
    UIScrollView *backScrollView;
    UILabel *nameLabel;
    UIButton *userIconButton;
    UIButton *rightButton;
    UIButton *backButton;
    UIButton *focusButton;
    CGFloat  seperateLine;
    CGFloat marginLabelH;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-65)];
        marginLabelH = 20;
        seperateLine = 380;
        [self addSubview:backScrollView];
        [self initial];
    }
    return self;
}
- (void)initial{
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 64)];
    topView.backgroundColor = TopicColor;
    backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"navi-back.png"] forState:UIControlStateNormal];
    backButton.frame = CGRectMake(10, 20, 48, 48);
    [backButton addTarget:self.delegate action:@selector(backButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:backButton];
    rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(WIDTH-60, 10, 48, 48);
    
    [rightButton setImage:[UIImage imageNamed:@"user-profile-setting.png"] forState:UIControlStateNormal];
    [rightButton addTarget:self.delegate action:@selector(rightButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    rightButton.hidden = YES;
    [topView addSubview:rightButton];
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 30, WIDTH-120, 30)];
    nameLabel.font = TopicFont(20);
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.text = @"等待数据";
    [topView addSubview:nameLabel];
    [self addSubview:topView];
    
    userIconButton = [UIButton buttonWithType:UIButtonTypeCustom];
    userIconButton.frame = CGRectMake(WIDTH/2-50, 10, 100, 100);
    userIconButton.layer.cornerRadius = 50;
    userIconButton.clipsToBounds = YES;
    [userIconButton setImage:[UIImage imageNamed:@"sticker3"] forState:UIControlStateNormal];
    [userIconButton addTarget:self.delegate action:@selector(iconButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [backScrollView addSubview:userIconButton];
    focusButton = [UIButton buttonWithType:UIButtonTypeCustom];
    focusButton.frame = CGRectMake(WIDTH/2+60, 30, 50, 20);
    focusButton.backgroundColor = [UIColor whiteColor];
    focusButton.titleLabel.font = FT(15);
    [focusButton setTitle:@"关注" forState:UIControlStateNormal];
    [focusButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [focusButton setTitle:@"已关注" forState:UIControlStateSelected];
    [focusButton setTitleColor:TopicColor forState:UIControlStateSelected];
    [focusButton addTarget:self.delegate action:@selector(focusButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [backScrollView addSubview:focusButton];

}
- (void)configureWithModel:(UserModel *)model{
    nameLabel.text = model.userName;
    [userIconButton sd_setImageWithURL:[NSURL URLWithString:model.userImg] forState:UIControlStateNormal];
    focusButton.selected = model.isFocused;
    
    UILabel *infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(userIconButton.frame)+marginLabelH, WIDTH-40, 40)];
    infoLabel.font = TopicFont(25);
    infoLabel.text = @"个人档案";
    infoLabel.textAlignment = NSTextAlignmentCenter;
    infoLabel.textColor = TopicColor;
    infoLabel.layer.cornerRadius = 10;
    infoLabel.layer.borderColor = TopicColor.CGColor;
    infoLabel.layer.borderWidth = 2;
    [backScrollView addSubview:infoLabel];

    UILabel *home = [self labelWithTitle:[NSString stringWithFormat:@"主场: %@->%@",model.area,model.userTeam] alignment:NSTextAlignmentCenter];
    home.frame = CGRectMake(20, CGRectGetMaxY(infoLabel.frame)+marginLabelH, WIDTH-40, 30);
    [backScrollView addSubview:home];
    
    UILabel *userH = [self labelWithTitle:[NSString stringWithFormat:@"身高:%@",model.userHeight] alignment:NSTextAlignmentCenter];
    userH.frame = CGRectMake(20, CGRectGetMaxY(home.frame)+marginLabelH, WIDTH-40, 30);
    [backScrollView addSubview:userH];
    UILabel *userW = [self labelWithTitle:[NSString stringWithFormat:@"体重:%@",model.userWeight] alignment:NSTextAlignmentCenter];
    userW.text = userW.text.intValue?userW.text:@"体重:保密";
    userW.frame = CGRectMake(20, CGRectGetMaxY(userH.frame)+marginLabelH, WIDTH-40, 30);
    [backScrollView addSubview:userW];
    
    UILabel *weChat = [self labelWithTitle:[NSString stringWithFormat:@"WeChat:%@",model.weChat] alignment:NSTextAlignmentCenter];
    weChat.frame = CGRectMake(20, CGRectGetMaxY(userW.frame)+marginLabelH, WIDTH-40, 30);
    [backScrollView addSubview:weChat];
    
//    seperateLine = CGRectGetMaxY(weChat.frame)+10;
    NSLog(@"%f",seperateLine);

    
}
- (void)addDynamicView:(NSArray *)arr{
    CGFloat marginW = 10;
    CGFloat DynamicW = (WIDTH-30)/2;
    CGFloat DynamicH = DynamicW;
    for (int i = 0; i < arr.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(marginW+i%2*(marginW+DynamicW), seperateLine+marginLabelH + i/2*(marginW+DynamicW), DynamicW, DynamicH);
        button.clipsToBounds = YES;
        button.layer.cornerRadius = 10;
        button.tag = [arr[i][@"dynamic_id"] integerValue];
        [button sd_setImageWithURL:[NSURL URLWithString:arr[i][@"dynamic_img"]] forState:UIControlStateNormal];
        [button addTarget:self.delegate action:@selector(dynamicButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [backScrollView addSubview:button];
    }
    backScrollView.contentSize = CGSizeMake(WIDTH, HEIGHT+arr.count/2*(DynamicH+marginW));
}
- (void)setRightButtonHidden:(BOOL)rHidden leftButtonHidden:(BOOL)lHidden{
    rightButton.hidden = rHidden;
    focusButton.hidden = !rightButton.hidden;
    backButton.hidden = lHidden;
}
- (UILabel *)labelWithTitle:(NSString *)title alignment:(NSTextAlignment)alignment{
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = alignment;
    
    label.text = title.length?title:@"保密";
    label.font = TopicFont(20);
    label.layer.borderWidth = 1;
    label.layer.cornerRadius = 5;
    label.layer.borderColor = [UIColor lightGrayColor].CGColor;
    return label;
}
@end
