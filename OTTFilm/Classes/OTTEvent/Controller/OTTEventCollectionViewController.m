//
//  OTTEventCollectionViewController.m
//  OTTFilm
//
//  Created by 郭正豪 on 16/2/19.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import "OTTEventCollectionViewController.h"
#import "OTTEventCollectionViewCell.h"
#import "OTTFilmDetailInfoTableViewController.h"
#import "OTTScalableLayout.h"
#import "OTTNetworkingTool.h"
#import "OTTUSBOXFilmInfo.h"
#import <MBProgressHUD.h>
@interface OTTEventCollectionViewController ()

@property (strong, nonatomic) NSArray<OTTFilmInfo *> *allFilmInfos;
@property (assign, nonatomic) BOOL vertically;
@property (strong, nonatomic) OTTScalableLayout *customLayout;

@end

@implementation OTTEventCollectionViewController

static NSString * const reuseIdentifier = @"EventCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)loadData {
    [MBProgressHUD showHUDAddedTo:self.collectionView animated:YES];
    [OTTNetworkingTool getTop20FilmInfosWithCompletion:^(id response) {
        self.allFilmInfos = response;
        [self.collectionView reloadData];
        [MBProgressHUD hideHUDForView:self.collectionView animated:YES];
    }];
}

- (IBAction)changeSort:(UIBarButtonItem *)sender {
    self.vertically = !self.vertically;
    sender.title = self.vertically ? @"大图" : @"全部";
    self.customLayout = [[OTTScalableLayout alloc] init];
    [self.customLayout updateLayoutDirectionVertically:self.vertically];
    self.collectionView.pagingEnabled = !self.vertically;
    [self.collectionView setCollectionViewLayout:self.customLayout animated:YES];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.allFilmInfos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    OTTEventCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    [cell setFilmInfo:self.allFilmInfos[indexPath.row]];
    
    return cell;
}

#pragma mark - UINavigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showCategoryDetail"] && [segue.destinationViewController isKindOfClass:[OTTFilmDetailInfoTableViewController class]]) {
        OTTFilmDetailInfoTableViewController *filmDVC = segue.destinationViewController;
        filmDVC.filmTitle = self.allFilmInfos[[self.collectionView indexPathsForSelectedItems][0].row].title;
    }
    
}

@end
