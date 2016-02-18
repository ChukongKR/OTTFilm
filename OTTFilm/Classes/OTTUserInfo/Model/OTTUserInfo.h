//
//  OTTUserInfo.h
//  OTTFilm
//
//  Created by 郭正豪 on 16/2/16.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OTTUserInfo : NSObject

@property (copy, readonly, nonatomic) NSString *nickname;
@property (copy, readonly, nonatomic) NSString *mail;

- (void)userRegisterAccountWithName:(NSString *)userName
                               pass:(NSString *)password
                        mailAddress:(NSString *)mail
                           nickName:(NSString *)nickName;

- (void)updateUserInfoWithPass:(NSString *)password mail:(NSString *)mail nickname:(NSString *)nickname;

@end
