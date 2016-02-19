//
//  OTTUSBOXFilmInfo.m
//  OTTFilm
//
//  Created by 郭正豪 on 16/2/19.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import "OTTUSBOXFilmInfo.h"
#import "OTTDataTool.h"
@implementation OTTUSBOXFilmInfo

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"new"]) {
        self.isNew = value;
    }
}

- (void)setSubject:(OTTFilmInfo *)subject {
    if ([subject isKindOfClass:[NSDictionary class]]) {
        _subject = [OTTDataTool parseDictWithDict:(NSDictionary *)subject kind:[OTTFilmInfo class]];
    }
}

@end
