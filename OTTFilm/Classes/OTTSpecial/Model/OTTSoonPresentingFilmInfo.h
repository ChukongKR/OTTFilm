//
//  OTTSoonPresentingFilmInfo.h
//  OTTFilm
//
//  Created by 郭正豪 on 16/2/18.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OTTSoonPresentingFilmInfo : NSObject

@property (copy, nonatomic) NSDictionary *director;


@property (copy, nonatomic) NSString *iconaddress;
@property (copy, nonatomic) NSString *iconlinkUrl;
@property (copy, nonatomic) NSString *m_iconlinkUrl;

@property (strong, nonatomic) NSDictionary *more;

@property (strong, nonatomic) NSDictionary *star;

@property (strong, nonatomic) NSDictionary *playDate;

@property (strong, nonatomic) NSDictionary *story;

@property (copy, nonatomic) NSString *tvTitle;

@property (strong, nonatomic) NSDictionary *type;

@end

@interface OTTStar : NSObject

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *link;


@end
