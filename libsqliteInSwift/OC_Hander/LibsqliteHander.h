//
//  LibsqliteHander.h
//  libsqliteInSwift
//
//  Created by 苏俊杰 on 2017/12/14.
//  Copyright © 2017年 苏俊杰. All rights reserved.
//

#import <Foundation/Foundation.h>
//引入头文件
#import <sqlite3.h>
@interface LibsqliteHander : NSObject


//执行非查询语句的方法；
/*
 *param sqlString 执行的非查询的SQL语句
 */
+ (void)runNormalSql:(NSString *)sqlString;

//查询数据
+ (void)selectSql;


@end
