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

@end
