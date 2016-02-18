//
//  OTTFilmActorsScrollView.h
//  OTTFilm
//
//  Created by 郭正豪 on 16/2/15.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OTTFilmActorsScrollView;
@protocol OTTFilmActorScrollViewDelegate <NSObject>

@optional
- (void)ottFilmActorScrollView:(OTTFilmActorsScrollView *)ottFilmActorScrollView didClickItem:(id)item;

@end

@interface OTTFilmActorsScrollView : UIScrollView

- (void)configureScrollViewWithActors:(NSArray *)actors itemHeight:(CGFloat)height itemWidth:(CGFloat)width;

@property (weak, nonatomic) id<OTTFilmActorScrollViewDelegate> ottDelegate;

@end
