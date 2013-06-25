//
//  SDClient.m
//  TaoZ
//
//  Created by xudeliang on 13-5-15.
//  Copyright (c) 2013年 陶朱网络. All rights reserved.
//

#import "SDClient.h"
#import "UIAlertView+BlocksKit.h"
#import "SDBlocks.h"
#import "changeAFJSONRequestOperation.h"
#import "JSONKit.h"
@interface SDClient()
@property(nonatomic, copy) AFHTTPFailureBlock failureBlock;
@end

@implementation SDClient
//http://196.168.1.102/api/user/register/

+(SDClient *)instance {
    static dispatch_once_t _singletonPredicate;
    static SDClient *_singleton = nil;
    
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
    NSString * base = [NSString stringWithFormat:@"http://%@/api", TAOZHU_HOST_User];
   // NSString * base = @"http://58.246.67.94:801/api";
   // NSString * base = @"http://192.168.1.102:801/api";
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
        
        
        self.failureBlock = ^(AFHTTPRequestOperation *operation, NSError *error) {
            
            if (operation.response.statusCode == 401) {
                showMessage(@"授权过期");
            } else {
                showMessage(operation.responseString);
            }
            
        };
        
    }

    return self;
}
#pragma mark 注册用户
/***********************************************************************
 * 功能描述：注册用户
 * 输入参数：
 * 输出参数：
 * 返 回 值：
 * 其它说明：
 ***********************************************************************/
-(void)signupWithParams:(NSDictionary *)params success:(SDSenderBlock)success failure:(SDSenderBlock)failure {

    NSString * path = @"user/register";

    NSMutableURLRequest *request = [self requestWithMethod:@"POST" path:path parameters:params];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSLog(@"sign up json = %@",JSON);
        success(JSON);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"sign up error json = %@",JSON);
    }];
   [self enqueueHTTPRequestOperation:operation];
}

#pragma mark 发送验证码
/***********************************************************************
 * 功能描述：发送验证码
 * 输入参数：
 * 输出参数：
 * 返 回 值：
 * 其它说明：
 ***********************************************************************/
-(void)sendVerificationToMobile:(NSDictionary *)params success:(SDSenderBlock)success failure:(SDSenderBlock)failure {
    
    NSString * path = @"user/pwsmscode";
//    
//    [self postPath:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"JSON = %@",responseObject);
//
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//         NSLog(@"error = %@",error);
//    }];
   
    
    NSMutableURLRequest  *request = [self requestWithMethod:@"POST" path:path parameters:params];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        NSLog(@"sendVerificationToMobile JSON = %@",JSON);
        success(JSON);
        
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"sendVerificationToMobile error = %@",error);
        NSLog(@"sendVerificationToMobile JSON = %@",JSON);
        success(error);
    }];
    [self enqueueHTTPRequestOperation:operation];
    
}
#pragma mark 重置密码
/***********************************************************************
 * 功能描述：重置密码
 * 输入参数：
 * 输出参数：
 * 返 回 值：
 * 其它说明：
 ***********************************************************************/
-(void)resetPassword:(NSDictionary *)params success:(SDSenderBlock)success failure:(SDSenderBlock)failure {
    
    NSString * path = @"user/pwupbysmscode";
    
    NSMutableURLRequest *request = [self requestWithMethod:@"POST" path:path parameters:params];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSLog(@"resetPassword json = %@",JSON);
        success(JSON);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"resetPassword error json = %@",JSON);
    }];
    [self enqueueHTTPRequestOperation:operation];
}


#pragma mark 站内账户登录
/***********************************************************************
 * 功能描述：站内账户登录
 * 输入参数：
 * 输出参数：
 * 返 回 值：
 * 其它说明：
 ***********************************************************************/
-(void)loginByTaozAccount:(NSDictionary *)params success:(SDSenderBlock)success failure:(SDSenderBlock)failure{
    NSString *path = @"user/login";
    NSMutableURLRequest *request = [self requestWithMethod:@"POST" path:path parameters:params];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSLog(@"loginByTaozAccount ==%@",JSON);
        success(JSON);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"resetPassword error json = %@",JSON);
    }];
    [self enqueueHTTPRequestOperation:operation];
}
#pragma mark 第三方账户登录
/***********************************************************************
 * 功能描述：第三方账户登录
 * 输入参数：
 * 输出参数：
 * 返 回 值：
 * 其它说明：
 ***********************************************************************/
-(void)loginByOtherAccount:(NSDictionary *)params success:(SDSenderBlock)success failure:(SDSenderBlock)failure{
    NSString *path = @"user/loginuion";
    NSMutableURLRequest *request = [self requestWithMethod:@"POST" path:path parameters:params];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSLog(@"loginByTaozAccount ==%@",JSON);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"resetPassword error json = %@",JSON);
    }];
    [self enqueueHTTPRequestOperation:operation];
}


@end
