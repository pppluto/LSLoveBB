//
//  BKTabBarCtlViewController.m
//  Just_Run
//
//  Created by aoyolo on 15/8/18.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import "BKTabBarCtlViewController.h"
#import "TarBarView.h"
#import "NewsViewController.h"
#import <WebKit/WebKit.h>
#import "MenuView.h"
#import "MyAnimation.h"
#import "LSBubbleDragView.h"

static const CGFloat tabbarH = 50;
@interface BKTabBarCtlViewController() <TarBarViewDelegate, MenuViewDelegate>
{
    UIButton *_currentButton;
    UIView *coverView;
    TarBarView *_tarbarView;
    MenuView *_menuView;
    LSBubbleDragView *_newMarkView;
}
@end

@implementation BKTabBarCtlViewController
#pragma mark - event cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
}

#pragma mark  菜单按钮动画
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    if (touch.view.tag == 12) {
        _tarbarView.userInteractionEnabled = NO;
        [_menuView  startAnimationWithKey:NSMenuOperationOpen];
    } else if(touch.view == _menuView) {
        _tarbarView.userInteractionEnabled = YES;
        [_menuView startAnimationWithKey:NSMenuOperationClose];
    } else {
        return;
    }
    [_tarbarView startLayerAnimation];
}
#pragma mark  -event response
#pragma mark 控制器界面跳转
- (void)buttonClicked:(UIButton *)button{
    if (button == _currentButton) {
        return;
    }
    _currentButton.selected = NO;
    _currentButton = button;
    _currentButton.selected = YES;
    coverView = [self.view snapshotViewAfterScreenUpdates:NO];
    CALayer *maskLayer = [CALayer layer];
    maskLayer.contents = (id)[UIImage imageNamed:@"logo"].CGImage;
    maskLayer.position = coverView.center;
    maskLayer.bounds = CGRectMake(0, 0, 1000,1000);
    coverView.layer.mask = maskLayer;
    
    CGRect finalBounds = CGRectMake(0, 0, 1, 1);
    CGRect secondBounds = CGRectMake(0, 0, 50, 50);
    CGRect initialBounds  = CGRectMake(0, 0, 2000, 2000);
    NSArray *values = @[[NSValue valueWithCGRect:initialBounds],[NSValue valueWithCGRect:secondBounds],[NSValue valueWithCGRect:finalBounds]];
    [self.view addSubview:coverView];
    CAKeyframeAnimation *animation = [MyAnimation getKeyFrameAnimationWithKeyPath:@"bounds" andValues:values];
    animation.delegate = self;
    self.selectedIndex = button.tag>12?button.tag-11:button.tag-10;
    [coverView.layer.mask addAnimation:animation forKey:@"transition"];
}
- (void)menuButtonCliced:(UIButton *)button{
    NSLog(@"%ld-->clicked",button.tag);
}
#pragma mark -layer delegate
- (void)animationDidStop:(CAKeyframeAnimation *)anim finished:(BOOL)flag{
    [coverView removeFromSuperview];
}
#pragma mark -private
#pragma mark 初始设置
- (void)setUp{
    _newMarkView = [[LSBubbleDragView alloc] initWithPoint:CGPointMake(10, 10) containView:_tarbarView];
    _newMarkView.viscosity = 35;
    _newMarkView.bubbleColor = [UIColor yellowColor];
    _newMarkView.bubbleLabel.text = @"new";
    _newMarkView.bubbleLabel.textColor = [UIColor whiteColor];
    _newMarkView.bubbleWidth = 20;
    [_newMarkView setUp];

//    coverView = [[UIView alloc] initWithFrame:self.view.frame];
    _tarbarView = [[TarBarView alloc] initWithFrame:CGRectMake(0, HEIGHT-tabbarH, WIDTH , tabbarH)];
    _tarbarView.delegate = self;
    _menuView = [[MenuView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    _menuView.delegate = self;
    [self.view addSubview:_menuView];
    [self.view addSubview:_tarbarView];
    self.tabBar.hidden = YES;
    _currentButton = (UIButton *)[_tarbarView viewWithTag:10];
    _currentButton.selected = YES;
  }
#pragma mark - public
- (UIView *)tabBarBar{
    return _tarbarView;
}
#pragma mark - test

@end
