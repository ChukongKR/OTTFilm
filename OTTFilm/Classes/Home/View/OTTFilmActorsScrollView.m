//
//  OTTFilmActorsScrollView.m
//  OTTFilm
//
//  Created by 郭正豪 on 16/2/15.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import "OTTFilmActorsScrollView.h"
@interface OTTFilmActorsScrollView()
@property (strong, nonatomic) NSArray *items;
@end
@implementation OTTFilmActorsScrollView

- (void)configureScrollViewWithActors:(NSArray *)actors itemHeight:(CGFloat)height itemWidth:(CGFloat)width {
    if (![actors isKindOfClass:[NSArray class]] || actors == nil) {
        return;
    }
    self.contentSize = CGSizeMake(actors.count * 60 + 20, 0);
    self.items = actors;
    
    for (int i = 0; i < actors.count; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20 + i*(width + 20), 5, width, height)];
        imageView.layer.cornerRadius = 3;
        imageView.layer.masksToBounds = YES;
        if ([actors[i][@"avatars"][@"small"] isKindOfClass:[NSString class]]) {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:actors[i][@"avatars"][@"small"]]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    imageView.image = [UIImage imageWithData:data];
                    [self addSubview:imageView];
                });
            });
        }
        
        UIButton *itemButton = [[UIButton alloc] initWithFrame:CGRectMake(i*(width + 20), 0, width, self.bounds.size.height)];
        [itemButton addTarget:self action:@selector(didClickItem:) forControlEvents:UIControlEventTouchUpInside];
        itemButton.backgroundColor = [UIColor clearColor];
        itemButton.tag = i;
        [self addSubview:itemButton];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5 + i*(width + 20), height + 10, width+30, self.bounds.size.height - height - 5)];
        label.text = actors[i][@"name"];
        label.font = [UIFont systemFontOfSize:10];
        label.textColor = [UIColor darkGrayColor];
        label.textAlignment = 1;
        [self addSubview:label];
    }
}

- (void)didClickItem:(UIButton *)sender {
    if ([self.ottDelegate respondsToSelector:@selector(ottFilmActorScrollView:didClickItem:)]) {
        [self.ottDelegate ottFilmActorScrollView:self didClickItem:self.items[sender.tag]];
    }
}

@end
