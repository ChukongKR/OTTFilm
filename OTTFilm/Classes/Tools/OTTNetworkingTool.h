//
//  OTTNetworkingTool.h
//  OTTFilm
//
//  Created by 郭正豪 on 16/2/2.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^OTTCompletionBlock)(id response);
typedef void(^OTTFailureBlock)(NSError *error);
@interface OTTNetworkingTool : NSObject

+ (void)getFilmRankingInfoWithcompletion:(OTTCompletionBlock)completion country:(NSString *)country;

+ (void)queryFilmInfoWithID:(NSString *)movieID completion:(OTTCompletionBlock)completion;
+ (void)queryFilmInfoWithTitle:(NSString *)movieTitle completion:(OTTCompletionBlock)completion;
+ (void)queryAllFilmInfoWithTitle:(NSString *)movieTitle completion:(OTTCompletionBlock)completion;

+ (void)getPresentingFilmInfosWithArea:(NSString *)area completion:(OTTCompletionBlock)completion;

+ (void)getSoonPresentingFilmInfosWithArea:(NSString *)area completion:(OTTCompletionBlock)completion;

+ (void)getUS_BOXFilmInfosWithCompletion:(OTTCompletionBlock)completion;

+ (void)getTop20FilmInfosWithCompletion:(OTTCompletionBlock)completion;
+ (void)getMoreTopFilmInfosWithCompletion:(OTTCompletionBlock)completion;

@end
