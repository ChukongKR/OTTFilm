//
//  OTTUserInfoTableViewController.m
//  OTTFilm
//
//  Created by 郭正豪 on 16/2/5.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import "OTTUserInfoTableViewController.h"
#import "OTTUserTool.h"
@interface OTTUserInfoTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *headImageView;
@property (strong, nonatomic) IBOutlet UILabel *userNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *userNicknameLabel;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;

@end
@implementation OTTUserInfoTableViewCell

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if ([OTTUserTool isLogin]) {
        self.loginButton.hidden = YES;
        NSData *headIconData = [OTTUserTool sharedOTTUserTool].userHeadIcon;
        self.headImageView.image = [UIImage imageWithData:headIconData];
        self.userNameLabel.text = [OTTUserTool sharedOTTUserTool].userNickname;
        self.userNicknameLabel.text = [OTTUserTool sharedOTTUserTool].userMail;
    }else {
        self.headImageView.image = nil;
        self.userNameLabel.text = nil;
        self.userNicknameLabel.text = nil;
        self.loginButton.hidden = NO;
    }
}

@end

@interface OTTUserInfoTableViewController ()

@end

@implementation OTTUserInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && indexPath.row == 1) {
        cell.detailTextLabel.text = @"地区";
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section != 0) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        if (indexPath.row != 1) {
            if (![OTTUserTool isLogin]) {
                [self performSegueWithIdentifier:@"userLogin" sender:self];
            }else if (indexPath.row == 2) {
                [self performSegueWithIdentifier:@"configureUserInfo" sender:self];
            }else if (indexPath.row == 3) {
                [self performSegueWithIdentifier:@"showFavoriteList" sender:self];
            }
        }else {
            [self performSegueWithIdentifier:@"changeCity" sender:self];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [OTTUserTool isLogin]? 100 : 44;
    }else {
        return 44;
    }
}

@end
