//
//  OTTDataTool.m
//  OTTFilm
//
//  Created by 郭正豪 on 16/2/19.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import "OTTDataTool.h"
@implementation OTTDataTool

+ (NSArray *)parseArrayWithArray:(NSArray *)array kind:(Class)kind {
    if (![array isKindOfClass:[NSArray class]]) {
        return nil;
    }
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (NSDictionary *resultDict in array) {
        id data = [[kind alloc] init];
        [data setValuesForKeysWithDictionary:resultDict];
        [mutableArray addObject:data];
    }
    return [mutableArray copy];
}

+ (id)parseDictWithDict:(NSDictionary *)dict kind:(Class)kind {
    return [[self parseArrayWithArray:@[dict] kind:kind] firstObject];
}

+ (NSArray *)getAllCities {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"cities" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    
    return array;
}

@end
