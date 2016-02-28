//
//  MyActivityIndicatorView.m
//  Just_Run
//
//  Created by aoyolo on 15/9/7.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import "MyActivityIndicatorView.h"

@implementation MyActivityIndicatorView
{
    UIImageView *animationView;
    NSTimer *_timer;
    CADisplayLink *link;
    NSMutableArray *imgArr;
}
- (instancetype)initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyle)style{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, 40, 40);
        [self addImgView];
        _timer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(scroll) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
        
    }
    return self;
}
- (void)startAnimating{
    self.hidden = NO;
    [_timer setFireDate:[NSDate distantPast]];
    NSLog(@"定时器开启");
}
- (void)stopAnimating{
    [_timer setFireDate:[NSDate distantFuture]];
    NSLog(@"定时器暂停");
    if (_hidesWhenStopped) {
        self.hidden = YES;
    }
}
- (BOOL)isAnimating{
    return YES;
}
- (void)stopTimer{
    [_timer invalidate];
    _timer = nil;
    NSLog(@"定时器关闭");
}
- (void)addImgView{
    animationView = [[UIImageView alloc] initWithFrame:self.bounds];
    imgArr = [[NSMutableArray alloc] init];
    for (int i = 0; i<24; i++) {
        NSString *str =[NSString stringWithFormat:@"refresh%0d.png",i];
        [imgArr addObject:str];
    }
    animationView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imgArr[0] ofType:nil]];
    
    [self addSubview:animationView];
}
- (void)scroll{
    static int i = 1;
    if (i==23) {
        i = 0;
    }
    animationView.image = [UIImage imageNamed:imgArr[i]];
    i++;
}

@end
