//
//  OTTNetworkingTool.h
//  OTTFilm
//
//  Created by 郭正豪 on 16/2/2.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AFHTTPSessionManager;
@class OTTFilmInfo;

typedef void(^OTTCompletionBlock)(id response);
@interface OTTNetworkingTool : NSObject

//+ (instancetype)sharedNetworkingTool;

+ (void)parseJsonWithAFNetworkingURL:(NSString *)url completion:(OTTCompletionBlock)completion failure:(void (^)(NSError *error))failure;

+ (NSArray *)parseArrayWithArray:(NSArray *)array kind:(Class)kind;

+ (void)queryFilmInfoWithTitle:(NSString *)title completion:(void (^)(OTTFilmInfo *filmInfo))completion;

+ (void)getPresentingFilmInfosWithArea:(NSString *)area completion:(OTTCompletionBlock)completion;

+ (NSArray *)getAllCities;

@end
