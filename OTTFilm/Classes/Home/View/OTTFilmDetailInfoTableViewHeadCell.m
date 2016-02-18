//
//  OTTFilmDetailInfoTableViewHeadCell.m
//  OTTFilm
//
//  Created by 郭正豪 on 16/2/15.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import "OTTFilmDetailInfoTableViewHeadCell.h"
#import "OTTFilmInfo.h"
#import "OTTFilmActorsScrollView.h"
@interface OTTFilmDetailInfoTableViewHeadCell() <OTTFilmActorScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *filmImageView;
@property (weak, nonatomic) IBOutlet UILabel *filmTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *filmDirectorLabel;
@property (weak, nonatomic) IBOutlet UILabel *filmTagLabel;
@property (weak, nonatomic) IBOutlet UILabel *filmRatingLabel;
@property (weak, nonatomic) IBOutlet OTTFilmActorsScrollView *actorScrollView;
@end
@implementation OTTFilmDetailInfoTableViewHeadCell

- (void)configureCellWithFilmInfo:(OTTFilmInfo *)filmInfo {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:filmInfo.cover]];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.filmImageView.image = [UIImage imageWithData:data];
        });
    });
    [self.actorScrollView configureScrollViewWithActors:filmInfo.act_s itemHeight:40 itemWidth:40];
    self.actorScrollView.ottDelegate = self;
    self.filmTitleLabel.text = filmInfo.title;
    self.filmDirectorLabel.text = filmInfo.dir;
    self.filmTagLabel.text = filmInfo.tag;
    self.filmRatingLabel.text = [NSString stringWithFormat:@"%.1f", filmInfo.rating.doubleValue];
}

- (void)ottFilmActorScrollView:(OTTFilmActorsScrollView *)ottFilmActorScrollView didClickItem:(id)item {
    
}

@end
