//
//  OTTFilmInfo.h
//  OTTFilm
//
//  Created by 郭正豪 on 16/2/2.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OTTFilmInfo : NSObject

//@property (copy, nonatomic) NSString *title;
//@property (copy, nonatomic) NSString *tag;
//@property (copy, nonatomic) NSString *act;
//@property (copy, nonatomic) NSString *year;
//@property (strong, nonatomic) NSNumber *rating;
//@property (copy, nonatomic) NSString *area;
//@property (copy, nonatomic) NSString *dir;
//@property (copy, nonatomic) NSString *desc;
//@property (copy, nonatomic) NSString *cover;
//@property (copy, nonatomic) NSString *vdo_status;
//@property (strong, nonatomic) NSDictionary *playlinks;
//@property (strong, nonatomic) NSArray *video_rec;
//@property (strong, nonatomic) NSArray *act_s;

/** douban */
@property (strong, nonatomic) NSDictionary *rating;
@property (strong, nonatomic) NSNumber *reviews_count;
@property (strong, nonatomic) NSNumber *wish_count;
@property (copy, nonatomic) NSString *douban_site;
@property (copy, nonatomic) NSString *year;
@property (strong, nonatomic) NSDictionary *images;
@property (copy, nonatomic) NSString *alt;
@property (copy, nonatomic) NSString *movieId;
@property (copy, nonatomic) NSString *mobile_url;
@property (copy, nonatomic) NSString *title;
@property (strong, nonatomic) NSNumber *do_count;
@property (copy, nonatomic) NSString *share_url;
@property (strong, nonatomic) NSNumber *seasons_count;
@property (copy, nonatomic) NSString *schedule_url;
@property (strong, nonatomic) NSNumber *episodes_count;
@property (strong, nonatomic) NSArray *countries;
@property (strong, nonatomic) NSArray *genres;
@property (strong, nonatomic) NSNumber *collect_count;
@property (strong, nonatomic) NSArray *casts;
@property (strong, nonatomic) NSNumber *current_season;
@property (copy, nonatomic) NSString *original_title;
@property (copy, nonatomic) NSString *summary;
@property (copy, nonatomic) NSString *subtype;
@property (strong, nonatomic) NSArray *directors;
@property (strong, nonatomic) NSNumber *comments_count;
@property (strong, nonatomic) NSNumber *ratings_count;
@property (strong, nonatomic) NSArray *aka;

@end
