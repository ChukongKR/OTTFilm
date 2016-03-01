//
//  OTTWelcomeViewController.m
//  OTTFilm
//
//  Created by 郭正豪 on 16/2/29.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import "OTTWelcomeViewController.h"

@interface OTTWelcomeViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *welcomeScrollView;
@property (strong, nonatomic) NSArray *welcomeImages;
@end

@implementation OTTWelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureScrollView];
}

- (void)configureScrollView {
    self.welcomeScrollView.contentSize = CGSizeMake(self.welcomeImages.count * OTT_WINDOW_WIDTH, 0);
    for (int i = 0; i < self.welcomeImages.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(OTT_WINDOW_WIDTH*i, 0, OTT_WINDOW_WIDTH, OTT_WINDOW_HEIGHT)];
        imageView.image = [UIImage imageNamed:self.welcomeImages[i]];
        [self.welcomeScrollView addSubview:imageView];
        if (i == self.welcomeImages.count - 1) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            button.frame = CGRectMake(0, 0, 200, 44);
            button.center = CGPointMake(OTT_WINDOW_WIDTH * (i + 0.5), OTT_WINDOW_HEIGHT - 150);
            [button setTitle:@"123 GO" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor colorWithRed:0.263 green:0.494 blue:0.855 alpha:1.000] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:20];
            [button setBackgroundColor:[UIColor clearColor]];
            [button addTarget:self action:@selector(gotoMainScene) forControlEvents:UIControlEventTouchUpInside];
            [self.welcomeScrollView addSubview:button];
        }
    }
}

- (void)gotoMainScene {
    UIViewController *mainVC = [UIStoryboard storyboardWithName:@"Main" bundle:nil].instantiateInitialViewController;
    [[UIApplication sharedApplication].keyWindow setRootViewController:mainVC];
}

- (NSArray *)welcomeImages {
    if (!_welcomeImages) {
        _welcomeImages = @[@"08353", @"08354", @"08355", @"08356", @"08357"];
    }
    return _welcomeImages;
}

@end
