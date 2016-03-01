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

+ (void)cacheImageWithURL:(NSURL *)url atDirectory:(NSString *)directory {
    [[NSFileManager defaultManager] createDirectoryAtPath:OTTFILMIMAGECACHESDIRECTORY withIntermediateDirectories:YES attributes:nil error:nil];
    NSData *data = [NSData dataWithContentsOfURL:url];
    [[NSFileManager defaultManager] createFileAtPath:directory contents:data attributes:nil];
}

static NSMutableDictionary *_imageCachingDict = nil;
+ (void)cacheImage:(NSString *)url {
    if (!_imageCachingDict) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _imageCachingDict = [NSMutableDictionary dictionary];
        });
    }
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    UIImage *image = [UIImage imageWithData:data];
    _imageCachingDict[url] = image;
}

+ (UIImage *)cachedImageWithURL:(NSString *)url {
    if (!_imageCachingDict || !_imageCachingDict[url]) {
        return nil;
    }
    return _imageCachingDict[url];
}

@end
