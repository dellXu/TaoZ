//
//  md5Change.m
//  TaoZ
//
//  Created by xudeliang on 13-5-20.
//  Copyright (c) 2013年 陶朱网络. All rights reserved.
//

#import "md5Change.h"
#import <CommonCrypto/CommonDigest.h>
@implementation md5Change

/***********************************************************************
 * 功能描述：MD5加密
 * 输入参数：待加密字符串
 * 输出参数：
 * 返 回 值：MD5加密后32位字符串
 * 其它说明：
 ***********************************************************************/
+ (NSString *)md5:(NSString *)str

{
    
    const char *cStr = [str UTF8String];
    
    unsigned char result[16];
    
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    
    return [NSString stringWithFormat:
            
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            
            result[0], result[1], result[2], result[3],
            
            result[4], result[5], result[6], result[7],
            
            result[8], result[9], result[10], result[11],
            
            result[12], result[13], result[14], result[15]
            
            ];
    
}
@end
