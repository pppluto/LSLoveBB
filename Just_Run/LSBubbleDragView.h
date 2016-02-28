//
//  LSBubbleDragView.h
//  LSBubbleDrag
//
//  Created by aoyolo on 15/8/28.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSBubbleDragView : UIView
@property (nonatomic, assign) CGFloat bubbleWidth;
@property (nonatomic, strong) UIColor *bubbleColor;
@property (nonatomic, strong) UILabel *bubbleLabel;
@property (nonatomic, strong) UIView *frontView;
@property (nonatomic, assign) CGFloat viscosity;
- (instancetype)initWithPoint:(CGPoint)point containView:(UIView *)view;
- (void)setUp;
@end
