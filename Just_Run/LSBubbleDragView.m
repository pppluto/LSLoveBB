//
//  LSBubbleDragView.m
//  LSBubbleDrag
//
//  Created by aoyolo on 15/8/28.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import "LSBubbleDragView.h"

@implementation LSBubbleDragView
{
    //填充色
    CGPoint oldBackViewCenter;
    CGRect oldBackViewFrame;
    UIColor *fillColor;
    CAShapeLayer *shapeLayer;
    UIBezierPath *cutePath;
    UIView *backView;
    UIView *containtView;
    
    CGPoint originalPoint;
    CGFloat r1;
    CGFloat r2;
    CGFloat x1;
    CGFloat y1;
    CGFloat x2;
    CGFloat y2;
    CGPoint pointA;
    CGPoint pointB;
    CGPoint pointC;
    CGPoint pointD;
    CGPoint pointO;
    CGPoint pointP;
    CGFloat centerDistance;
    CGFloat cosDigree;
    CGFloat sinDigree;

}
- (instancetype)initWithPoint:(CGPoint)point containView:(UIView *)view{
    self = [super initWithFrame:CGRectMake(point.x, point.y, self.bubbleWidth, self.bubbleWidth)];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        originalPoint = point;
        containtView = view;
        _viscosity = 10;
        [containtView addSubview:self];
    }
    return self;
}
#pragma mark - setUp
- (void)setUp{
    shapeLayer = [CAShapeLayer layer];
    self.backgroundColor = [UIColor clearColor];
    self.frontView = [[UIView alloc] initWithFrame:(CGRect){originalPoint,{self.bubbleWidth,self.bubbleWidth}}];
    self.frontView.backgroundColor = self.bubbleColor;
    r2 = self.frontView.bounds.size.width/2;
    self.frontView.layer.cornerRadius = r2;
    
    backView = [[UIView alloc] initWithFrame:self.frontView.frame];
    r1 = backView.bounds.size.width / 2;
    backView.layer.cornerRadius = r1;
    backView.backgroundColor = self.bubbleColor;
    
    self.bubbleLabel = [[UILabel alloc]init];
    self.bubbleLabel.frame = CGRectMake(0, 0, self.frontView.bounds.size.width, self.frontView.bounds.size.height);
    self.bubbleLabel.textColor = [UIColor whiteColor];
    self.bubbleLabel.textAlignment = NSTextAlignmentCenter;

    [self.frontView insertSubview:self.bubbleLabel atIndex:0];
    [containtView addSubview:self.frontView];
    [containtView addSubview:backView];
    
    backView.hidden = YES;
    [self beginBubbleShakeAnimation];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragOn:)];
    [self.frontView addGestureRecognizer:pan];
    x1 = backView.center.x;
    y1 = backView.center.y;
    x2 = self.frontView.center.x;
    y2 = self.frontView.center.y;
    
    oldBackViewCenter = backView.center;
    oldBackViewFrame = backView.frame;

    
    pointA = CGPointMake(x1-r1,y1);   // A
    pointB = CGPointMake(x1+r1, y1);  // B
    pointD = CGPointMake(x2-r2, y2);  // D
    pointC = CGPointMake(x2+r2, y2);  // C
    pointO = CGPointMake(x1-r1,y1);   // O
    pointP = CGPointMake(x2+r2, y2);  //
    
}
#pragma mark 
//每隔一帧刷新屏幕的定时器
-(void)displayLinkAction:(CADisplayLink *)dis{
    x1 = backView.center.x;
    y1 = backView.center.y;
    x2 = self.frontView.center.x;
    y2 = self.frontView.center.y;
    
    centerDistance = sqrtf((x2-x1)*(x2-x1) + (y2-y1)*(y2-y1));
    if (centerDistance == 0) {
        cosDigree = 1;
        sinDigree = 0;
    }else{
        cosDigree = (y2-y1)/centerDistance;
        sinDigree = (x2-x1)/centerDistance;
    }
    //    NSLog(@"%f", acosf(cosDigree));
    r1 = oldBackViewFrame.size.width/2 - centerDistance/self.viscosity;
    
    pointA = CGPointMake(x1-r1*cosDigree, y1+r1*sinDigree);  // A
    pointB = CGPointMake(x1+r1*cosDigree, y1-r1*sinDigree); // B
    pointD = CGPointMake(x2-r2*cosDigree, y2+r2*sinDigree); // D
    pointC = CGPointMake(x2+r2*cosDigree, y2-r2*sinDigree);// C
    pointO = CGPointMake(pointA.x + (centerDistance / 2)*sinDigree, pointA.y + (centerDistance / 2)*cosDigree);
    pointP = CGPointMake(pointB.x + (centerDistance / 2)*sinDigree, pointB.y + (centerDistance / 2)*cosDigree);
    
    [self drawRect];
}

