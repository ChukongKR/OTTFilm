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
        self.itemSize = CGSizeMake(OTT_WINDOW_WIDTH/2, OTT_WINDOW_HEIGHT - 350);
        self.sectionInset = UIEdgeInsetsMake(0, OTT_WINDOW_WIDTH/4, 0, OTT_WINDOW_WIDTH/4);
        self.minimumLineSpacing = 60;
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
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
        CGFloat scale = 1 + 0.5 * (1 - ABS(distance/180));
        
        attribute.transform3D = CATransform3DMakeScale(scale, scale, 1);
        
//        CGFloat rotation = distance/300;
//        if (distance > -300 && distance < 0) {
//            attribute.transform3D = CATransform3DMakeRotation(rotation * M_PI_2, 0, 1, 0);
//        }else if (distance < 300 && distance > 0) {
//            attribute.transform3D = CATransform3DMakeRotation(rotation * -M_PI_2, 0, 1, 0);
//        }
    }
    return allAttributes;
}


@end
