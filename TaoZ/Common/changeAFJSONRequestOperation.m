//
//  changeAFJSONRequestOperation.m
//  TaoZ
//
//  Created by xudeliang on 13-5-20.
//  Copyright (c) 2013年 陶朱网络. All rights reserved.
//

#import "changeAFJSONRequestOperation.h"

@implementation changeAFJSONRequestOperation
//服务器接受最基本的post数据包，afnetworking会对发送的数据参数进行json封装，需要重写。
//重写AFJSONRequestOperation的canProcessRequest方法，使发送请求的时候不会为json格式（afnetworking库默认会有此判断），
+ (BOOL)canProcessRequest:(NSURLRequest *)request {
    //return [[[request URL] pathExtension] isEqualToString:@"json"] || [super canProcessRequest:request];
    return YES;
}

@end
