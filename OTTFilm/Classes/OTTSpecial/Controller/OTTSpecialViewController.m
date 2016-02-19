//
//  OTTSpecialViewController.m
//  OTTFilm
//
//  Created by 郭正豪 on 16/1/30.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import "OTTSpecialViewController.h"
#import "OTTGeneralTableView.h"
#import "OTTNetworkingTool.h"
#import "OTTPresentingFilmInfo.h"
#import "OTTFilmDetailInfoTableViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface OTTSpecialViewController () <UITableViewDelegate, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (weak, nonatomic) IBOutlet UIView *extensionView;
@property (strong, nonatomic) NSArray<OTTPresentingFilmInfo *> *allPresentingFilmInfos;
@property (strong, nonatomic) NSArray<OTTSoonPresentingFilmInfo *> *allSoonPreFilmInfos;
@property (assign, nonatomic) NSInteger currentIndex;
@property (copy, nonatomic) NSString *currentArea;
@property (assign, nonatomic) NSInteger selectedRowIndex;

@property (weak, nonatomic) IBOutlet UIButton *presentingFilmButton;
@property (weak, nonatomic) IBOutlet UIButton *soonPresentingFilmButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingConstraint;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *locationBarButton;

@property (strong, nonatomic) OTTGeneralTableView *presentingTableView;
@property (strong, nonatomic) OTTGeneralTableView *soonPresentingTableView;
@property (strong, nonatomic) NSArray *tableViews;
@end

@implementation OTTSpecialViewController
@synthesize currentArea = _currentArea;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mainScrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 2, 0);
    
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    [self updateLocation];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didCityChanged:) name:@"OTTDidCityChangeNotification" object:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self updateUI];
    [self configureTableView:self.tableViews[self.currentIndex]];
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Private Methods
- (void)configureTableView:(UITableView *)tableView {
    if ([self.mainScrollView.subviews containsObject:tableView]) {
        return;
    }
    [self.mainScrollView addSubview:tableView];
    [self loadData];
}

- (void)loadData {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    if (self.currentIndex == 0) {
        [OTTNetworkingTool getPresentingFilmInfosWithArea:[self encodingString] completion:^(id response) {
            if ([response isKindOfClass:[NSArray class]]) {
                
                self.allPresentingFilmInfos = response;
                [self.presentingTableView setItems:self.allPresentingFilmInfos];
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            }
        }];
    }else {
        [OTTNetworkingTool getSoonPresentingFilmInfosWithArea:[self encodingString] completion:^(id response) {
            self.allSoonPreFilmInfos = response;
            [self.soonPresentingTableView setItems:self.allSoonPreFilmInfos];
            [MBProgressHUD hideHUDForView:self.view animated:YES];

        }];
    }
}

- (void)updateUI {
    static NSInteger lastIndex = 99;
    if (lastIndex == self.currentIndex) {
        return;
    }
    [self configureTableView:self.tableViews[self.currentIndex]];
    
    lastIndex = self.currentIndex;
    
    if (self.currentIndex == 0) {
        [self.mainScrollView setContentOffset:CGPointZero animated:YES];
        self.soonPresentingFilmButton.selected = NO;
    }else {
        [self.mainScrollView setContentOffset:CGPointMake(self.view.bounds.size.width, 0) animated:YES];
        self.presentingFilmButton.selected = NO;
    }
    self.leadingConstraint.constant = self.currentIndex * [self selectedButton].bounds.size.width;
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self selectedButton].selected = YES;
    }];
}

- (void)updateLocation {
    self.locationBarButton.title = self.currentArea;
}

#pragma mark - Properties
- (NSArray *)tableViews {
    if (!_tableViews) {
        _tableViews = @[self.presentingTableView, self.soonPresentingTableView];
    }
    return _tableViews;
}

- (OTTGeneralTableView *)presentingTableView {
    if (!_presentingTableView) {
        _presentingTableView = [[OTTGeneralTableView alloc] initWithDelegate:self frame:CGRectMake(0, 0, OTT_WINDOW_WIDTH, self.mainScrollView.bounds.size.height)];
    }
    return _presentingTableView;
}

- (OTTGeneralTableView *)soonPresentingTableView {
    if (!_soonPresentingTableView) {
        _soonPresentingTableView = [[OTTGeneralTableView alloc] initWithDelegate:self frame:CGRectMake(OTT_WINDOW_WIDTH, 0, OTT_WINDOW_WIDTH, self.mainScrollView.bounds.size.height)];
    }
    return _soonPresentingTableView;
}

- (UIButton *)selectedButton {
    
    return self.currentIndex == 0? self.presentingFilmButton : self.soonPresentingFilmButton;
}

- (NSString *)currentArea {
    return _currentArea? _currentArea : @"上海";
}

- (void)setCurrentArea:(NSString *)currentArea {
    _currentArea = currentArea;
    
    self.locationBarButton.title = _currentArea;
    [self.presentingTableView removeFromSuperview];
    [self.soonPresentingTableView removeFromSuperview];
    [self loadData];
}

- (NSString *)encodingString {
    return [self.currentArea stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet letterCharacterSet]];
}

- (void)setCurrentIndex:(NSInteger)currentIndex {
    _currentIndex = currentIndex;
    [self updateUI];
}

- (CGFloat)scrollRate {
    return self.mainScrollView.contentOffset.x / OTT_WINDOW_WIDTH;
}

#pragma mark - IBAction
- (IBAction)changeCategory:(UIButton *)sender {
    self.currentIndex = sender.tag;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.mainScrollView) {
        self.currentIndex = (self.mainScrollView.contentOffset.x / self.view.bounds.size.width) + 0.5;
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 151;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.selectedRowIndex = indexPath.row;
    [self performSegueWithIdentifier:@"showDetailInfo" sender:self];
}

#pragma mark - UINavigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showDetailInfo"] && [segue.destinationViewController isKindOfClass:[OTTFilmDetailInfoTableViewController class]]) {
        OTTFilmDetailInfoTableViewController *detailVC = (OTTFilmDetailInfoTableViewController *)segue.destinationViewController;
        detailVC.filmTitle = (self.currentIndex == 0? self.allPresentingFilmInfos : self.allSoonPreFilmInfos)[self.selectedRowIndex].tvTitle;
    }
}

#pragma mark - NSNotification
- (void)didCityChanged:(NSNotification *)notification {
    if (notification.userInfo[@"cityName"]) {
        self.currentArea = notification.userInfo[@"cityName"];
    }
}

@end
