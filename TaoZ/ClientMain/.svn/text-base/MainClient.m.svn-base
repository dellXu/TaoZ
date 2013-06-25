//
//  MainClient.m
//  TaoZ
//
//  Created by xudeliang on 13-6-18.
//  Copyright (c) 2013年 陶朱网络. All rights reserved.
//

#import "MainClient.h"
#import "UIAlertView+BlocksKit.h"
#import "SDBlocks.h"
#import "changeAFJSONRequestOperation.h"
#import "JSONKit.h"

#define TimeoutInterval 15 //请求超时时常

@interface MainClient()
@property(nonatomic, copy) AFJSONFailureBlock failureBlock;
@end


@implementation MainClient

+(MainClient *)instance {
    static dispatch_once_t _singletonPredicate;
    static MainClient *_singleton = nil;
    
    dispatch_once(&_singletonPredicate, ^{
        _singleton = [[super allocWithZone:nil] init];
    });
    
    return _singleton;
}

+ (id) allocWithZone:(NSZone *)zone {
    return [self instance];
}

- (id)init
{
    
    NSString * base = [NSString stringWithFormat:@"http://%@/api",TAOZHU_HOST];
 
    NSURL * baseURL = [NSURL URLWithString:base];
    /* 添加text/html格式数据请求 */
    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
    self = [self initWithBaseURL:baseURL];
    if (self) {
        // self.parameterEncoding = AFJSONParameterEncoding; //向服务器发送的数据编码格式
        // [self registerHTTPOperationClass:[changeAFJSONRequestOperation class]];
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
        BKSenderBlock showMessage = ^(NSString * msg) {
            [UIAlertView showAlertViewWithTitle:msg
                                        message:nil
                              cancelButtonTitle:@"确定"
                              otherButtonTitles:nil
                                        handler:nil];
        };
        
        
        self.failureBlock = ^(NSHTTPURLResponse *response, NSError *error) {
            //待完善
            if (error.code == -1001) {
                showMessage(@"请求超时");
            } else if (error.code == -1004)
            {
                showMessage(@"不能连接服务器");
            }
            
        };
        
    }
    
    return self;
}
#pragma mark 意见反馈
/***********************************************************************
 * 功能描述：意见反馈
 * 输入参数：
 * 输出参数：
 * 返 回 值：
 * 其它说明：
 ***********************************************************************/
-(void)appSuggestionFeedBack:(NSDictionary *)params success:(SDSenderBlock)success failure:(SDSenderBlock)failure{
    NSString *path = @"app/advice";
    NSMutableURLRequest *request = [self requestWithMethod:@"POST" path:path parameters:params];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        success(JSON);
        NSLog(@"appSuggestionFeedBack ==%@",JSON);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"appSuggestionFeedBack error json = %@",JSON);
        _failureBlock(response,error);
    }];
    [self enqueueHTTPRequestOperation:operation];
}

#pragma mark 自动更新
/***********************************************************************
 * 功能描述：意见反馈
 * 输入参数：
 * 输出参数：
 * 返 回 值：
 * 其它说明：
 ***********************************************************************/
-(void)getVersionUpdate:(NSDictionary *)params success:(SDSenderBlock)success failure:(SDSenderBlock)failure{
    NSString *path = @"app/version?type=1";
    NSMutableURLRequest *request = [self requestWithMethod:@"GET" path:path parameters:params];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        success(JSON);
        NSLog(@"versionUpdate ==%@",JSON);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"versionUpdate error json = %@",JSON);
        _failureBlock(response,error);
    }];
    [self enqueueHTTPRequestOperation:operation];
}
@end
