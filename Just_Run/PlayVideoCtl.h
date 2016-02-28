//
//  PlayVideo.h
//  Just_Run
//
//  Created by aoyolo on 15/8/30.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FocusModel;
@protocol PlayVideoDelegate <NSObject>

- (void)dismissPlay;

@end
@interface PlayVideoCtl : UIViewController
@property (nonatomic, weak) id<PlayVideoDelegate> delegate;
@property (nonatomic, copy) NSString *videoUrl;
@end
