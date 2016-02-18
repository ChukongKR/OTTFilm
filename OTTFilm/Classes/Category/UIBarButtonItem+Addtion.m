//
//  UIBarButtonItem+Addtion.m
//  OTTFilm
//
//  Created by 郭正豪 on 16/1/30.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import "UIBarButtonItem+Addtion.h"

@implementation UIBarButtonItem (Addtion)

+ (instancetype)barButtonItemWithButtonNormalImage:(NSString *)normal highlightedImage:(NSString *)highlighted target:(id)target action:(SEL)selector {
    UIButton *button = [[UIButton alloc] init];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:normal] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highlighted] forState:UIControlStateHighlighted];
    button.frame = CGRectMake(0, 0, 50, 44);
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    return item;
}

@end