-(void)drawRect{
    
    backView.center = oldBackViewCenter;
    backView.bounds = CGRectMake(0, 0, r1*2, r1*2);
    backView.layer.cornerRadius = r1;
    
    
    cutePath = [UIBezierPath bezierPath];
    [cutePath moveToPoint:pointA];
    [cutePath addQuadCurveToPoint:pointD controlPoint:pointO];
    [cutePath addLineToPoint:pointC];
    [cutePath addQuadCurveToPoint:pointB controlPoint:pointP];
    [cutePath moveToPoint:pointA];
    
    
    if (backView.hidden == NO) {
        shapeLayer.path = cutePath.CGPath;
        shapeLayer.fillColor = [fillColor CGColor];
        [containtView.layer insertSublayer:shapeLayer below:self.frontView.layer];
    }
    
}

#pragma mark 手势动画
- (void)dragOn:(UIPanGestureRecognizer *)gesture{
    CGPoint gesturePoint = [gesture locationInView:containtView];
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan: {
            backView.hidden = NO;
            fillColor = self.bubbleColor;
            [self RemoveAniamtion];
            break;
        }
        case UIGestureRecognizerStateChanged: {
            self.frontView.center = gesturePoint;
            if (r1 <= 6 ) {
                backView.hidden = YES;
                fillColor = [UIColor clearColor];
                [shapeLayer removeFromSuperlayer];
            }
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed: {
            backView.hidden = YES;
            fillColor = [UIColor clearColor];
            [shapeLayer removeFromSuperlayer];
           [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
               self.frontView.center = backView.center;
           } completion:^(BOOL finished) {
               if (finished) {
                   [self beginBubbleShakeAnimation];
               }
           }];
            break;
        }
        default: {
            break;
        }
    }
    [self displayLinkAction:nil];
}
#pragma mark 动画
- (void)beginBubbleShakeAnimation{
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyAnimation.duration = 5;
    keyAnimation.repeatCount = INFINITY;
    keyAnimation.fillMode = kCAFillModeForwards;
    keyAnimation.removedOnCompletion = NO;
    keyAnimation.calculationMode = kCAAnimationPaced;
    keyAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGRect rect = CGRectInset(self.frontView.frame, self.frontView.bounds.size.width/2-3, self.frontView.bounds.size.width/2-3);
    CGPathAddEllipseInRect(path, NULL, rect);
    
    keyAnimation.path = path;
    CGPathRelease(path);
    [self.frontView.layer addAnimation:keyAnimation forKey:@"positionMove"];
    
    CAKeyframeAnimation *scaleXanimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.x"];
    scaleXanimation.repeatCount = INFINITY;
    scaleXanimation.values = @[@(1),@(1.1),@(1)];
    scaleXanimation.keyTimes = @[@(0),@(0.5),@(1.0)];
    scaleXanimation.duration = 1;
    scaleXanimation.autoreverses = YES;
    scaleXanimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.frontView.layer addAnimation:scaleXanimation forKey:@"scaleX"];

    
    CAKeyframeAnimation *scaleYanimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.y"];
    scaleYanimation.repeatCount = INFINITY;
    scaleYanimation.values = @[@(1),@(1.1),@(1)];
    scaleYanimation.keyTimes = @[@(0),@(0.5),@(1.0)];
    scaleYanimation.duration = 1.5;
    scaleYanimation.autoreverses = YES;
    scaleYanimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.frontView.layer addAnimation:scaleYanimation forKey:@"scaleY"];
}
-(void)RemoveAniamtion{
    [self.frontView.layer removeAllAnimations];
}
@end













