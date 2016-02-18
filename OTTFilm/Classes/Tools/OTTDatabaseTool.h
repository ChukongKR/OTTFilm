//
//  OTTDatabaseTool.h
//  OTTFilm
//
//  Created by 郭正豪 on 16/2/5.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FMDatabase;

@interface OTTDatabaseTool : NSObject

+ (FMDatabase *)sharedDatabase;

@end
