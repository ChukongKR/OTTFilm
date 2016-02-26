//
//  UIView+Addtion.h
//  OTTFilm
//
//  Created by 郭正豪 on 16/2/16.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Addtion)

+ (void)notfoundViewAddedTo:(UIView *)view;
+ (void)hideNotfoundViewFrom:(UIView *)view;

/**
 *  Animation indicating an error hint.
 *
 *  @param duration Duration of the animation.
 *  @param rate     Define as moving speed of the animation. It should be between 0.5 and 1.
 */
- (void)failureAnimationWithDuration:(NSTimeInterval)duration rate:(CGFloat)rate;

@end
