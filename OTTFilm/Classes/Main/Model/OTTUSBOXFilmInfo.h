//
//  OTTUSBOXFilmInfo.h
//  OTTFilm
//
//  Created by 郭正豪 on 16/2/19.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OTTFilmInfo.h"
@interface OTTUSBOXFilmInfo : NSObject

@property (assign, nonatomic) NSInteger box;
@property (assign, nonatomic) BOOL isNew;
@property (assign, nonatomic) NSInteger rank;
@property (strong, nonatomic) OTTFilmInfo *subject;

@end
