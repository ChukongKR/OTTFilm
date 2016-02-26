//
//  OTTMainTableViewController.m
//  OTTFilm
//
//  Created by 郭正豪 on 16/1/30.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import "OTTMainTableViewController.h"
#import "UIBarButtonItem+Addtion.h"
#import "OTTNetworkingTool.h"
#import "OTTDataTool.h"
#import "OTTFilmRank.h"
#import "OTTFilmInfo.h"
#import "OTTFilmDetailInfoTableViewController.h"
#import <MBProgressHUD.h>

@interface OTTFilmRankListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *filmImageView;    // 电影图片
@property (weak, nonatomic) IBOutlet UILabel *filmTitleLabel;       // 电影标题
@property (weak, nonatomic) IBOutlet UILabel *filmIntroLabel;       // 电影简介
@property (weak, nonatomic) IBOutlet UILabel *filmReleaseTimeLabel; // 电影上映时间

- (void)configureCellWith:(OTTFilmRank *)filmRank;

@end
@implementation OTTFilmRankListTableViewCell

- (void)configureCellWith:(OTTFilmRank *)filmRank {
    self.filmImageView.image = nil;
    if (filmRank) {
        
        self.filmTitleLabel.text = filmRank.name;
        self.filmIntroLabel.text = [NSString stringWithFormat:@"%@ (万元)", filmRank.tboxoffice];
        self.filmReleaseTimeLabel.text = [NSString stringWithFormat:@"%ld", filmRank.rid];
        if (filmRank.rid < 4) {
            self.filmReleaseTimeLabel.font = [UIFont systemFontOfSize:30];
        }else {
            self.filmReleaseTimeLabel.font = [UIFont systemFontOfSize:14];
        }
        
        NSString *cachePath = [OTTFILMIMAGECACHESDIRECTORY stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg",filmRank.name]];
        if ([[NSFileManager defaultManager] fileExistsAtPath:cachePath]) {
            self.filmImageView.image = [UIImage imageWithContentsOfFile:cachePath];
        }else {
            [OTTNetworkingTool queryFilmInfoWithTitle:filmRank.name completion:^(id response) {
                if (response) {
                    OTTFilmInfo *filmInfo = response;
                    NSURL *url = [NSURL URLWithString:filmInfo.images[@"medium"]];
                    [OTTDataTool cacheImageWithURL:url atDirectory:cachePath];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.filmImageView.image = [UIImage imageWithContentsOfFile:cachePath];
                    });
                }
            }];
        }
    }
}

@end


@interface OTTMainTableViewController () 

@property (strong, nonatomic) NSArray<OTTFilmRank *> *filmRankArray;

@end

@implementation OTTMainTableViewController
static NSString *identifier = @"Main Cell";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)loadData {
    [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
    [OTTNetworkingTool getFilmRankingInfoWithcompletion:^(id response) {
        if (response) {
            self.filmRankArray = response;
            [self.tableView reloadData];
            [MBProgressHUD hideHUDForView:self.tableView animated:YES];
        }
    }];
}

#pragma mark - Initialization


#pragma mark - TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.filmRankArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    OTTFilmRankListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    return cell;
}

#pragma mark - TableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [(OTTFilmRankListTableViewCell *)cell configureCellWith:self.filmRankArray[indexPath.row]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[OTTFilmDetailInfoTableViewController class]] && [segue.identifier isEqualToString:@"DetailFilmInfo"]) {
        OTTFilmDetailInfoTableViewController *ottFilmDetailInfo = segue.destinationViewController;
        NSInteger index = [self.tableView indexPathForSelectedRow].row;
        ottFilmDetailInfo.filmTitle = self.filmRankArray[index].name;
    }
}

@end
