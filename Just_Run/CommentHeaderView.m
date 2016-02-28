//
//  CommentHeaderView.m
//  Just_Run
//
//  Created by aoyolo on 15/9/7.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import "CommentHeaderView.h"
#import "FocusModel.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "TagViewModel.h"
#import "LSBubbleDragView.h"
@implementation CommentHeaderView{
    UIButton *_iconButton;
    UIImageView *_bigImgView;
    UILabel *_contentLabel;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        _bigImgView = [[UIImageView alloc] init];
        self.userInteractionEnabled = YES;
        _bigImgView.userInteractionEnabled = YES;
        [self addSubview:_bigImgView];
    }
    return self;
}
- (instancetype)initWithModel:(FocusModel *)model{
    if (self = [super init]) {
        [self configureWithModel:model];
    }
    return self;
}

- (void)configureWithModel:(FocusModel *)model {
    _iconButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _iconButton.frame = CGRectMake(10, 10, 80, 80);
    _iconButton.layer.cornerRadius = 40;
    _iconButton.clipsToBounds = YES;
    [_iconButton sd_setImageWithURL:[NSURL URLWithString:model.userIcon] forState:UIControlStateNormal];
    [_iconButton addTarget:self.delegate action:@selector(iconButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_iconButton];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 30, WIDTH-100, 20)];
    label.font = TopicFont(20);
    label.text = model.userName;
    [self addSubview:label];
    UIView *imgBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 90, WIDTH, model.imgHeight+20)];
    imgBackView.backgroundColor = MYRGB(240, 240, 240);
    imgBackView.layer.cornerRadius = 5;
    imgBackView.clipsToBounds = YES;
    _bigImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, WIDTH-20, model.imgHeight)];
    _bigImgView.layer.cornerRadius = 5;
    _bigImgView.clipsToBounds = YES;
    [_bigImgView sd_setImageWithURL:[NSURL URLWithString:model.dynamicImg] placeholderImage:[UIImage imageNamed:@"sticker3.png"]];
    [imgBackView addSubview:_bigImgView];
    [self addSubview:imgBackView];
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.font = TopicFont(20);
    [self addSubview:_contentLabel];
    _contentLabel.text = model.describle;
    CGRect rect = [model.describle boundingRectWithSize:CGSizeMake(WIDTH-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:TopicFont(20)} context:nil];
    _contentLabel.frame = CGRectMake(10,model.imgHeight+110,WIDTH-20,rect.size.height);
    _contentLabel.numberOfLines = 0;
    CGFloat height = CGRectGetMaxY(_contentLabel.frame);
    UIView *separateView = [[UIView alloc] initWithFrame:CGRectMake(0, height+3, WIDTH, 2)];
    separateView.backgroundColor = MYRGB(240, 240, 240);
    [self addSubview:separateView];
    self.frame = CGRectMake(0, 0, WIDTH, height+5);
}
- (void)addTagWith:(NSArray *)arr{
    if (_bigImgView.subviews.count) {
        [_bigImgView.subviews performSelector:@selector(removeFromSuperview)];
    }
    for (TagViewModel *model in arr) {
        LSBubbleDragView *bubble = [[LSBubbleDragView alloc] initWithPoint:CGPointMake(self.bounds.size.width * ([model.x_position floatValue]), self.bounds.size.height * ([model.y_posotion floatValue])) containView:_bigImgView];
        bubble.bubbleColor = TopicColor;
        bubble.bubbleWidth = 20;
        bubble.bubbleLabel.font = FT(8);
        [bubble setUp];
        bubble.viscosity = 20;
        bubble.bubbleLabel.text = @"®";
    }
}
- (UIImageView *)picView {
    return _bigImgView;
}
- (void)setPicImageView:(UIImageView *)imgView{
    _bigImgView.frame = imgView.bounds;
    _bigImgView.image = imgView.image;
}

@end
