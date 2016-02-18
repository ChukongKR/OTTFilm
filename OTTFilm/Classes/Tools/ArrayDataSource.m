//
//  ArrayDataSource.m
//  OTTFilm
//
//  Created by 郭正豪 on 16/1/30.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import "ArrayDataSource.h"
@interface ArrayDataSource()

@property (copy, nonatomic) NSString *identifier;
@property (copy, nonatomic) NSArray  *items;
@property (copy, nonatomic) configureBlock configure;
@property (copy, nonatomic) NSString *nibName;

@end
@implementation ArrayDataSource

- (instancetype)initWithIdentifier:(NSString *)identifier items:(NSArray *)items configure:(configureBlock)configure {
    if (self = [super init]) {
        self.identifier = identifier;
        self.items = items;
        self.configure = configure;
    }
    return self;
}

- (instancetype)initWithCustomCell:(NSString *)nibName items:(NSArray *)items configure:(configureBlock)configure {
    self = [self initWithIdentifier:@"" items:items configure:configure];
    self.nibName = nibName;
    
    return self;
}

- (void)updateItemsWith:(NSArray *)items {
    self.items = items;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath {
    return self.items[indexPath.row];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (self.nibName) {
        cell = [[[NSBundle mainBundle] loadNibNamed:self.nibName owner:nil options:nil] firstObject];
    }else {
        cell = [tableView dequeueReusableCellWithIdentifier:self.identifier forIndexPath:indexPath];
    }
    
    self.configure(cell, self.items[indexPath.row]);
    return cell;
}



@end
