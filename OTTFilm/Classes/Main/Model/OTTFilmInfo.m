//
//  OTTFilmInfo.m
//  OTTFilm
//
//  Created by 郭正豪 on 16/2/2.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import "OTTFilmInfo.h"

@implementation OTTFilmInfo

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.movieId = value;
    }
}

@end
