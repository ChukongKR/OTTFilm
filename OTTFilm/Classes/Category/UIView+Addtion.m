//
//  UIView+Addtion.m
//  OTTFilm
//
//  Created by 郭正豪 on 16/2/16.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import "UIView+Addtion.h"

@implementation UIView (Addtion)

- (void)setBorderColor:(UIColor *)borderColor {
    self.layer.borderColor = borderColor.CGColor;
}

- (void)setBorderWidth:(NSNumber *)borderWidth {
    self.layer.borderWidth = borderWidth.floatValue;
}

+ (void)notfoundViewAddedTo:(UIView *)view {
    UIView *notfoundView = [[UIView alloc] initWithFrame:view.bounds];
    notfoundView.tag = 67;
    notfoundView.backgroundColor = [UIColor darkGrayColor];
    notfoundView.layer.masksToBounds = YES;
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(view.center.x - 100, view.center.y - 40, 200, 80)];
    label.text = @"Not Found";
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:40];
    label.textAlignment = 1;
    label.layer.cornerRadius = 3;
    label.layer.borderColor = [[UIColor whiteColor] CGColor];
    label.layer.borderWidth = 0.5;
    [notfoundView addSubview:label];
    
    [view addSubview:notfoundView];
}

+ (void)hideNotfoundViewFrom:(UIView *)view {
    UIView *notfoundView = [[UIView alloc] viewWithTag:67];
    if (notfoundView) {
        if ([view.subviews containsObject:notfoundView]) {
            [notfoundView removeFromSuperview];
        }
    }
}

- (void)failureAnimationWithDuration:(NSTimeInterval)duration rate:(CGFloat)rate {
    rate = MIN(MAX(rate, 0.5), 1);
    CGFloat distance = rate * 30;
    [UIView animateKeyframesWithDuration:duration delay:0.0 options:0 animations:^{
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.2 animations:^{
            self.frame = (CGRect){self.frame.origin.x - distance/2, self.frame.origin.y, self.frame.size};
        }];
        [UIView addKeyframeWithRelativeStartTime:0.2 relativeDuration:0.2 animations:^{
            self.frame = (CGRect){self.frame.origin.x + distance, self.frame.origin.y, self.frame.size};
        }];
        [UIView addKeyframeWithRelativeStartTime:0.4 relativeDuration:0.2 animations:^{
            self.frame = (CGRect){self.frame.origin.x - distance, self.frame.origin.y, self.frame.size};
        }];
        [UIView addKeyframeWithRelativeStartTime:0.6 relativeDuration:0.2 animations:^{
            self.frame = (CGRect){self.frame.origin.x + distance, self.frame.origin.y, self.frame.size};
        }];
        [UIView addKeyframeWithRelativeStartTime:0.8 relativeDuration:0.2 animations:^{
            self.frame = (CGRect){self.frame.origin.x - distance/2, self.frame.origin.y, self.frame.size};
        }];
    } completion:nil];
}

@end
