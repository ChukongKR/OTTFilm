//
//  OTTFilmRank.h
//  OTTFilm
//
//  Created by 郭正豪 on 16/2/15.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OTTFilmRank : NSObject

@property (assign, nonatomic) NSInteger rid;// 名次
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *wk;// 榜单周数
@property (copy, nonatomic) NSString *wboxoffice;// 周末票房
@property (copy, nonatomic) NSString *tboxoffice;// 总票房

@end
