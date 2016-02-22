//
//  OTTScalableLayout.m
//  OTTFilm
//
//  Created by 郭正豪 on 16/2/19.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import "OTTScalableLayout.h"

@implementation OTTScalableLayout

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.itemSize = CGSizeMake(OTT_WINDOW_WIDTH - 60, OTT_WINDOW_HEIGHT - 150);
        self.sectionInset = UIEdgeInsetsMake(0, 30, 0, 30);
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.minimumLineSpacing = 60;
    }
    return self;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *allAttributes = [[NSArray alloc] initWithArray:[super layoutAttributesForElementsInRect:rect] copyItems:YES];
    
    CGFloat x = self.collectionView.bounds.size.width/2 + self.collectionView.contentOffset.x;
    for (UICollectionViewLayoutAttributes *attribute in allAttributes) {
        CGFloat centerX = attribute.center.x;
        CGFloat distance = centerX - x;
        CGFloat rotation = ABS(distance/250);

        if (distance > -375 && distance < 0) {
            attribute.transform3D = CATransform3DMakeRotation(rotation * M_PI/6, 0, 1, -0.1);
        }else if (distance < 375 && distance > 0) {
            attribute.transform3D = CATransform3DMakeRotation(rotation * -M_PI/6, 0, 1, -0.1);
        }
    }
    return allAttributes;
}


@end
