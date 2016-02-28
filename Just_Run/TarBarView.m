//
//  TarBarView.m
//  Just_Run
//
//  Created by aoyolo on 15/8/18.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import "TarBarView.h"


static const NSInteger Columns = 5;

@interface TarBarView ()
{
    UIView *_menuView;
    CALayer *_menuImageLayer;
    UIDynamicAnimator *_animator;
    NSMutableArray *_animationArr1;
    NSMutableArray *_animationArr2;
}
@end


@implementation TarBarView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadView];
    }
    return self;
}

- (void)loadView{
//    NSArray *itemsNameArray = @[@"资讯",@"视频",@"发现",@"ShowTime"];
    NSArray *itemsNormalImageArray = @[@"tab-timeline@2x.png",@"tab-nearby@2x.png",@"close.png",@"tab-message@2x.png",@"tab-me@2x.png"];
    NSArray *itemsSelectedImageArray = @[@"tab-timeline-select@2x.png",@"tab-nearby-select@2x.png",@"close.png",@"tab-message-select@2x.png",@"tab-me-select@2x.png"];
    CGFloat tabbarButtonW = self.bounds.size.width/Columns;
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 1)];
    lineView.backgroundColor  = [UIColor lightGrayColor];
    self.backgroundColor = MYRGB(240, 240, 240);
    [self addSubview:lineView];
    for (int i = 0; i < Columns; i++) {
        if (i == 2) {
            UIView *img = [[UIView alloc] initWithFrame:CGRectMake(i*tabbarButtonW, 1, tabbarButtonW, self.bounds.size.height-1)];
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"close.png" withExtension:nil]] scale:2];
            _menuImageLayer = [CALayer layer];
            _menuImageLayer.frame = CGRectMake(img.bounds.size.width/2-16,img.bounds.size.height/2-16, 32, 32);
            _menuImageLayer.contents = (__bridge id)image.CGImage;
            _menuImageLayer.affineTransform = CGAffineTransformRotate(_menuImageLayer.affineTransform, M_PI_4);
            [img.layer addSublayer:_menuImageLayer];
            img.userInteractionEnabled = YES;
            img.backgroundColor = TopicColor;
            img.tag = 10+i;
            [self addSubview:img];
        } else {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(i*tabbarButtonW, 1, tabbarButtonW, self.bounds.size.height-1);

            [button setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[[NSBundle mainBundle] URLForResource:itemsNormalImageArray[i] withExtension:nil]] scale:2] forState:UIControlStateNormal];
            [button setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[[NSBundle mainBundle] URLForResource:itemsSelectedImageArray[i] withExtension:nil]] scale:2] forState:UIControlStateSelected];
            button.imageView.contentMode = UIViewContentModeScaleAspectFit;
            button.titleLabel.textAlignment = NSTextAlignmentCenter;
            button.tag = 10+i;
            [button addTarget:self.delegate action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
        }
    }
}
- (void)startLayerAnimation{
    [CATransaction begin];
    [CATransaction setAnimationDuration:0.5];
    _menuImageLayer.affineTransform = CGAffineTransformRotate(_menuImageLayer.affineTransform, M_PI_4);
    [CATransaction commit];
}

@end











