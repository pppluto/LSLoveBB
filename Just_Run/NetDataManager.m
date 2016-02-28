//
//  NetDataManager.m
//  Just_Run
//
//  Created by aoyolo on 15/8/21.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import "NetDataManager.h"
#import "ASIHTTPRequest.h"
#import "DBManager.h"
@interface NetDataManager() <ASIHTTPRequestDelegate>
{
    ASIHTTPRequest *_httpRequest;
}
@end
@implementation NetDataManager
#pragma mark
- (void)sendRequestWithUrl:(NSURL *)url key:(NSString *)key{
    NSLog(@"get begin");
    _httpRequest = [ASIHTTPRequest requestWithURL:url];
    //标记
    _httpRequest.userInfo = @{@"key":key};
    _httpRequest.delegate = self;
    [_httpRequest startAsynchronous];
}

- (void)postRequsetWithUrl:(NSURL *)url parameters:(id)parameters key:(NSString *)key{
    NSLog(@"post begin");
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //设置请求方法 默认GET
    request.HTTPMethod = @"POST";
    //构造POST请求的参数
    NSString *bodyStr = (NSString *)parameters;
    NSData *bodyData = [bodyStr dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPBody = bodyData;
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            [self.netDataDelegate fecthFailuredForKey:key];
        } else {
            NSString *JsonStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            [self.netDataDelegate fecthNetData:data key:key];
        }
    }];
}

#pragma mark ASI代理

- (void)requestStarted:(ASIHTTPRequest *)request{
    NSLog(@"数据请求发送开始");
}
- (void)requestFailed:(ASIHTTPRequest *)request{
    
    NSLog(@"failed");
}
- (void)requestFinished:(ASIHTTPRequest *)request{
//    NSString *JsonStr = [[NSString alloc] initWithData:request.responseData encoding:NSUTF8StringEncoding];

    [self.netDataDelegate fecthNetData:request.responseData key:request.userInfo[@"key"]];
}
#pragma mark - 存储数据
- (void)storeData:(NSData *)data Key:(NSString *)key {
    NSData *storedData =[[DBManager sharedInstance] dataWithKey:key];
    if (storedData) {
        [[DBManager sharedInstance] updataDataInDatabase:data key:key];
    } else {
        [[DBManager sharedInstance] insertDataToDatabase:data key:key];
    }
}
- (NSData *)dataWithKey:(NSString *)key {
    return [[DBManager sharedInstance] dataWithKey:key];
}
- (void)getDataWithUrl:(NSURL *)url
         parameters:(NSString *)parameters
                key:(NSString *)key {
    NSLog(@"get data  -->%@",[NSThread currentThread]);
    NSData *data = [self dataWithKey:key];
    if (data) {
        [self.netDataDelegate fecthNetData:data key:key];
    } else {
        [self postRequsetWithUrl:url parameters:parameters key:key];
    }
}
@end





