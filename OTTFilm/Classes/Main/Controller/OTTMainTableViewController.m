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
#import "OTTFilmRank.h"
#import "OTTFilmInfo.h"
#import "OTTFilmDetailInfoTableViewController.h"

@interface OTTFilmRankListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *filmImageView;
@property (weak, nonatomic) IBOutlet UILabel *filmTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *filmIntroLabel;
@property (weak, nonatomic) IBOutlet UILabel *filmReleaseTimeLabel;

- (void)configureCellWith:(OTTFilmRank *)filmInfo;

@end
@implementation OTTFilmRankListTableViewCell

- (void)configureCellWith:(OTTFilmRank *)filmRank {
    self.filmImageView.image = nil;
    if (filmRank) {
        
        self.filmTitleLabel.text = filmRank.name;
        self.filmIntroLabel.text = filmRank.tboxoffice;
        self.filmReleaseTimeLabel.text = [NSString stringWithFormat:@"%ld", filmRank.rid];
        if (filmRank.rid < 4) {
            self.filmReleaseTimeLabel.font = [UIFont systemFontOfSize:30];
        }else {
            self.filmReleaseTimeLabel.font = [UIFont systemFontOfSize:14];
        }
        
        NSString *cachePath = [OTTFILMIMAGECACHESDIRECTORY stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg",filmRank.name]];
        if (![[NSFileManager defaultManager] fileExistsAtPath:cachePath]) {
            [OTTNetworkingTool queryFilmInfoWithTitle:filmRank.name completion:^(OTTFilmInfo *filmInfo) {
                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                    
                    // Cache Image
                    [[NSFileManager defaultManager] createDirectoryAtPath:OTTFILMIMAGECACHESDIRECTORY withIntermediateDirectories:YES attributes:nil error:nil];
                    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:filmInfo.cover]];
                    [[NSFileManager defaultManager] createFileAtPath:cachePath contents:data attributes:nil];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.filmImageView.image = [[UIImage alloc] initWithContentsOfFile:cachePath];
                    });
                });
            }];
        }
        self.filmImageView.image = [[UIImage alloc] initWithContentsOfFile:cachePath];
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
    [OTTNetworkingTool parseJsonWithAFNetworkingURL:@"http://v.juhe.cn/boxoffice/rank?area=CN&dtype=json&key=0a18ce71305a07d9a500d0f431ccb239" completion:^(id response) {
        if ([response isKindOfClass:[NSDictionary class]]) {
            
            self.filmRankArray = [OTTNetworkingTool parseArrayWithArray:response[@"result"] kind:[OTTFilmRank class]];
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
}

- (IBAction)searchFilm:(UIBarButtonItem *)sender {
    
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
    return 120;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [(OTTFilmRankListTableViewCell *)cell configureCellWith:self.filmRankArray[indexPath.row]];
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
