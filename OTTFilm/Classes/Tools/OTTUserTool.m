//
//  OTTUserTool.m
//  OTTFilm
//
//  Created by 郭正豪 on 16/1/30.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import "OTTUserTool.h"
#import "OTTDatabaseTool.h"
#import "NSString+Addtion.h"
#import <FMDB.h>
@interface OTTUserTool()

@property (copy, nonatomic, readwrite) NSString *userName;
@property (copy, nonatomic, readwrite) NSString *userPassword;

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

+ (BOOL)userRegisterWithUserInfo:(NSDictionary *)userInfo {
    FMDatabase *database = [OTTDatabaseTool sharedDatabase];
    
    BOOL result = [database executeUpdateWithFormat:@"insert into OTTUser (account, pass, phoneNum, mail) values(%@, %@, %@, %@)", userInfo[@"account"], [userInfo[@"pass"] md5String], userInfo[@"phoneNum"], userInfo[@"mail"]];
    
    [database close];
    return result;
}

+ (BOOL)userLoginWithAccess:(NSDictionary *)access {
    FMDatabase *database = [OTTDatabaseTool sharedDatabase];
    BOOL success = NO;
    FMResultSet *result = [database executeQueryWithFormat:@"select * from OTTUser where account = %@", access[@"account"]];
    while ([result next]) {
        NSString *pass = [result stringForColumn:@"pass"];
        if ([pass isEqualToString:[access[@"pass"] md5String]]) {
            success = YES;
            [[self sharedOTTUserTool] setLogin:YES];
            break;
        }
    }
    [database close];
    return success;
}

+ (BOOL)userLogout {
    if ([[self sharedOTTUserTool] login] == YES) {
        [[self sharedOTTUserTool] setLogin:NO];
    }
    return ![[self sharedOTTUserTool] login];
}

@end
