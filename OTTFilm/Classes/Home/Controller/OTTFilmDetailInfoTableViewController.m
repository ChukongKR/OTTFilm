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
#import "UIView+Addtion.h"

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

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [UIView hideNotfoundViewFrom:self.view];
}

- (void)loadData {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [OTTNetworkingTool queryFilmInfoWithTitle:self.filmTitle completion:^(id response) {
        if (response) {
            self.filmInfo = response;
        }else {
            [self showNotfoundInfo];
        }
        [self.tableView reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

- (void)showNotfoundInfo {
    self.headCell.hidden = YES;
    self.bottomCell.hidden = YES;
    self.tableView.scrollEnabled = NO;
    [UIView notfoundViewAddedTo:self.view];
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
    if (!self.filmInfo) {
        return nil;
    }
    if (section == 0) {
        return self.filmInfo.original_title;
    }else {
        return @"简介";
    }
}

@end
