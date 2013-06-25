//
//  VideoClient.m
//  TaoZ
//
//  Created by xudeliang on 13-5-23.
//  Copyright (c) 2013年 陶朱网络. All rights reserved.
//

#import "VideoClient.h"
#import "UIAlertView+BlocksKit.h"
#import "SDBlocks.h"
#import "changeAFJSONRequestOperation.h"
#import "JSONKit.h"

#define TimeoutInterval 15 //请求超时时常
@interface VideoClient()
@property(nonatomic, copy) AFJSONFailureBlock failureBlock;
@end

@implementation VideoClient
+(VideoClient *)instance {
    static dispatch_once_t _singletonPredicate;
    static VideoClient *_singleton = nil;
    
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
    
     NSString * base = [NSString stringWithFormat:@"http://%@/api",TAOZHU_HOST_Video];
    // NSString * base = @"http://58.246.67.94:801/api";
   // NSString * base = @"http://192.168.1.102:802/api";
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


#pragma mark 获取热门搜索列表
-(void)getSearchHotkeyList:(NSDictionary *)params success:(SDSenderBlock)success failure:(SDSenderBlock)failure
{
    NSString *path = @"search/hotkw";
    NSMutableURLRequest *request = [self requestWithMethod:@"POST" path:path parameters:params];
     [request setTimeoutInterval:TimeoutInterval];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        //NSLog(@"getSearchHotkeyList ==%@",JSON);
        success(JSON);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        //NSLog(@"getSearchHotkeyList error json = %@",JSON);
        //NSLog(@"getSearchHotkeyList error error = %@",error);
        //failure(JSON);
        _failureBlock(response,error);
    }];
    [self enqueueHTTPRequestOperation:operation];
}

#pragma mark 关键字搜索
-(void)getSearchListByKeyWord:(NSDictionary *)params success:(SDSenderBlock)success failure:(SDSenderBlock)failure
{
    NSString *path = @"search/kw";
    NSMutableURLRequest *request = [self requestWithMethod:@"POST" path:path parameters:params];
    [request setTimeoutInterval:TimeoutInterval];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        //NSLog(@"getSearchListByKeyWord ==%@",JSON);
        success(JSON);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        //NSLog(@"getSearchListByKeyWord error json = %@",JSON);
        //NSLog(@"getSearchListByKeyWord error error= %@",error);
        //failure(JSON);
        _failureBlock(response,error);
        
    }];
    [self enqueueHTTPRequestOperation:operation];
}
#pragma mark 根据视频guid获取视频详情
-(void)getVideoDetailByGuid:(NSDictionary *)params success:(SDSenderBlock)success failure:(SDSenderBlock)failure
{
    NSString *path = @"video/detail";
    NSMutableURLRequest *request = [self requestWithMethod:@"POST" path:path parameters:params];
    [request setTimeoutInterval:TimeoutInterval];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        //NSLog(@"getVideoDetailByGuid ==%@",JSON);
        success(JSON);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        //NSLog(@"getVideoDetailByGuid error json = %@",JSON);
        //NSLog(@"getVideoDetailByGuid error error= %@",error);
        //failure(JSON);
        _failureBlock(response,error);
        
    }];
    [self enqueueHTTPRequestOperation:operation];
}
#pragma mark 视频详情页的相关视频列表
-(void)getRelatedVideoListOnVideoDetail:(NSDictionary *)params success:(SDSenderBlock)success failure:(SDSenderBlock)failure
{
    NSString *path = @"video/relatevideo";
    NSMutableURLRequest *request = [self requestWithMethod:@"POST" path:path parameters:params];
    [request setTimeoutInterval:TimeoutInterval];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        //NSLog(@"getRelatedVideoListOnVideoDetail ==%@",JSON);
        success(JSON);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        //NSLog(@"getRelatedVideoListOnVideoDetail error json = %@",JSON);
        //NSLog(@"getRelatedVideoListOnVideoDetail error error= %@",error);
        //failure(JSON);
        _failureBlock(response,error);
        
    }];
    [self enqueueHTTPRequestOperation:operation];
}

#pragma mark 视频详情页的用户评论列表
-(void)getUserCommentList1:(NSDictionary *)params success:(SDSenderBlock)success failure:(SDSenderBlock)failure
{
    NSString *path = @"comment/lists";
    NSMutableURLRequest *request = [self requestWithMethod:@"POST" path:path parameters:params];
    [request setTimeoutInterval:TimeoutInterval];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        //NSLog(@"getUserCommentList ==%@",JSON);
        success(JSON);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        //NSLog(@"getUserCommentList error json = %@",JSON);
        //NSLog(@"getUserCommentList error error= %@",error);
        //failure(JSON);
        _failureBlock(response,error);
        
    }];
    [self enqueueHTTPRequestOperation:operation];
}


#pragma mark 收藏视频
-(void)addFavoriteVideo:(NSDictionary *)params success:(SDSenderBlock)success failure:(SDSenderBlock)failure
{
    NSString *path = @"favorite/add";
    NSMutableURLRequest *request = [self requestWithMethod:@"POST" path:path parameters:params];
    [request setTimeoutInterval:TimeoutInterval];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        //NSLog(@"getUserCommentList ==%@",JSON);
        success(JSON);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        //NSLog(@"getUserCommentList error json = %@",JSON);
        //NSLog(@"getUserCommentList error error= %@",error);
        //failure(JSON);
        _failureBlock(response,error);
        
    }];
    [self enqueueHTTPRequestOperation:operation];
}

