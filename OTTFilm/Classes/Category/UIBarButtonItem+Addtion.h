//
//  UIBarButtonItem+Addtion.h
//  OTTFilm
//
//  Created by 郭正豪 on 16/1/30.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Addtion)

+ (instancetype)barButtonItemWithButtonNormalImage:(NSString *)normal highlightedImage:(NSString *)highlighted target:(id)target action:(SEL)selector;

@end
