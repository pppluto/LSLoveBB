//
//  TarbarCtlView.m
//  Just_Run
//
//  Created by aoyolo on 15/8/28.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import "MenuView.h"
#import "TarBarView.h"
@interface MenuView ()
{
    UIDynamicAnimator *_animator;
    NSMutableArray *_animationArr1;
    NSMutableArray *_animationArr2;
}
- (void)menuAnimation:(void (^)(void))block;
@end
@implementation MenuView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setMenuButton];
    }
    return self;
}
- (void)setMenuButton{
    self.backgroundColor = [UIColor blackColor];
    self.alpha = 0;
    _animationArr1 = [@[] mutableCopy];
    _animationArr2 = [@[] mutableCopy];
    NSArray *arr = @[@"camera_btnImg.png",@"video_btnImg.png",@"card_btnImg.png"];
    for (int i = 0; i<3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(self.center.x,self.bounds.size.height, 40, 40);
        [button setImage:[UIImage imageNamed:arr[i]] forState:UIControlStateNormal];
        button.contentMode = UIViewContentModeScaleAspectFill;
        button.tag = 50+i;
        button.alpha = 1;
        UISnapBehavior *snap1 = [[UISnapBehavior alloc] initWithItem:button snapToPoint:CGPointMake(self.center.x-80+i*80,HEIGHT-150-(i%2)*50)];
        snap1.damping = 0.5;
        [_animationArr1 addObject:snap1];
        UISnapBehavior *snap2 = [[UISnapBehavior alloc] initWithItem:button snapToPoint:CGPointMake(self.center.x,HEIGHT-40)];
        snap2.damping = 0.5;
        [_animationArr2 addObject:snap2];
        [button addTarget:self.delegate action:@selector(menuButtonCliced:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
}
- (void)startAnimationWithKey:(NSMenuOperationKey)key{
    switch (key) {
        case NSMenuOperationOpen: {
            [self menuAnimation:^{
                self.alpha = 0.8;
                self.userInteractionEnabled = YES;
                [CATransaction setCompletionBlock:^{
                    for (UIDynamicBehavior *obj in _animationArr1) {
                        [_animator addBehavior:obj];
                    }
                }];
                
            }];
            break;
        }
        case NSMenuOperationClose: {
            [self menuAnimation:^{
                for (UIDynamicBehavior *obj in _animationArr2) {
                    [_animator addBehavior:obj];
                }
                [CATransaction setCompletionBlock:^{
                    self.alpha=0;
                    self.userInteractionEnabled = NO;
                }];
            }];
        }
            break;
        default:
            break;
    }
}
- (void)menuAnimation:(void (^)(void))block{
    [_animator removeAllBehaviors];
    [CATransaction begin];
    [CATransaction setAnimationDuration:0.5];
    block();
    [CATransaction commit];
}

@end
