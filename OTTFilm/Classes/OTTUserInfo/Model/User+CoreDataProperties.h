//
//  User+CoreDataProperties.h
//  OTTFilm
//
//  Created by 郭正豪 on 16/2/19.
//  Copyright © 2016年 郭正豪. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *userID;
@property (nullable, nonatomic, retain) NSString *userAccount;
@property (nullable, nonatomic, retain) NSString *userPass;
@property (nullable, nonatomic, retain) NSString *userNickName;
@property (nullable, nonatomic, retain) NSString *userPhoneNum;
@property (nullable, nonatomic, retain) NSString *userMail;

@end

NS_ASSUME_NONNULL_END
