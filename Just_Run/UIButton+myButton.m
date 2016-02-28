//
//  UIButton+myButton.m
//  Just_Run
//
//  Created by aoyolo on 15/8/31.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import "UIButton+myButton.h"

@implementation UIButton (myButton)
//根据哈希值给对象tag赋值
- (void)setTagName:(NSString*)name
{
    self.tag = [name hash];
}

- (UIView *)viewWithName:(NSString *)name
{
    return [self viewWithTag:[name hash]];
}

- (void) autoResize:(UIViewAutoresizing)mask
{
    self.autoresizingMask = mask;
    self.autoresizesSubviews = YES;
}

- (void)setPosition:(CGRect)position
{
    self.bounds = CGRectMake(0, 0, position.size.width, position.size.height);
    self.center = CGPointMake(position.origin.x,position.origin.y);
}

+ (UIButton*) buttonWithTarget:(id)target action:(SEL)sel
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
@end
