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
@property (assign, nonatomic) NSInteger currentCount;
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
    NSString *url = [NSString stringWithFormat:DOUBAN_MOVIE_SUBJECT([movieID stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet letterCharacterSet]])];
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

+ (void)queryAllFilmInfoWithTitle:(NSString *)movieTitle completion:(OTTCompletionBlock)completion {
    if (!movieTitle) {
        completion(nil);
        return;
    }
    NSString *url = [NSString stringWithFormat:DOUBAN_SEARCH([movieTitle stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet letterCharacterSet]])];
    [[[self sharedNetworkingTool] manager] GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (![responseObject[@"count"] isEqual:@0] && responseObject[@"subjects"][0][@"id"]) {
            NSArray *results = [OTTDataTool parseArrayWithArray:responseObject[@"subjects"] kind:[OTTFilmInfo class]];
            completion(results);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

+ (void)getFilmRankingInfoWithcompletion:(OTTCompletionBlock)completion country:(NSString *)country {
    NSString *url = [NSString stringWithFormat:@"http://v.juhe.cn/boxoffice/rank?area=%@&dtype=json&key=0a18ce71305a07d9a500d0f431ccb239", country];
    [self parseJsonWithAFNetworkingURL:url completion:^(id response) {
        if ([response isKindOfClass:[NSDictionary class]]) {
            NSArray *filmRankArray = [OTTDataTool parseArrayWithArray:response[@"result"] kind:[OTTFilmRank class]];
            completion(filmRankArray);
        }
    } failure:^(NSError *error) {
        
    }];
}

+ (void)getFilmInfosWithArea:(NSString *)area completion:(OTTCompletionBlock)completion {
    if (![self sharedNetworkingTool]) {
        return;
    }
    NSString *url = [NSString stringWithFormat:@"http://op.juhe.cn/onebox/movie/pmovie?dtype=&city=%@&key=359c584bde6f2d1f28f321ffed0f8ba0", [area stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet letterCharacterSet]]];
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

+ (void)getTop20FilmInfosWithCompletion:(OTTCompletionBlock)completion withCount:(NSInteger)count{
    __block NSInteger num = [[self sharedNetworkingTool] currentCount];
    NSString *url = [NSString stringWithFormat:@"%@?count=%ld&start=%ld", DOUBAN_TOP250, count, num];
    [[[self sharedNetworkingTool] manager] GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            NSArray *result = [OTTDataTool parseArrayWithArray:responseObject[@"subjects"] kind:[OTTFilmInfo class]];
            completion(result);
            if (num <= 100) {
                num += 20;
            }
        }
    } failure:nil];
}

+ (void)getTop20FilmInfosWithCompletion:(OTTCompletionBlock)completion {
    [self getTop20FilmInfosWithCompletion:^(id response) {
        if (response) {
            completion(response);
        }
    } withCount:20];
}

+ (void)getMoreTopFilmInfosWithCompletion:(OTTCompletionBlock)completion {
    [self getTop20FilmInfosWithCompletion:^(id response) {
        if (response) {
            completion(response);
        }
    } withCount:20];
}

@end
