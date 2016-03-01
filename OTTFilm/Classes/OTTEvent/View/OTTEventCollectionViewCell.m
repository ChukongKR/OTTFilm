//
//  OTTEventCollectionViewCell.m
//  OTTFilm
//
//  Created by 郭正豪 on 16/2/19.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import "OTTEventCollectionViewCell.h"
#import "OTTFilmInfo.h"
#import "OTTDataTool.h"

@interface OTTEventCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *filmImageView;
@property (weak, nonatomic) IBOutlet UILabel *categoryTitle;
@property (weak, nonatomic) IBOutlet UILabel *originalTitle;

@property (strong, nonatomic) OTTFilmInfo *filmInfo;
@end
@implementation OTTEventCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}

- (void)setFilmInfo:(OTTFilmInfo *)filmInfo {
    _filmInfo = filmInfo;
    
    self.filmImageView.image = nil;
    if ([OTTDataTool cachedImageWithURL:filmInfo.images[@"large"]]) {
        self.filmImageView.image = [OTTDataTool cachedImageWithURL:filmInfo.images[@"large"]];
    }
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [OTTDataTool cacheImage:filmInfo.images[@"large"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.filmImageView.image = [OTTDataTool cachedImageWithURL:filmInfo.images[@"large"]];
        });
    });
    self.categoryTitle.text = _filmInfo.title;
    self.originalTitle.text = _filmInfo.original_title;
}

@end
