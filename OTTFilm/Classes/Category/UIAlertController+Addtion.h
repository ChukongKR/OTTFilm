//
//  UIAlertController+Addtion.h
//  OTTFilm
//
//  Created by 郭正豪 on 16/2/15.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (Addtion)

- (void)addActions:(NSArray<UIAlertAction *>*)actions;

// Alert
+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message actions:(NSArray<UIAlertAction *> *)actions;

// AlertSheet
+ (instancetype)alertSheetWithTitle:(NSString *)title message:(NSString *)message actions:(NSArray<UIAlertAction *> *)actions;

@end
