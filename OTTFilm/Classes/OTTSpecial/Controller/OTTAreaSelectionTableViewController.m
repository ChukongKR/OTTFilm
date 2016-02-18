//
//  OTTAreaSelectionTableViewController.m
//  OTTFilm
//
//  Created by 郭正豪 on 16/2/18.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import "OTTAreaSelectionTableViewController.h"
#import "OTTNetworkingTool.h"

@interface OTTAreaSelectionTableViewController ()
@property (strong, nonatomic) NSArray *allCities;
@property (strong, nonatomic) cityChangedCompletion completion;
@end

@implementation OTTAreaSelectionTableViewController
static NSString *identifier = @"CitySelectionCell";
- (instancetype)initWithCompletion:(cityChangedCompletion)completion {
    if (self = [super init]) {
        self.completion = completion;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.allCities = [OTTNetworkingTool getAllCities];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismiss:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allCities.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    cell.textLabel.text = self.allCities[indexPath.row][@"name"];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.completion(self.allCities[indexPath.row]);
    [self dismiss:nil];
}

@end
