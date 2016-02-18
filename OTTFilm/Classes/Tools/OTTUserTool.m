//
//  OTTUserTool.m
//  OTTFilm
//
//  Created by 郭正豪 on 16/1/30.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import "OTTUserTool.h"
@interface OTTUserTool()

@property (copy, nonatomic, readwrite) NSString *userName;
@property (copy, nonatomic, readwrite) NSString *userPassword;
// Phone number
@property (assign, nonatomic) BOOL login;

@end
@implementation OTTUserTool

- (instancetype)init {
    return nil; 
}

+ (instancetype)sharedOTTUserTool {
    static OTTUserTool *_sharedUserTool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedUserTool = [[OTTUserTool alloc] init];
    });
    return _sharedUserTool;
}

+ (BOOL)isLogin {
    return [[self sharedOTTUserTool] login];
}

@end
