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
#import "OTTNetworkingTool.h"
#import "OTTUSBOXFilmInfo.h"
#import <MBProgressHUD.h>
@interface OTTEventCollectionViewController ()

@property (strong, nonatomic) NSArray<OTTUSBOXFilmInfo *> *allUSBoxs;

@end

@implementation OTTEventCollectionViewController

static NSString * const reuseIdentifier = @"EventCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"OTTEventCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self loadData];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)loadData {
    [MBProgressHUD showHUDAddedTo:self.collectionView animated:YES];
    [OTTNetworkingTool getUS_BOXFilmInfosWithCompletion:^(id response) {
        self.allUSBoxs = response;
        [self.collectionView reloadData];
        [MBProgressHUD hideHUDForView:self.collectionView animated:YES];
    }];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.allUSBoxs.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    OTTEventCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    [cell setUsFilmInfo:self.allUSBoxs[indexPath.row]];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"showCategoryDetail" sender:self];
}

#pragma mark - UINavigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //
    
}

@end
