//
//  LibsqliteHander.m
//  libsqliteInSwift
//
//  Created by 苏俊杰 on 2017/12/14.
//  Copyright © 2017年 苏俊杰. All rights reserved.
//

#import "LibsqliteHander.h"


@implementation LibsqliteHander


+ (void)runNormalSql:(NSString *)sqlString
{
    sqlite3 *sqlite3_db;
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *file = [NSString stringWithFormat:@"%@/myDB.sqlite",path];
    
    int code = sqlite3_open([file UTF8String], &sqlite3_db);
    
    char *error;
    sqlite3_exec(sqlite3_db, [sqlString UTF8String], NULL, NULL, &error);
    
    if (code== SQLITE_OK)
    {
        NSLog(@"执行成功");
    }
    else
    {
        NSLog(@"执行失败");
    }
    
    sqlite3_close(sqlite3_db);
}

+ (void)selectSql
{
    sqlite3 *sqlite3_db;
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *file = [path stringByAppendingString:@"/myDB.sqlite"];
    
    sqlite3_open([file UTF8String], &sqlite3_db);
    
    sqlite3_stmt *stmt;
    sqlite3_prepare_v2(sqlite3_db, [@"select * from Student" UTF8String], -1, &stmt, NULL);
    
    while (sqlite3_step(stmt) == SQLITE_ROW) {
        NSString *name = [NSString stringWithCString:(const char *)sqlite3_column_text(stmt, 0) encoding:NSUTF8StringEncoding];
        int age = sqlite3_column_int(stmt, 1);
        
        NSLog(@"name:%@,age:%d",name,age);
    }
    
    sqlite3_finalize(stmt);
    
    sqlite3_close(sqlite3_db);
}


@end
