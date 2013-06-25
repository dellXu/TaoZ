//
//  getUserInfo.m
//  TaoZ
//
//  Created by xudeliang on 13-5-30.
//  Copyright (c) 2013年 陶朱网络. All rights reserved.
//

#import "getUserInfo.h"
#import <JSONKit/JSONKit.h>
#define DBNAME      @"taoz.sqlite"
//#define TABLENAME   @"userInfo"
#define TABLENAME   @"info"
#define USERID      @"userID"
#define USERINFO    @"userinfo"
#define USERPWD     @"userpwd"
#define USERACCOUNT @"userAccount"
@implementation getUserInfo
#pragma mark 打开/创建数据库
-(BOOL)dbOpendatabase
{
    //在ios5系统后，数据库明确要求放在Caches文件夹目录下了。不然审核通不过
    //NSString * documents =[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask,YES) objectAtIndex:0];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingPathComponent:DBNAME];
    //open database
    if (sqlite3_open([database_path UTF8String], &db) != SQLITE_OK)
    {
        sqlite3_close(db);
        NSLog(@"数据库打开失败");
        return NO;
    }
    //create table
    //NSString *sqlCreateTable = @"CREATE TABLE IF NOT EXISTS userInfo (userID INTEGER PRIMARY KEY AUTOINCREMENT)";
    NSString *sqlCreateTable = @"CREATE TABLE IF NOT EXISTS info (userID INTEGER PRIMARY KEY AUTOINCREMENT,userAccount TEXT,userpwd TEXT,userinfo TEXT)";

    if ([self execSql:sqlCreateTable])
    {
        return YES;
    }
    return NO;
}

//获取用户userid
-(long int)getUserUserid
{
    if ([self dbOpendatabase])
    {
        long int userID = 0;
        NSString *sql1 = [NSString stringWithFormat:
                          @"SELECT userId FROM '%@' ",TABLENAME];
        sqlite3_stmt * statement;
        if (sqlite3_prepare_v2(db, [sql1 UTF8String], -1, &statement, nil) == SQLITE_OK) {
            while (sqlite3_step(statement) == SQLITE_ROW) {
                userID  = sqlite3_column_int(statement,0);
                
            }
        }else
        {
            userID = -1;
        }
        return userID;
    }
    return -1;
}

//执行数据库语句
-(BOOL)execSql:(NSString *)sql
{
    char *err;
    if(sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK)
    {
        sqlite3_close(db);
        NSLog(@"数据库操作失败,err = %s",err);
        return NO;
    }
    //sqlite3_close(db);
    return YES;
}

//获取用户信息
-(NSDictionary *)getUserUserInfo
{
    if ([self dbOpendatabase])
    {
        NSString *sql1 = [NSString stringWithFormat:
                          @"SELECT userinfo  FROM '%@'",TABLENAME];
        sqlite3_stmt * statement;
        //char *userinfo = nil;
        if (sqlite3_prepare_v2(db, [sql1 UTF8String], -1, &statement, nil) == SQLITE_OK) {
            while (sqlite3_step(statement) == SQLITE_ROW) {
                //NSString *name=[[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 0) encoding:NSUTF8StringEncoding];
                NSString *name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                NSDictionary *userInfoDic= [[NSDictionary alloc ]init];
                userInfoDic = [name objectFromJSONString];
                return userInfoDic;
            }
        } 
    }
    return nil;
}
//获取用户帐号，密码
-(NSArray *)getUserAccountAndPwd
{
    if ([self dbOpendatabase])
    {
        NSString *sql1 = [NSString stringWithFormat:
                          @"SELECT userAccount,userPwd  FROM '%@'",TABLENAME];
        sqlite3_stmt * statement;
        //char *userinfo = nil;
        if (sqlite3_prepare_v2(db, [sql1 UTF8String], -1, &statement, nil) == SQLITE_OK) {
            while (sqlite3_step(statement) == SQLITE_ROW) {
                //NSString *name=[[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 0) encoding:NSUTF8StringEncoding];
                NSString *account = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                NSString *pwd = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                NSArray *ary = [NSArray arrayWithObjects:account,pwd,nil];
                return ary;
            }
        }
    }
    return nil;
}
//保存用户信息 用户登录，插入userinfo为防止数据重复，先删除要插入的数据，然后再插入数据
-(BOOL)saveUserinfoTosqlite:(NSDictionary *)userinfoDic userID:(NSInteger)userid userPwd:(NSString *)userpwd userAccount:(NSString *)useraccount
{
    if ([self dbOpendatabase])
    {
        //预防插入重复数据，先删除表内相关数据（若存在则被删除)
        NSString *sql1 = [NSString stringWithFormat:
                          @"DELETE FROM '%@' WHERE %@ = '%d'",TABLENAME,USERID,userid];
        if ([self execSql:sql1])
        {
            //插入搜索记录
//            NSString *sql2 = [NSString stringWithFormat:
//                              @"INSERT INTO '%@' ('%@','%@') VALUES ('%d','%@')",TABLENAME,USERID,USERINFO,userid,[userinfoDic JSONString]];
            NSString *sql2 = [NSString stringWithFormat:
                              @"INSERT INTO '%@' ('%@','%@','%@','%@') VALUES ('%d','%@','%@','%@')",TABLENAME,USERID,USERACCOUNT,USERPWD,USERINFO,userid,useraccount,userpwd,[userinfoDic JSONString]];
            if ([self execSql:sql2])
            {

                return  YES;
            }
        }
    }

    return  NO;

}
@end
