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
@property (copy, readonly, nonatomic) NSString *pass;

@end
