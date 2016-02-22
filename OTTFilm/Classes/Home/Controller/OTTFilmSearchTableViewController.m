//
//  OTTFilmSearchTableViewController.m
//  OTTFilm
//
//  Created by 郭正豪 on 16/2/22.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import "OTTFilmSearchTableViewController.h"
#import "OTTNetworkingTool.h"
#import "OTTFilmInfo.h"
#import "OTTFilmDetailInfoTableViewController.h"
#import <MBProgressHUD.h>

@interface OTTFilmSearchTableViewController () <UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (strong, nonatomic) NSArray<OTTFilmInfo *> *results;
@end

@implementation OTTFilmSearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.results.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchCell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.results[indexPath.row].title;
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.searchBar resignFirstResponder];
    if (self.searchBar.text.length > 0) {
        [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
        [OTTNetworkingTool queryAllFilmInfoWithTitle:self.searchBar.text completion:^(id response) {
            if ([response isKindOfClass:[NSArray class]]) {
                self.results = response;
                [self.tableView reloadData];
                [MBProgressHUD hideHUDForView:self.tableView animated:YES];
            }
        }];
    }
    
}

#pragma mark - UINavigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"SearchForDetail"]) {
        OTTFilmDetailInfoTableViewController *detailInfoTVC = (OTTFilmDetailInfoTableViewController *)segue.destinationViewController;
        NSInteger index = self.tableView.indexPathForSelectedRow.row;
        detailInfoTVC.filmId = self.results[index].movieId;
    }
}

@end
