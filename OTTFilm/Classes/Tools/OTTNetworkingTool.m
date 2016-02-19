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
#import "OTTFilmRank.h"
#import "OTTUSBOXFilmInfo.h"
#import "OTTPresentingFilmInfo.h"
#import "OTTDataTool.h"
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

+ (void)queryFilmInfoWithID:(NSString *)movieID completion:(OTTCompletionBlock)completion {
    NSString *url = [NSString stringWithFormat:DOUBAN_MOVIE_SUBJECT(movieID)];
    [[[self sharedNetworkingTool] manager] GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            if (![responseObject[@"count"] isEqual:@0]) {
                OTTFilmInfo *filmInfo = [OTTDataTool parseDictWithDict:responseObject kind:[OTTFilmInfo class]];
                completion(filmInfo);
            }else {
                completion(nil);
            }
        }
    } failure:nil];
}

+ (void)queryFilmInfoWithTitle:(NSString *)movieTitle completion:(OTTCompletionBlock)completion {
    if (!movieTitle) {
        completion(nil);
        return;
    }
    NSString *url = [NSString stringWithFormat:DOUBAN_SEARCH([movieTitle stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet letterCharacterSet]])];
    [[[self sharedNetworkingTool] manager] GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (![responseObject[@"count"] isEqual:@0] && responseObject[@"subjects"][0][@"id"]) {
            [self queryFilmInfoWithID:responseObject[@"subjects"][0][@"id"] completion:^(id response) {
                if (response) {
                    completion(response);
                }else {
                    completion(nil);
                }
            }];
        }else {
            completion(nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

+ (void)getFilmRankingInfoWithcompletion:(OTTCompletionBlock)completion {
    NSString *url = @"http://v.juhe.cn/boxoffice/rank?area=CN&dtype=json&key=0a18ce71305a07d9a500d0f431ccb239";
    [self parseJsonWithAFNetworkingURL:url completion:^(id response) {
        if ([response isKindOfClass:[NSDictionary class]]) {
            NSArray *filmRankArray = [OTTDataTool parseArrayWithArray:response[@"result"] kind:[OTTFilmRank class]];
            completion(filmRankArray);
        }
    } failure:nil];
}

+ (void)getFilmInfosWithArea:(NSString *)area completion:(OTTCompletionBlock)completion {
    if (![self sharedNetworkingTool]) {
        return;
    }
    NSString *url = [NSString stringWithFormat:@"http://op.juhe.cn/onebox/movie/pmovie?dtype=&city=%@&key=359c584bde6f2d1f28f321ffed0f8ba0", area];
    [[[self sharedNetworkingTool] manager] GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completion(responseObject[@"result"]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

+ (void)getPresentingFilmInfosWithArea:(NSString *)area completion:(OTTCompletionBlock)completion {
    [self getFilmInfosWithArea:area completion:^(id response) {
        NSArray *result = [OTTDataTool parseArrayWithArray:response[@"data"][0][@"data"] kind:[OTTPresentingFilmInfo class]];
        completion(result);
    }];
}

+ (void)getSoonPresentingFilmInfosWithArea:(NSString *)area completion:(OTTCompletionBlock)completion {
    [self getFilmInfosWithArea:area completion:^(id response) {
        if ([response isKindOfClass:[NSDictionary class]]) {
            NSArray *result = [OTTDataTool parseArrayWithArray:response[@"data"][1][@"data"] kind:[OTTSoonPresentingFilmInfo class]];
            completion(result);
        }
    }];
}

+ (void)getUS_BOXFilmInfosWithCompletion:(OTTCompletionBlock)completion {
    [[[self sharedNetworkingTool] manager] GET:DOUBAN_USBOX parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            NSArray *result = [OTTDataTool parseArrayWithArray:responseObject[@"subjects"] kind:[OTTUSBOXFilmInfo class]];
            completion(result);
        }
    } failure:nil];
}

@end
