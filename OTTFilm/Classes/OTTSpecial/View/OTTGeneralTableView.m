//
//  OTTGeneralTableView.m
//  OTTFilm
//
//  Created by 郭正豪 on 16/1/30.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import "OTTGeneralTableView.h"
#import "OTTSpecialTableViewCell.h"
@interface OTTGeneralTableView()

@property (strong, readwrite, nonatomic) ArrayDataSource *arrayDataSource;
@property (strong, nonatomic) NSArray *items;

@end
@implementation OTTGeneralTableView
static NSString *identifier = @"Special Cell";
- (instancetype)initWithDelegate:(id<UITableViewDelegate>)delegate frame:(CGRect)frame {
    if (self = [super init]) {
        self.delegate = delegate;
        self.frame = frame;
        self.dataSource = self.arrayDataSource;
        self.backgroundColor = [UIColor clearColor];
        self.contentSize = CGSizeMake(0, self.items.count * self.rowHeight);
    }
    return self;
}

- (ArrayDataSource *)arrayDataSource {
    if (!_arrayDataSource) {
        _arrayDataSource = [[ArrayDataSource alloc] initWithCustomCell:@"OTTSpecialTableViewCell" items:nil configure:^(UITableViewCell *cell, id item) {
            if ([cell isKindOfClass:[OTTSpecialTableViewCell class]]) {
                [((OTTSpecialTableViewCell *)cell) configureCellWithItem:item];
            }
        }];
    }
    return _arrayDataSource;
}

- (void)setItems:(NSArray *)items {
    _items = items;
    [self.arrayDataSource updateItemsWith:_items];
    [self reloadData];
}

@end
