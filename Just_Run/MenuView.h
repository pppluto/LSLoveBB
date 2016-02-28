//
//  TarbarCtlView.h
//  Just_Run
//
//  Created by aoyolo on 15/8/28.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, NSMenuOperationKey) {
    NSMenuOperationOpen,
    NSMenuOperationClose
};

@protocol MenuViewDelegate <NSObject>

- (void)menuButtonCliced:(UIButton *)button;
@end

@interface MenuView : UIView
@property (nonatomic, weak) id<MenuViewDelegate> delegate;
- (void)startAnimationWithKey:(NSMenuOperationKey)key;
@end
