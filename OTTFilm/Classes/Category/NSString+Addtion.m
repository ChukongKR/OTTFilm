//
//  NSString+Addtion.m
//  OTTFilm
//
//  Created by 郭正豪 on 16/2/17.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import "NSString+Addtion.h"
#import <CommonCrypto/CommonDigest.h>
@implementation NSString (Addtion)

- (NSString *)md5String {
    char const *md5Str = [self UTF8String];
    unsigned char md5String[16];
    CC_MD5(md5Str, (CC_LONG)strlen(md5Str), md5String);
    NSMutableString *result = [NSMutableString string];
    [result appendFormat:@"%02x", md5String[0]];
    for (int i = 1; i < 16; i++) {
        [result appendFormat:@"%02x", md5String[i]^md5String[0]];
    }
    
    return [[result lowercaseString] copy];
}

@end
