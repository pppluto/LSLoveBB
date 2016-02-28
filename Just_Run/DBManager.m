//
//  DBManager.m
//  UI项目1
//
//  Created by aoyolo on 15/7/29.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import "DBManager.h"
#import "FMDB.h"
@interface DBManager(){
    FMDatabase *_database;
}
@end
@implementation DBManager
- (instancetype)init
{
    self = [super init];
    if (self) {
        //创建数据库
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *pathDatabase = [path stringByAppendingPathComponent:@"myDB.db"];
        _database = [[FMDatabase alloc] initWithPath:pathDatabase];
        if ([_database open]) {
            NSLog(@"数据库打开成功");
        }else{
            NSLog(@"数据库打开失败");
        }
        
        if (![_database tableExists:@"Data"]) {
            //创建表
            if([_database executeUpdate:@"create table MyData (KEY text primary key not null,Data blob)"])
                NSLog(@"表创建成功");
            
        } else {
            NSLog(@"表已经存在");
        }
    }
    return self;
}
+ (id)sharedInstance{
    static DBManager*manager = nil;
    @synchronized(self){
        if (manager == nil) {
            manager = [[DBManager alloc] init];
        }
    };
    return manager;
}
- (BOOL)insertDataToDatabase:(NSData *)data key:(NSString *)key{
    if([_database executeUpdate:@"insert into MyData (KEY,Data) values(?,?)",key,data]){
        NSLog(@"插入数据成功");
    }else{
        NSLog(@"插入失败");
    }
    return YES;
}
- (BOOL)deleteDataFromDatabase:(NSData *)data key:(NSString *)key{
    
    if([_database executeUpdate:@"delete from MyData where KEY = ?",key]){
        NSLog(@"删除成功");
    }else{
        NSLog(@"删除失败");
    }
    return YES;
}
- (BOOL)updataDataInDatabase:(NSData *)data key:(NSString *)key{
    if([_database executeUpdate:@"update MyData set Data = ? where KEY = ?",data,key]){
        NSLog(@"更新成功");
    }else{
        NSLog(@"更新失败");
    }
    return YES;
}
- (NSData *)dataWithKey:(NSString *)key{
    FMResultSet *result = [_database executeQuery:@"select * from MyData"];
    while ([result next]) {
        if ([[result stringForColumn:@"KEY"] isEqualToString:key]) {
            NSData *data = [result dataForColumn:@"Data"];
            return  data;
        }
    }
    return  nil;
}
@end
