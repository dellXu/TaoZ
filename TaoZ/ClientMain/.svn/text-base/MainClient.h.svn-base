//
//  MainClient.h
//  TaoZ
//
//  Created by xudeliang on 13-6-18.
//  Copyright (c) 2013年 陶朱网络. All rights reserved.
//

#import "AFHTTPClient.h"
#import "SDBlocks.h"
@interface MainClient : AFHTTPClient
typedef void(^AFHTTPFailureBlock)(AFHTTPRequestOperation *operation, NSError *error);
typedef void(^AFHTTPSuccessBlock)(AFHTTPRequestOperation *operation, id responseObject);

typedef void(^AFJSONFailureBlock)(NSHTTPURLResponse *response, NSError *error);

+(MainClient *)instance;
//意见反馈
-(void)appSuggestionFeedBack:(NSDictionary *)params success:(SDSenderBlock)success failure:(SDSenderBlock)failure;
//自动更新
-(void)getVersionUpdate:(NSDictionary *)params success:(SDSenderBlock)success failure:(SDSenderBlock)failure;
@end