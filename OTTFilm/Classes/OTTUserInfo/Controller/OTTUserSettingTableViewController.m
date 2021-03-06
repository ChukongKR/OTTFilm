//
//  OTTUserSettingTableViewController.m
//  OTTFilm
//
//  Created by 郭正豪 on 16/2/15.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import "OTTUserSettingTableViewController.h"
#import "UIAlertController+Addtion.h"
#import "OTTUserTool.h"
@interface OTTUserSettingTableViewController ()

@end

@implementation OTTUserSettingTableViewController

#pragma mark - UIViewLifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (IBAction)logout {
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [OTTUserTool userLogout];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"警告" message:@"确定要退出登录吗" actions:@[confirmAction, cancelAction]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - TableiViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (![OTTUserTool isLogin]) {
        return 2;
    }
    return 3;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSError *error;
            [[NSFileManager defaultManager] removeItemAtPath:OTTFILMIMAGECACHESDIRECTORY error:&error
             ];
            if (!error) {
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"清除缓存" message:@"确定要清除缓存吗" actions:@[confirmAction, cancelAction]];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }else if (indexPath.row == 1) {
        
    }
}


@end
