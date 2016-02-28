//
//  ConfigureCtl.h
//  Just_Run
//
//  Created by aoyolo on 15/9/8.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ConfigureCtl;
@protocol ConfigureCtlDelegate <NSObject>

- (void)dismissConfigureCtl;

@end
@interface ConfigureCtl : UIViewController
@property (nonatomic, weak) id<ConfigureCtlDelegate> delegate;
@end
