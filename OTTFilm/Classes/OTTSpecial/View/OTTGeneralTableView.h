//
//  OTTGeneralTableView.h
//  OTTFilm
//
//  Created by 郭正豪 on 16/1/30.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArrayDataSource.h"
@interface OTTGeneralTableView : UITableView

@property (strong, readonly, nonatomic) ArrayDataSource *arrayDataSource;

- (instancetype)initWithDelegate:(id<UITableViewDelegate>)delegate;

- (void)setItems:(NSArray *)items;

@end
