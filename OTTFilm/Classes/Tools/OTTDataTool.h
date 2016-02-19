//
//  OTTDataTool.h
//  OTTFilm
//
//  Created by 郭正豪 on 16/2/19.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OTTDataTool : NSObject

+ (NSArray *)parseArrayWithArray:(NSArray *)array kind:(Class)kind;

+ (id)parseDictWithDict:(NSDictionary *)dict kind:(Class)kind;

+ (NSArray *)getAllCities;

@end
