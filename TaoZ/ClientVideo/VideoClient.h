//
//  VideoClient.h
//  TaoZ
//
//  Created by xudeliang on 13-5-23.
//  Copyright (c) 2013年 陶朱网络. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDBlocks.h"
@interface VideoClient : AFHTTPClient

typedef void(^AFHTTPFailureBlock)(AFHTTPRequestOperation *operation, NSError *error);
typedef void(^AFHTTPSuccessBlock)(AFHTTPRequestOperation *operation, id responseObject);

typedef void(^AFJSONFailureBlock)(NSHTTPURLResponse *response, NSError *error);

+(VideoClient *)instance;

#pragma mark 获取热门搜索列表
-(void)getSearchHotkeyList:(NSDictionary *)params success:(SDSenderBlock)success failure:(SDSenderBlock)failure;
#pragma mark 关键字搜索
-(void)getSearchListByKeyWord:(NSDictionary *)params success:(SDSenderBlock)success failure:(SDSenderBlock)failure;
#pragma mark 根据视频guid获取视频详情
-(void)getVideoDetailByGuid:(NSDictionary *)params success:(SDSenderBlock)success failure:(SDSenderBlock)failure;
#pragma mark 视频详情页的相关视频列表
-(void)getRelatedVideoListOnVideoDetail:(NSDictionary *)params success:(SDSenderBlock)success failure:(SDSenderBlock)failure;
#pragma mark 视频详情页的用户评论列表
-(void)getUserCommentList1:(NSDictionary *)params success:(SDSenderBlock)success failure:(SDSenderBlock)failure;
#pragma mark 发表评论
-(void)sendUserComment:(NSDictionary *)params success:(SDSenderBlock)success failure:(SDSenderBlock)failure;
#pragma mark 收藏视频
-(void)addFavoriteVideo:(NSDictionary *)params success:(SDSenderBlock)success failure:(SDSenderBlock)failure;
#pragma mark 删除已收藏视频
-(void)deleteFavoriteVideo:(NSDictionary *)params success:(SDSenderBlock)success failure:(SDSenderBlock)failure;
#pragma mark 查询用户是否收藏该视频
-(void)isFavoriteVideo:(NSDictionary *)params success:(SDSenderBlock)success failure:(SDSenderBlock)failure;
#pragma mark 视频排行榜
-(void)getVideoRankList:(NSDictionary *)params success:(SDSenderBlock)success failure:(SDSenderBlock)failure;
#pragma mark 视频播放权限控（视频播放）
-(void)haveRightToPlay:(NSDictionary *)params success:(SDSenderBlock)success failure:(SDSenderBlock)failure;

#pragma mark 视频分类
-(void)getVideoCategory:(NSDictionary *)params success:(SDSenderBlock)success failure:(SDSenderBlock)failure;
#pragma mark 视频分类二级列表
-(void)getVideoCategorySecondList:(NSDictionary *)params success:(SDSenderBlock)success failure:(SDSenderBlock)failure;
#pragma mark 视频播放权限控制 获取CC视频id
-(void)getVideoPlayInfo:(NSDictionary *)params success:(SDSenderBlock)success failure:(SDSenderBlock)failure;

@end
