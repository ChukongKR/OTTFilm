//
//  OTTFilmDetailInfoTableViewBottomCell.m
//  OTTFilm
//
//  Created by 郭正豪 on 16/2/15.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import "OTTFilmDetailInfoTableViewBottomCell.h"
#import "OTTFilmInfo.h"
@interface OTTFilmDetailInfoTableViewBottomCell()
@property (weak, nonatomic) IBOutlet UILabel *filmIntroLabel;
@end
@implementation OTTFilmDetailInfoTableViewBottomCell

- (void)configureCellWithFilmInfo:(OTTFilmInfo *)filmInfo {
    self.filmIntroLabel.text = filmInfo.desc;
}

@end
