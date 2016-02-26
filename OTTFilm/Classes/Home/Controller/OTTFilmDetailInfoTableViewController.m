//
//  OTTFilmDetailInfoTableViewController.m
//  OTTFilm
//
//  Created by 郭正豪 on 16/2/15.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import "OTTFilmDetailInfoTableViewController.h"
#import "OTTNetworkingTool.h"
#import "OTTUserTool.h"
#import "OTTFilmInfo.h"
#import "OTTFilmDetailInfoTableViewHeadCell.h"
#import "OTTFilmDetailInfoTableViewBottomCell.h"
#import <MBProgressHUD.h>
#import "UIView+Addtion.h"

@interface OTTFilmDetailInfoTableViewController ()

@property (strong, nonatomic) OTTFilmInfo *filmInfo;
@property (weak, nonatomic) IBOutlet OTTFilmDetailInfoTableViewHeadCell *headCell;
@property (weak, nonatomic) IBOutlet OTTFilmDetailInfoTableViewBottomCell *bottomCell;


@property (weak, nonatomic) IBOutlet UIButton *heartButton;
@end

@implementation OTTFilmDetailInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self updateHeartButton];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [UIView hideNotfoundViewFrom:self.view];
}

#pragma mark - Private Methods
- (void)loadData {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    if (self.filmTitle) {
        [OTTNetworkingTool queryFilmInfoWithTitle:self.filmTitle completion:^(id response) {
            if (response) {
                self.filmInfo = response;
            }else {
                [self showNotfoundInfo];
            }
            [self.tableView reloadData];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }];
    }else if (self.filmId) {
        [OTTNetworkingTool queryFilmInfoWithID:self.filmId completion:^(id response) {
            if (response) {
                self.filmInfo = response;
            }else {
                [self showNotfoundInfo];
            }
            [self.tableView reloadData];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }];
    }else {
        [self showNotfoundInfo];
        [self.tableView reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }
}

- (void)showNotfoundInfo {
    self.headCell.hidden = YES;
    self.bottomCell.hidden = YES;
    self.tableView.scrollEnabled = NO;
    [UIView notfoundViewAddedTo:self.view];
}

- (void)updateHeartButton {
    if ([OTTUserTool isLogin]) {
        NSArray *lists = [OTTUserTool getUserFavoriteList];
        for (OTTFilmInfo *filmInfo in lists) {
            if ([filmInfo.title isEqualToString:self.filmTitle]) {
                self.heartButton.selected = YES;
                break;
            }else {
                self.heartButton.selected = NO;
            }
        }
    }
}

- (BOOL)updateFavoriteList {
    if (!self.heartButton.selected) {
        return [OTTUserTool addFilmToFavoriteList:self.filmInfo];
    }else {
        return [OTTUserTool removeFilmFromFavoriteList:self.filmInfo];
    }
}

#pragma mark - IBAction
- (IBAction)clickHeartButton:(UIButton *)sender {
    if ([OTTUserTool isLogin]) {
        if ([self updateFavoriteList]) {
            sender.enabled = NO;
            [UIView animateWithDuration:0.2 animations:^{
                sender.transform = CGAffineTransformMakeScale(1.2, 1.2);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.2 animations:^{
                    sender.transform = CGAffineTransformIdentity;
                } completion:^(BOOL finished) {
                    if (finished) {
                        sender.selected = !sender.selected;
                    }
                    sender.enabled = YES;
                }];
            }];
        }
    }else {
        [self performSegueWithIdentifier:@"HomeRegister" sender:nil];
    }
    
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
