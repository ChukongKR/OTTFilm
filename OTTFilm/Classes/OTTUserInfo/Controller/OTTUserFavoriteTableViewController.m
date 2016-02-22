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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:@"empty_heart"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"red_heart"] forState:UIControlStateSelected];
    [button setTitle:nil forState:UIControlStateNormal];
    cell.accessoryView = button;
    
    
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

@end
