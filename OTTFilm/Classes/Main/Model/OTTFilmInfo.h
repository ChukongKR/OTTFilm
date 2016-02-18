//
//  OTTFilmInfo.h
//  OTTFilm
//
//  Created by 郭正豪 on 16/2/2.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OTTFilmInfo : NSObject

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *tag;
@property (copy, nonatomic) NSString *act;
@property (copy, nonatomic) NSString *year;
@property (strong, nonatomic) NSNumber *rating;
@property (copy, nonatomic) NSString *area;
@property (copy, nonatomic) NSString *dir;
@property (copy, nonatomic) NSString *desc;
@property (copy, nonatomic) NSString *cover;
@property (copy, nonatomic) NSString *vdo_status;
@property (strong, nonatomic) NSDictionary *playlinks;
@property (strong, nonatomic) NSArray *video_rec;
@property (strong, nonatomic) NSArray *act_s;

@end
