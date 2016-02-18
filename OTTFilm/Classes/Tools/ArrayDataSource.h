//
//  ArrayDataSource.h
//  OTTFilm
//
//  Created by 郭正豪 on 16/1/30.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void(^configureBlock)(UITableViewCell  * _Nonnull cell, id _Nonnull item);
@interface ArrayDataSource : NSObject<UITableViewDataSource>

/** Designated initializer */
- (_Nonnull instancetype)initWithIdentifier:(NSString * _Nonnull)identifier items:(NSArray * _Nullable)items configure:(configureBlock _Nonnull)configure;

- (_Nonnull instancetype)initWithCustomCell:(NSString * _Nonnull)nibName items:(NSArray * _Nullable)items configure:(configureBlock _Nonnull)configure;

- (void)updateItemsWith:(NSArray * _Nonnull)items;

- (_Nonnull id)itemAtIndexPath:(NSIndexPath * _Nonnull)indexPath;

@end
