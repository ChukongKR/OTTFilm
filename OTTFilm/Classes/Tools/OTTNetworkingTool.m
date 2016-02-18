//
//  OTTNetworkingTool.m
//  OTTFilm
//
//  Created by 郭正豪 on 16/2/2.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import "OTTNetworkingTool.h"
#import <AFNetworking.h>
#import "OTTFilmInfo.h"
#import "OTTPresentingFilmInfo.h"
@interface OTTNetworkingTool()
@property (strong, nonatomic) AFHTTPSessionManager *manager;
@end
@implementation OTTNetworkingTool
static OTTNetworkingTool *_networkingTool = nil;
+ (instancetype)sharedNetworkingTool {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _networkingTool = [[OTTNetworkingTool alloc] init];
    });
    
    return _networkingTool;
}

// AFNetworking
+ (void)parseJsonWithAFNetworkingURL:(NSString *)url completion:(OTTCompletionBlock)completion failure:(void (^)(NSError *error))failure {
    if (![self sharedNetworkingTool]) {
        return;
    }
    [[self sharedNetworkingTool] setManager:[AFHTTPSessionManager manager]];
    [[[self sharedNetworkingTool] manager] GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completion(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

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

+ (void)queryFilmInfoWithTitle:(NSString *)title completion:(void (^)(OTTFilmInfo *filmInfo))completion {
    NSString *url = [NSString stringWithFormat:@"http://op.juhe.cn/onebox/movie/video?dtype=&q=%@&key=359c584bde6f2d1f28f321ffed0f8ba0", [title stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet letterCharacterSet]]];
    [[[self sharedNetworkingTool] manager] GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            if ([responseObject[@"error_code"] isEqual:@0]) {
                OTTFilmInfo *filmInfo = [[self parseArrayWithArray:@[responseObject[@"result"]] kind:[OTTFilmInfo class]]  firstObject];
                completion(filmInfo);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

+ (void)getPresentingFilmInfosWithArea:(NSString *)area completion:(OTTCompletionBlock)completion {
    NSString *url = [NSString stringWithFormat:@"http://op.juhe.cn/onebox/movie/pmovie?dtype=&city=%@&key=359c584bde6f2d1f28f321ffed0f8ba0", area];
    [[[self sharedNetworkingTool] manager] GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSArray *result = [self parseArrayWithArray:responseObject[@"result"][@"data"][0][@"data"] kind:[OTTPresentingFilmInfo class]];
            completion(result);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

+ (NSArray *)getAllCities {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"cities" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    
    return array;
}


@end
