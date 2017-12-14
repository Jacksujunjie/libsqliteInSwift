# libsqliteInSwift
swift的工程中调用libsqlite3库操作数据库，包含了swift与Objective-C的混编要点。

swift语言中没有原生模块可以支持SQLite数据库进行操作，所以需要用到xcode开发工具的Objective-C与swift的混编功能。

1.在创建好的swift的工程中，新创建一个用来操作libsqlite3.0库的类，将语言选为Objective-C，命名为LibsqliteHander；
首次添加Objective-C的类会弹框提示你 “would you like to configure an Objective-C bridging header”,选择默认“create bridging header”就行了；
他会自动生成一个名为SQLiteOfSwift-Bridging-Header的头文件，并且自动配置好桥接文件。

如果没有头文件添加提示，而且工程中没有已有的头文件，就要手动添加头文件SQLiteOfSwift-Bridging-Header，
配置好桥接文件： TARGETS-->> Build Setting-->> Swift compiler-General-->>Objective-C Bringing header(添加头文件路径)

2.在工程引入libsqlite库：TARGETS-->> Build Phase -->> Link Binary With LIbraries -->>添加libsqlite3.0.tbd。
3.在LibsqliteHander.h文件中编写代码如下：
//执行非查询语句的方法；
/*
 *param sqlString 执行的非查询的SQL语句
 */
+ (void)runNormalSql:(NSString *)sqlString;

//查询数据
+ (void)selectSql;

4.在LibsqliteHander.m文件中编写实现代码：
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

5.在ViewController.swift的viewDidLoad()方法中添加测试代码： 
override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        LibsqliteHander.runNormalSql("create table if not exists Student(name text PRIMARY KEY,age integer DEFAULT 15)");
        
        LibsqliteHander.runNormalSql("insert into Student(name,age) values(\"杰1\",19)")
        LibsqliteHander.runNormalSql("insert into Student(name,age) values(\"杰2\",18)")
        LibsqliteHander.runNormalSql("insert into Student(name,age) values(\"杰3\",17)")
        
        LibsqliteHander.selectSql();
    }
    
6.有兴趣的朋友，可以在细化一下，封装libsqlite3.0的开启、关闭、增删改查等，网上有很多的关于这方面的文章。

