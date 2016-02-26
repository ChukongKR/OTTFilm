//
//  OTTUserFavoriteTableViewController.m
//  OTTFilm
//
//  Created by 郭正豪 on 16/2/22.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import "OTTUserFavoriteTableViewController.h"
#import "OTTFilmInfo.h"
#import "OTTUserTool.h"
#import "OTTFilmDetailInfoTableViewController.h"

@interface OTTUserFavoriteTableViewController ()

@property (strong, nonatomic) NSArray<OTTFilmInfo *> *allFavoriteFilms;

@end

@implementation OTTUserFavoriteTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (NSArray<OTTFilmInfo *> *)allFavoriteFilms {
    if (!_allFavoriteFilms) {
        _allFavoriteFilms = [OTTUserTool getUserFavoriteList];
    }
    return _allFavoriteFilms;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allFavoriteFilms.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FavoriteCell" forIndexPath:indexPath];
    
    NSData *data = self.allFavoriteFilms[indexPath.row].images[@"small"];
    cell.imageView.image = [UIImage imageWithData:data];
    cell.textLabel.text = self.allFavoriteFilms[indexPath.row].title;
    
    return cell;
}

#pragma mark - UITableViewDelegate 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showFilmDetail"]) {
        OTTFilmDetailInfoTableViewController *filmDTVC = (OTTFilmDetailInfoTableViewController *)segue.destinationViewController;
        filmDTVC.filmTitle = self.allFavoriteFilms[[self.tableView indexPathForSelectedRow].row].title;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [OTTUserTool removeFilmFromFavoriteList:self.allFavoriteFilms[indexPath.row]];
        self.allFavoriteFilms = nil;
        [tableView reloadData];
    }
}

@end
