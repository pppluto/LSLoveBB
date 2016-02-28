//
//  DetailTableViewController.h
//  Just_Run
//
//  Created by aoyolo on 15/8/26.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^BLOCK)(NSString *);
@interface DetailsController : UIViewController
@property (nonatomic, copy) NSDictionary *placesDict;
@property (nonatomic, copy) BLOCK block;
@end
