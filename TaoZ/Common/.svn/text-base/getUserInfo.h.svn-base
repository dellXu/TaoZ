//
//  getUserInfo.h
//  TaoZ
//
//  Created by xudeliang on 13-5-30.
//  Copyright (c) 2013年 陶朱网络. All rights reserved.
//

//
//
//

#import <Foundation/Foundation.h>

@interface getUserInfo : NSObject
{
        sqlite3 *db;
}

-(long int)getUserUserid;
//-(BOOL)saveUserinfoTosqlite:(NSDictionary *)userinfoDic userID:(NSInteger)userid;
-(BOOL)saveUserinfoTosqlite:(NSDictionary *)userinfoDic userID:(NSInteger)userid userPwd:(NSString *)userpwd userAccount:(NSString *)useraccount;
-(NSDictionary *)getUserUserInfo;
-(NSArray *)getUserAccountAndPwd;
@end
