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
                OTTFilmInfo *filmInfo = response;
                NSURL *url = [NSURL URLWithString:filmInfo.images[@"medium"]];
                [OTTDataTool cacheImageWithURL:url atDirectory:cachePath];
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.filmImageView.image = [UIImage imageWithContentsOfFile:cachePath];
                });
            }];
        }
    }
}

@end


@interface OTTMainTableViewController () <UIScrollViewDelegate>

@property (strong, nonatomic) NSArray<OTTFilmRank *> *cnBoxFilms;   // 中国票房
@property (strong, nonatomic) NSArray<OTTFilmRank *> *usBoxFilms;   // 北美票房
@property (strong, nonatomic) NSArray<OTTFilmRank *> *hkBoxFilms;   // 香港票房
@property (assign, nonatomic) NSInteger currentIndex;               // 当前页数

@property (weak, nonatomic) IBOutlet UIScrollView *topScrollView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sementedControl;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;
@property (weak, nonatomic) IBOutlet UIPageControl *imagesPageControl;
@property (assign, nonatomic) NSInteger currentPage;                // 当前图片页数
@end

@implementation OTTMainTableViewController
static NSString *identifier = @"BoxCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.currentIndex = 0;
    self.sementedControl.frame = CGRectMake(0, 0, 200, 30);
    
    [self setupScrollView];
    [self setupPageControl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Initialization
- (void)loadData {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [OTTNetworkingTool getFilmRankingInfoWithcompletion:^(id response) {
        if (self.currentIndex == 0) {
            self.cnBoxFilms = response;
        }else if (self.currentIndex == 1) {
            self.usBoxFilms = response;
        }else {
            self.hkBoxFilms = response;
        }
        
        [self.tableView reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } country:[self country][self.currentIndex]];
}

- (void)setupScrollView {
    self.topScrollView.contentSize = CGSizeMake([self images].count * OTT_WINDOW_WIDTH, 0);
    for (int i = 0; i < [self images].count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(OTT_WINDOW_WIDTH*i, 0, OTT_WINDOW_WIDTH, self.topScrollView.bounds.size.height)];
        imageView.tag = i;
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[self images][i]]];
            dispatch_async(dispatch_get_main_queue(), ^{
                imageView.image = [UIImage imageWithData:data];
                if (imageView.tag == [self images].count - 1) {
                    [self.loadingIndicator stopAnimating];
                }
            });
        });
        [self.topScrollView addSubview:imageView];
    }
}

- (void)setupPageControl {
    self.imagesPageControl.numberOfPages = [self images].count;
}

- (void)setCurrentIndex:(NSInteger)currentIndex {
    _currentIndex = currentIndex;
    if (self.cnBoxFilms && self.usBoxFilms && self.hkBoxFilms) {
        [self.tableView reloadData];
    }else {
        [self loadData];
    }
}

- (void)setCurrentPage:(NSInteger)currentPage {
    _currentPage = currentPage;
    self.imagesPageControl.currentPage = _currentPage;
}

#pragma mark - Private Methods
- (NSArray *)displayingArray {
    return self.currentIndex == 0 ? self.cnBoxFilms : (self.currentIndex == 1) ?
    self.usBoxFilms : self.hkBoxFilms;
}

- (NSArray *)country {
    return @[@"CN", @"US", @"HK"];
}

- (NSArray *)images {
    return @[@"http://pic.nen.com.cn/600/15/85/60/15856011_984155.jpg",
             @"http://img31.mtime.cn/CMS/Gallery/2015/12/25/075657.22418185_1000.jpg",
             @"http://img.ylq.com/2016/0117/20160117020533571.jpg",
             @"http://static.zhidao.manmankan.com/kimages/201512/03_1449130948532991.jpg",
             @"http://img001.21cnimg.com/photos/album/20160111/m600/CA5327CED7798719F1986381089DA3B9.jpg"];
}

#pragma mark - IBAction
- (IBAction)selectFilmInfoSource:(UISegmentedControl *)sender {
    self.currentIndex = sender.selectedSegmentIndex;
}

#pragma mark - TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self displayingArray].count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OTTFilmRankListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    [(OTTFilmRankListTableViewCell *)cell configureCellWith:[self displayingArray][indexPath.row]];

    return cell;
}

#pragma mark - TableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.topScrollView) {
        self.currentPage = scrollView.contentOffset.x / OTT_WINDOW_WIDTH;
    }
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[OTTFilmDetailInfoTableViewController class]] && [segue.identifier isEqualToString:@"DetailFilmInfo"]) {
        OTTFilmDetailInfoTableViewController *ottFilmDetailInfo = segue.destinationViewController;
        NSInteger index = [self.tableView indexPathForSelectedRow].row;
        OTTFilmRank *filmRank = [self displayingArray][index];
        ottFilmDetailInfo.filmTitle = filmRank.name;
    }
}

@end
