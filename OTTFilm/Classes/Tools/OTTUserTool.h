//
//  OTTUserTool.h
//  OTTFilm
//
//  Created by 郭正豪 on 16/1/30.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import <Foundation/Foundation.h>
@class OTTFilmInfo;
@interface OTTUserTool : NSObject

@property (copy, nonatomic, readonly) NSString *userName;
@property (copy, nonatomic, readonly) NSString *userMail;

+ (instancetype)sharedOTTUserTool;

+ (BOOL)isLogin;
+ (BOOL)userRegisterWithUserInfo:(NSDictionary *)userInfo;
+ (BOOL)userLoginWithAccess:(NSDictionary *)access;
+ (BOOL)userLogout;

+ (BOOL)addFilmToFavoriteList:(OTTFilmInfo *)filmInfo;
+ (BOOL)removeFilmFromFavoriteList:(OTTFilmInfo *)filmInfo;
+ (NSArray *)getUserFavoriteList;

@end
