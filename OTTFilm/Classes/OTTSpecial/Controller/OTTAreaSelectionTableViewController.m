//
//  OTTAreaSelectionTableViewController.m
//  OTTFilm
//
//  Created by 郭正豪 on 16/2/18.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import "OTTAreaSelectionTableViewController.h"
#import "OTTDataTool.h"

@interface OTTAreaSelectionTableViewController ()
@property (strong, nonatomic) NSArray *allCities;
@end

@implementation OTTAreaSelectionTableViewController
static NSString *identifier = @"CitySelectionCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.allCities = [OTTDataTool getAllCities];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

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
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"OTTDidCityChangeNotification" object:nil userInfo:@{@"cityName":self.allCities[indexPath.row][@"name"]}];
    
    [self dismiss:nil];
}

@end
