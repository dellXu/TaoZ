//
//  SDClient.h
//  TaoZ
//
//  Created by xudeliang on 13-5-15.
//  Copyright (c) 2013年 陶朱网络. All rights reserved.
//

//#import "AFHTTPClient.h"
#import "SDBlocks.h"


typedef void(^AFHTTPFailureBlock)(AFHTTPRequestOperation *operation, NSError *error);
typedef void(^AFHTTPSuccessBlock)(AFHTTPRequestOperation *operation, id responseObject);

@interface SDClient : AFHTTPClient

+(SDClient *)instance;
#pragma mark -registerUsers
//注册用户
-(void)signupWithParams:(NSDictionary *)params success:(SDSenderBlock)success failure:(SDSenderBlock)failure;
//发送验证码
-(void)sendVerificationToMobile:(NSDictionary *)params success:(SDSenderBlock)success failure:(SDSenderBlock)failure;
//重置密码
-(void)resetPassword:(NSDictionary *)params success:(SDSenderBlock)success failure:(SDSenderBlock)failure;
//站内用户登录
-(void)loginByTaozAccount:(NSDictionary *)params success:(SDSenderBlock)success failure:(SDSenderBlock)failure;
//第三方账户登录
-(void)loginByOtherAccount:(NSDictionary *)params success:(SDSenderBlock)success failure:(SDSenderBlock)failure;

@end


