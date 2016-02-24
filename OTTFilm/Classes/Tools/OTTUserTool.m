//
//  OTTUserTool.m
//  OTTFilm
//
//  Created by 郭正豪 on 16/1/30.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import "OTTUserTool.h"
#import "OTTDatabaseTool.h"
#import "OTTFilmInfo.h"
#import "NSString+Addtion.h"
#import <FMDB.h>
@interface OTTUserTool()

@property (copy, nonatomic, readwrite) NSString *userName;
@property (copy, nonatomic, readwrite) NSString *userMail;
@property (copy, nonatomic, readwrite) NSString *userPhoneNum;

@property (assign, nonatomic, getter=isLogin) BOOL login;

@end
@implementation OTTUserTool

static OTTUserTool *_sharedUserTool = nil;
+ (instancetype)sharedOTTUserTool {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedUserTool = [[OTTUserTool alloc] init];
    });
    return _sharedUserTool;
}

+ (BOOL)isLogin {
    return [[self sharedOTTUserTool] isLogin];
}

+ (BOOL)userRegisterWithUserInfo:(NSDictionary *)userInfo {
    FMDatabase *database = [OTTDatabaseTool sharedDatabase];
    
    [database executeUpdate:@"create table if not exists OTTUser (id integer primary key, account text, pass text, phoneNum text, mail text)"];
    
    BOOL result = [database executeUpdateWithFormat:@"insert into OTTUser (account, pass, phoneNum, mail) values(%@, %@, %@, %@)", userInfo[@"account"], [userInfo[@"pass"] md5String], userInfo[@"phoneNum"], userInfo[@"mail"]];
    
    [database close];
    return result;
}

+ (NSDictionary *)queryAccessWithAccount:(NSString *)account pass:(NSString *)pass {
    NSDictionary *info = [NSDictionary dictionary];
    FMDatabase *database = [OTTDatabaseTool sharedDatabase];
    BOOL success = NO;
    FMResultSet *result = [database executeQueryWithFormat:@"select * from OTTUser where account = %@", account];
    while ([result next]) {
        NSString *password = [result stringForColumn:@"pass"];
        if ([password isEqualToString:[pass md5String]]) {
            success = YES;
            NSString *mail = [result stringForColumn:@"mail"];
            NSString *phoneNum = [result stringForColumn:@"phoneNum"];
            info = @{@"account":account, @"pass":password, @"mail":mail, @"phoneNum":phoneNum};
        }
    }
    [database close];
    return success? info:nil;
}

+ (BOOL)userLoginWithAccess:(NSDictionary *)access {
    
    NSDictionary *result = [self queryAccessWithAccount:access[@"account"] pass:access[@"pass"]];
    if (result) {
        [[self sharedOTTUserTool] setUserName:result[@"account"]];
        [[self sharedOTTUserTool] setUserMail:result[@"mail"]];
        [[self sharedOTTUserTool] setUserPhoneNum:result[@"phoneNum"]];
        [[self sharedOTTUserTool] setLogin:YES];
        return YES;
    }
    return NO;
}

+ (BOOL)userUpdatePasswordWith:(NSDictionary *)dict {
    NSDictionary *result = [self queryAccessWithAccount:[[self sharedOTTUserTool] userName] pass:dict[@"originalPass"]];
    if (result) {
        FMDatabase *databse = [OTTDatabaseTool sharedDatabase];
        BOOL success = [databse executeUpdate:@"update OTTUser set pass = ? where account = ?", [dict[@"newPass"] md5String], result[@"account"]];
        [databse close];
        return success;
    }
    return NO;
}

+ (BOOL)userUpdateInfoWith:(NSDictionary *)info {
    FMDatabase *database = [OTTDatabaseTool sharedDatabase];
    BOOL success = [database executeUpdate:@"update OTTUser set phoneNum = ? where account = ?; \
                                             update OTTUser set mail = ? where account = ?      \
                    ", info[@"phoneNum"], [[self sharedOTTUserTool] userName], info[@"mail"], [[self sharedOTTUserTool] userName]];
    [database close];
    return success;
}

+ (BOOL)userLogout {
    if ([[self sharedOTTUserTool] isLogin] == YES) {
        [[self sharedOTTUserTool] setLogin:NO];
    }
    return ![[self sharedOTTUserTool] isLogin];
}

+ (NSString *)favoriteListString {
    return [NSString stringWithFormat:@"OTTUserFavorteList_%@", [[self sharedOTTUserTool] userName]];
}

+ (BOOL)addFilmToFavoriteList:(OTTFilmInfo *)filmInfo {
    FMDatabase *database = [OTTDatabaseTool sharedDatabase];
    
    NSString *userFavortiteList = [self favoriteListString];
    if (![database tableExists:userFavortiteList]) {
        NSString *sqlCreate = [NSString stringWithFormat:@"create table %@ (id integer primary key, filmName text, filmImage bolb)", userFavortiteList];
        [database executeUpdate:sqlCreate];
    }
    NSString *sqlUpdate = [NSString stringWithFormat:@"insert into %@ (filmName, filmImage) values(?, ?)", [self favoriteListString]];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:filmInfo.images[@"small"]]];
    BOOL result = [database executeUpdate:sqlUpdate, filmInfo.title, data];
    
    [database close];
    return result;
}

+ (BOOL)removeFilmFromFavoriteList:(OTTFilmInfo *)filmInfo {
    FMDatabase *database = [OTTDatabaseTool sharedDatabase];
    
    NSString *sqlQuery = [NSString stringWithFormat:@"select * from %@ where filmName = ?", [self favoriteListString]];
    FMResultSet *result = [database executeQuery:sqlQuery, filmInfo.title];
    NSString *filmName;
    while ([result next]) {
        filmName = [result stringForColumn:@"filmName"];
    }
    if (!filmName) {
        return NO;
    }
    NSString *sqlDelete = [NSString stringWithFormat:@"delete from %@ where filmName = ?", [self favoriteListString]];
    BOOL success = [database executeUpdate:sqlDelete, filmName];
    
    return success;
}

+ (NSArray *)getUserFavoriteList {
    FMDatabase *database = [OTTDatabaseTool sharedDatabase];
    
    NSMutableArray *resultArray = [NSMutableArray array];
    NSString *sqlQuery = [NSString stringWithFormat:@"select * from %@", [self favoriteListString]];
    FMResultSet *result = [database executeQuery:sqlQuery];
    while ([result next]) {
        OTTFilmInfo *filmInfo = [[OTTFilmInfo alloc] init];
        filmInfo.title = [result stringForColumn:@"filmName"];
        NSData *data = [result dataForColumn:@"filmImage"];
        filmInfo.images = @{@"small":data};
        [resultArray addObject:filmInfo];
    }
    
    [database close];
    return resultArray;
    
}

@end
