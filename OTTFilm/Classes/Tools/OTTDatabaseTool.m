//
//  OTTDatabaseTool.m
//  OTTFilm
//
//  Created by 郭正豪 on 16/2/5.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import "OTTDatabaseTool.h"
#import "FMDB.h"
@implementation OTTDatabaseTool

- (instancetype)init {
    return nil;
}

+ (FMDatabase *)sharedDatabase {
    static FMDatabase *_database = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
        NSString *databasePath = [libraryPath stringByAppendingPathComponent:@"OTTFilmDatabase.db"];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:databasePath]) {
            [[NSFileManager defaultManager] createFileAtPath:databasePath contents:nil attributes:nil];
        }
        _database = [FMDatabase databaseWithPath:databasePath];
    });
    [_database open];
    return _database;
}

@end
