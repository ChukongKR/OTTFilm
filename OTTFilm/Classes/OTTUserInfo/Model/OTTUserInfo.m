//
//  OTTUserInfo.m
//  OTTFilm
//
//  Created by 郭正豪 on 16/2/16.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import "OTTUserInfo.h"
@interface OTTUserInfo()

@property (copy, nonatomic) NSString *account;
@property (copy, nonatomic) NSString *userPassword;
@property (copy, readwrite, nonatomic) NSString *mail;
@property (copy, readwrite, nonatomic) NSString *nickName;

@end
@implementation OTTUserInfo

- (void)userRegisterAccountWithName:(NSString *)userName pass:(NSString *)password mailAddress:(NSString *)mail nickName:(NSString *)nickName {
    OTTUserInfo *user = [[OTTUserInfo alloc] init];
    user.account = userName;
    user.userPassword = password;
    user.nickName = nickName;
    user.mail = mail;
    // CoreData or FMDB
}

- (void)updateUserInfoWithPass:(NSString *)password mail:(NSString *)mail nickname:(NSString *)nickname {
    self.userPassword = password;
    self.mail = mail;
    self.nickName = nickname;
}

@end
