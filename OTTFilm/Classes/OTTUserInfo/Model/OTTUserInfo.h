//
//  OTTUserInfo.h
//  OTTFilm
//
//  Created by 郭正豪 on 16/2/19.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OTTUserInfo : NSObject

@property (copy, nonatomic) NSString *userAccount;
@property (copy, nonatomic) NSString *userNickname;
@property (copy, nonatomic) NSString *userMail;
@property (copy, nonatomic) NSString *userPhoneNum;
@property (strong, nonatomic) NSData *userHeadIcon;
@property (assign, nonatomic, getter=isLogin) BOOL *login;

@end
