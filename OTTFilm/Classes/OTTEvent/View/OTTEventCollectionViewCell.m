//
//  OTTEventCollectionViewCell.m
//  OTTFilm
//
//  Created by 郭正豪 on 16/2/19.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import "OTTEventCollectionViewCell.h"
#import "OTTUSBOXFilmInfo.h"

@interface OTTEventCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *filmImageView;
@property (weak, nonatomic) IBOutlet UILabel *categoryTitle;
@property (weak, nonatomic) IBOutlet UILabel *originalTitle;

@property (strong, nonatomic) OTTUSBOXFilmInfo *usFilmInfo;
@end
@implementation OTTEventCollectionViewCell


- (void)setUsFilmInfo:(OTTUSBOXFilmInfo *)usFilmInfo {
    _usFilmInfo = usFilmInfo;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:_usFilmInfo.subject.images[@"large"]]];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.filmImageView.image = [UIImage imageWithData:data];
        });
    });
    self.categoryTitle.text = _usFilmInfo.subject.title;
    self.originalTitle.text = _usFilmInfo.subject.original_title;
}


@end
