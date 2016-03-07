//
//  OTTScalableLayout.m
//  OTTFilm
//
//  Created by 郭正豪 on 16/2/19.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import "OTTScalableLayout.h"
@interface OTTScalableLayout()

@property (assign, nonatomic, getter=isVertically) BOOL vertically;

@end
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

- (void)updateLayoutDirectionVertically:(BOOL)vertical {
    self.vertically = vertical;
}

- (void)setVertically:(BOOL)vertically {
    _vertically = vertically;
    if (_vertically) {
        self.itemSize = CGSizeMake(OTT_WINDOW_WIDTH / 3.5, OTT_WINDOW_HEIGHT / 4);
        self.sectionInset = UIEdgeInsetsMake(30, 15, 30, 15);
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.minimumLineSpacing = 30;
    }else {
        self.itemSize = CGSizeMake(OTT_WINDOW_WIDTH - 60, OTT_WINDOW_HEIGHT - 150);
        self.sectionInset = UIEdgeInsetsMake(0, 30, 0, 30);
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.minimumLineSpacing = 60;
    }
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *allAttributes = [[NSArray alloc] initWithArray:[super layoutAttributesForElementsInRect:rect] copyItems:YES];
    
    if (!self.isVertically) {
        CGFloat x = self.collectionView.bounds.size.width/2 + self.collectionView.contentOffset.x;
        for (UICollectionViewLayoutAttributes *attribute in allAttributes) {
            CGFloat centerX = attribute.center.x;
            CGFloat distance = centerX - x;
            CGFloat rotation = ABS(distance/250);
            
            CATransform3D identity = attribute.transform3D;
            identity.m34 = -1.0 / 1000;
            
            if (distance > -375 && distance < 0) {
                attribute.transform3D = CATransform3DRotate(identity, rotation * M_PI/6, 0, 3, -0.5);
            }else if (distance < 375 && distance > 0) {
                attribute.transform3D = CATransform3DRotate(identity, rotation * -M_PI/6, 0, 3, -0.5);
            }
        }
    }
    return allAttributes;
}


@end