#pragma mark 删除已收藏视频
-(void)deleteFavoriteVideo:(NSDictionary *)params success:(SDSenderBlock)success failure:(SDSenderBlock)failure
{
    NSString *path = @"favorite/dlt";
    NSMutableURLRequest *request = [self requestWithMethod:@"POST" path:path parameters:params];
    [request setTimeoutInterval:TimeoutInterval];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        //NSLog(@"getUserCommentList ==%@",JSON);
        success(JSON);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        //NSLog(@"getUserCommentList error json = %@",JSON);
        //NSLog(@"getUserCommentList error error= %@",error);
        //failure(JSON);
        _failureBlock(response,error);
        
    }];
    [self enqueueHTTPRequestOperation:operation];
}

#pragma mark 查询用户是否收藏该视频
-(void)isFavoriteVideo:(NSDictionary *)params success:(SDSenderBlock)success failure:(SDSenderBlock)failure
{
    NSString *path = @"favorite/isfavorite";
    NSMutableURLRequest *request = [self requestWithMethod:@"POST" path:path parameters:params];
    [request setTimeoutInterval:TimeoutInterval];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        //NSLog(@"isFavoriteVideo ==%@",JSON);
        success(JSON);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        //NSLog(@"isFavoriteVideo error json = %@",JSON);
        //NSLog(@"isFavoriteVideo error error= %@",error);
        //failure(JSON);
        _failureBlock(response,error);
        
    }];
    [self enqueueHTTPRequestOperation:operation];
}

#pragma mark 视频排行榜
-(void)getVideoRankList:(NSDictionary *)params success:(SDSenderBlock)success failure:(SDSenderBlock)failure
{
    NSString *path = @"rank/ndaylist";
    NSMutableURLRequest *request = [self requestWithMethod:@"POST" path:path parameters:params];
    [request setTimeoutInterval:TimeoutInterval];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        //NSLog(@"getVideoRankList ==%@",JSON);
        success(JSON);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        //NSLog(@"getVideoRankList error json = %@",JSON);
        //NSLog(@"getVideoRankList error error= %@",error);
        //failure(JSON);
        _failureBlock(response,error);
        
    }];
    [self enqueueHTTPRequestOperation:operation];
}

#pragma mark 视频播放权限控（视频播放）
-(void)haveRightToPlay:(NSDictionary *)params success:(SDSenderBlock)success failure:(SDSenderBlock)failure
{
    NSString *path = @"video/play";
    NSMutableURLRequest *request = [self requestWithMethod:@"POST" path:path parameters:params];
    [request setTimeoutInterval:TimeoutInterval];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        //NSLog(@"haveRightToPlay ==%@",JSON);
        success(JSON);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        //NSLog(@"haveRightToPlay error json = %@",JSON);
        //NSLog(@"haveRightToPlay error error= %@",error);
        //failure(JSON);
        _failureBlock(response,error);
        
    }];
    [self enqueueHTTPRequestOperation:operation];
}


#pragma mark 视频分类
-(void)getVideoCategory:(NSDictionary *)params success:(SDSenderBlock)success failure:(SDSenderBlock)failure
{
    NSString *path = @"category/lists";
    NSMutableURLRequest *request = [self requestWithMethod:@"POST" path:path parameters:params];
    [request setTimeoutInterval:TimeoutInterval];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        //NSLog(@"getVideoCategory ==%@",JSON);
        success(JSON);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        //NSLog(@"getVideoCategory error json = %@",JSON);
        //NSLog(@"getVideoCategory error error= %@",error);
        //failure(JSON);
        _failureBlock(response,error);
        
    }];
    [self enqueueHTTPRequestOperation:operation];
}

#pragma mark 视频分类二级列表
-(void)getVideoCategorySecondList:(NSDictionary *)params success:(SDSenderBlock)success failure:(SDSenderBlock)failure
{
    NSString *path = @"category/videolist";
    NSMutableURLRequest *request = [self requestWithMethod:@"POST" path:path parameters:params];
    [request setTimeoutInterval:TimeoutInterval];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        //NSLog(@"getVideoCategorySecondList ==%@",JSON);
        success(JSON);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        //NSLog(@"getVideoCategorySecondList error json = %@",JSON);
        //NSLog(@"getVideoCategorySecondList error error= %@",error);
        //failure(JSON);
        _failureBlock(response,error);
        
    }];
    [self enqueueHTTPRequestOperation:operation];
}

#pragma mark 视频播放权限控制 获取CC视频id
-(void)getVideoPlayInfo:(NSDictionary *)params success:(SDSenderBlock)success failure:(SDSenderBlock)failure
{
    NSString *path = @"video/play";
    NSMutableURLRequest *request = [self requestWithMethod:@"POST" path:path parameters:params];
    [request setTimeoutInterval:TimeoutInterval];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        //NSLog(@"getVideoPlayInfo ==%@",JSON);
        success(JSON);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        //NSLog(@"getVideoPlayInfo error json = %@",JSON);
        //NSLog(@"getVideoPlayInfo error error= %@",error);
        //failure(JSON);
        _failureBlock(response,error);
        
    }];
    [self enqueueHTTPRequestOperation:operation];
}

#pragma mark 发表评论
-(void)sendUserComment:(NSDictionary *)params success:(SDSenderBlock)success failure:(SDSenderBlock)failure
{
    NSString *path = @"comment/add";
    NSMutableURLRequest *request = [self requestWithMethod:@"POST" path:path parameters:params];
    [request setTimeoutInterval:TimeoutInterval];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        //NSLog(@"sendUserComment ==%@",JSON);
        success(JSON);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        //NSLog(@"sendUserComment error json = %@",JSON);
        //NSLog(@"sendUserComment error error= %@",error);
        //failure(JSON);
        _failureBlock(response,error);
        
    }];
    [self enqueueHTTPRequestOperation:operation];
}
@end
