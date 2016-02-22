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

+ (BOOL)userLoginWithAccess:(NSDictionary *)access {
    FMDatabase *database = [OTTDatabaseTool sharedDatabase];
    BOOL success = NO;
    FMResultSet *result = [database executeQueryWithFormat:@"select * from OTTUser where account = %@", access[@"account"]];
    while ([result next]) {
        NSString *pass = [result stringForColumn:@"pass"];
        if ([pass isEqualToString:[access[@"pass"] md5String]]) {
            success = YES;
            NSString *mail = [result stringForColumn:@"mail"];
            [[self sharedOTTUserTool] setLogin:YES];
            [[self sharedOTTUserTool] setUserName:access[@"account"]];
            [[self sharedOTTUserTool] setUserMail:mail];
            break;
        }
    }
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
