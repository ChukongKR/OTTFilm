//
//  OTTFilmDetailInfoTableViewHeadCell.h
//  OTTFilm
//
//  Created by 郭正豪 on 16/2/15.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OTTFilmInfo;
@interface OTTFilmDetailInfoTableViewHeadCell : UITableViewCell

- (void)configureCellWithFilmInfo:(OTTFilmInfo *)filmInfo;

@end
