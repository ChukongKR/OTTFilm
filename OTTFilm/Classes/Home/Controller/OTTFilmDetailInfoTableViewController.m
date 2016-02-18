//
//  OTTFilmDetailInfoTableViewController.m
//  OTTFilm
//
//  Created by 郭正豪 on 16/2/15.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import "OTTFilmDetailInfoTableViewController.h"
#import "OTTNetworkingTool.h"
#import "OTTFilmInfo.h"
#import "OTTFilmDetailInfoTableViewHeadCell.h"
#import "OTTFilmDetailInfoTableViewBottomCell.h"
#import <MBProgressHUD.h>

@interface OTTFilmDetailInfoTableViewController ()

@property (strong, nonatomic) OTTFilmInfo *filmInfo;
@property (weak, nonatomic) IBOutlet OTTFilmDetailInfoTableViewHeadCell *headCell;
@property (weak, nonatomic) IBOutlet OTTFilmDetailInfoTableViewBottomCell *bottomCell;

@end

@implementation OTTFilmDetailInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)loadData {
    [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
    [OTTNetworkingTool queryFilmInfoWithTitle:self.filmTitle completion:^(OTTFilmInfo *filmInfo) {
        self.filmInfo = filmInfo;
        [self.tableView reloadData];
        [MBProgressHUD hideHUDForView:self.tableView animated:YES];
    }];
}

#pragma mark - TableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        [self.headCell configureCellWithFilmInfo:self.filmInfo];
        return self.headCell;
    }else {
        [self.bottomCell configureCellWithFilmInfo:self.filmInfo];
        return self.bottomCell;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return self.filmTitle;
    }else {
        return @"简介";
    }
}

@end
