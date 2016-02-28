//
//  NetDataManager.h
//  Just_Run
//
//  Created by aoyolo on 15/8/21.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol NetDataManagerDelegate <NSObject>
//成功接收数据，传回代理
@optional
- (void)fecthNetData:(NSData *)data key:(NSString *)key;
- (void)fecthFailuredForKey:(NSString *)key;
@end

@interface NetDataManager : NSObject
@property (nonatomic, weak) id<NetDataManagerDelegate> netDataDelegate;
#pragma mark -查询本地，没有则发起请求
- (void)getDataWithUrl:(NSURL *)url parameters:(NSString *)parameters key:(NSString *)key;
#pragma mark -发送网络请求  刷新数据时
- (void)sendRequestWithUrl:(NSURL *)url key:(NSString *)key;

- (void)postRequsetWithUrl:(NSURL *)url parameters:(id)parameters key:(NSString *)key;
#pragma mark -本地数据存取
- (void)storeData:(NSData *)data Key:(NSString *)key;
@end
