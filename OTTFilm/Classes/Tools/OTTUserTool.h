//
//  OTTUserTool.h
//  OTTFilm
//
//  Created by 郭正豪 on 16/1/30.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OTTUserTool : NSObject

@property (copy, nonatomic, readonly) NSString *userName;
@property (copy, nonatomic, readonly) NSString *userPassword;

- (void)setUserName:(NSString *)userName;
- (void)setUserPassword:(NSString *)userPassword;
+ (BOOL)isLogin;

/** Using singleton instance instead of alloc init */
+ (instancetype)sharedOTTUserTool;

@end
