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
@property (assign, nonatomic) NSInteger currentIndex;
@property (copy, nonatomic) NSString *currentArea;
@property (assign, nonatomic) NSInteger selectedIndex;

@property (weak, nonatomic) IBOutlet UIButton *presentingFilmButton;
@property (weak, nonatomic) IBOutlet UIButton *soonPresentingFilmButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingConstraint;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *locationBarButton;

@property (strong, nonatomic) OTTGeneralTableView *presentingTableView;
@property (strong, nonatomic) OTTGeneralTableView *soonPresentingTableView;
@end

@implementation OTTSpecialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.currentIndex = 0;
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
//    [self configureScrollView];
    
    [self loadData];
    [self updateLocation];
}

#pragma mark - Private Methods
- (void)configureScrollView {
    self.mainScrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 2, 0);
    
    // PresentingTableView
    self.presentingTableView = [[OTTGeneralTableView alloc] initWithDelegate:self];
    self.presentingTableView.frame = CGRectMake(0, 0, OTT_WINDOW_WIDTH, self.mainScrollView.bounds.size.height);
    [self.presentingTableView setItems:@[]];
    
    [self.mainScrollView addSubview:self.presentingTableView];
}

- (void)loadData {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [OTTNetworkingTool getPresentingFilmInfosWithArea:[self encodingString] completion:^(id response) {
        if ([response isKindOfClass:[NSArray class]]) {
            self.allPresentingFilmInfos = response;
            [self configureScrollView];
            [self.presentingTableView setItems:self.allPresentingFilmInfos];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
    }];
    
}

- (void)updateUI {
    static NSInteger lastIndex = 99;
    if (lastIndex == self.currentIndex) {
        return;
    }
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

- (UIButton *)selectedButton {
    
    return self.currentIndex == 0? self.presentingFilmButton : self.soonPresentingFilmButton;
}

- (NSString *)currentArea {
    return _currentArea? _currentArea : @"上海";
}

- (NSString *)encodingString {
    return [self.currentArea stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet letterCharacterSet]];
}

- (void)setCurrentIndex:(NSInteger)currentIndex {
    _currentIndex = currentIndex;
    [self updateUI];
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

- (IBAction)changeArea:(UIBarButtonItem *)sender {
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 151;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView == self.presentingTableView) {
        self.selectedIndex = indexPath.row;
        [self performSegueWithIdentifier:@"showDetailInfo" sender:self];
    }else {
        
    }
}

#pragma mark - UINavigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showDetailInfo"] && [segue.destinationViewController isKindOfClass:[OTTFilmDetailInfoTableViewController class]]) {
        OTTFilmDetailInfoTableViewController *detailVC = (OTTFilmDetailInfoTableViewController *)segue.destinationViewController;
        detailVC.filmTitle = self.allPresentingFilmInfos[self.selectedIndex].tvTitle;
    }
}

@end
