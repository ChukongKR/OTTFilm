//
//  OTTSpecialTableViewCell.m
//  OTTFilm
//
//  Created by 郭正豪 on 16/1/30.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import "OTTSpecialTableViewCell.h"
#import "OTTPresentingFilmInfo.h"
@interface OTTSpecialTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *filmImage;
@property (weak, nonatomic) IBOutlet UILabel *filmTitle;
@property (weak, nonatomic) IBOutlet UILabel *filmActor;
@property (weak, nonatomic) IBOutlet UILabel *filmGrade;
@property (weak, nonatomic) IBOutlet UILabel *filmIntro;
@property (weak, nonatomic) IBOutlet UILabel *filmPresentingCount;


@end
@implementation OTTSpecialTableViewCell

- (void)configureCellWithItem:(id)item {
    if ([item isKindOfClass:[OTTPresentingFilmInfo class]]) {
        OTTPresentingFilmInfo *filmInfo = item;
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:filmInfo.iconaddress]];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.filmImage.image = [UIImage imageWithData:data];
            });
        });
        self.filmTitle.text = filmInfo.tvTitle;
        self.filmGrade.text = [NSString stringWithFormat:@"%.1f", filmInfo.grade.floatValue];
        self.filmIntro.text = filmInfo.story[@"data"][@"storyBrief"];
        self.filmPresentingCount.text = filmInfo.subHead;
        self.filmActor.text = [self actorNameFrom:filmInfo.star];
    }else {
        OTTSoonPresentingFilmInfo *filmInfo = item;
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:filmInfo.iconaddress]];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.filmImage.image = [UIImage imageWithData:data];
            });
        });
        self.filmTitle.text = filmInfo.tvTitle;
        self.filmIntro.text = filmInfo.story[@"data"][@"storyBrief"];
        self.filmActor.text = [self actorNameFrom:filmInfo.star];
        self.filmPresentingCount.text = [NSString stringWithFormat:@"%@: %@", filmInfo.playDate[@"showname"], filmInfo.playDate[@"data"]];
    }
}

- (NSString *)actorNameFrom:(NSDictionary *)dict {
    NSMutableString *mutableString = [NSMutableString string];
    for (int i = 1; i < 5; i++) {
        NSString *key = [NSString stringWithFormat:@"%d", i];
        NSString *string = dict[@"data"][key][@"name"];
        [mutableString appendString:[NSString stringWithFormat:@"%@ ", string]];
    }
    return [mutableString copy];
}

@end
