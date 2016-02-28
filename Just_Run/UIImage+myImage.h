//
//  UIImage+myImage.h
//  Just_Run
//
//  Created by aoyolo on 15/8/31.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (myImage)
+ (CGFloat)imageHeightBaseOnWidth:(UIImage *)image width:(CGFloat)width;
+ (UIImage *)imageNamed:(NSString *)name scale:(CGFloat)scale;
@end
