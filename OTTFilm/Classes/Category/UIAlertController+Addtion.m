//
//  UIAlertController+Addtion.m
//  OTTFilm
//
//  Created by 郭正豪 on 16/2/15.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import "UIAlertController+Addtion.h"

@implementation UIAlertController (Addtion)

- (void)addActions:(NSArray<UIAlertAction *> *)actions {
    for (UIAlertAction *action in actions) {
        [self addAction:action];
    }
}

+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message actions:(NSArray<UIAlertAction *> *)actions {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addActions:actions];
    
    return alertController;
}

+ (instancetype)alertSheetWithTitle:(NSString *)title message:(NSString *)message actions:(NSArray<UIAlertAction *> *)actions {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addActions:actions];
    
    return alertController;
}

@end
