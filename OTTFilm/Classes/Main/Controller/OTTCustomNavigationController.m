//
//  OTTCustomNavigationController.m
//  OTTFilm
//
//  Created by 郭正豪 on 16/2/2.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import "OTTCustomNavigationController.h"

@interface OTTCustomNavigationController ()

@end

@implementation OTTCustomNavigationController

+ (void)load {
    [super load];
    
    // NavigationBar setting
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    [navBar setBackgroundImage:[UIImage imageNamed:@"navBack"] forBarMetrics:UIBarMetricsDefault];
    [navBar setTintColor:[UIColor whiteColor]];
    navBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};

}

@end
