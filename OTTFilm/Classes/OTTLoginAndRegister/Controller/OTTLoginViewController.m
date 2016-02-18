//
//  OTTLoginViewController.m
//  OTTFilm
//
//  Created by 郭正豪 on 16/1/29.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import "OTTLoginViewController.h"
#import "UIAlertController+Addtion.h"
#import "OTTForgetPassView.h"
#import "OTTRegisterView.h"
#import <SMS_SDK/SMSSDK.h>

@interface OTTLoginViewController () <OTTRegisterAndMissingViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userAccountTextField;
@property (weak, nonatomic) IBOutlet UITextField *userPassTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (weak, nonatomic) IBOutlet UIScrollView *baseScrollView;
@end

@implementation OTTLoginViewController

#pragma mark - UIViewLifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureTextField];
    [self configureScrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - Private Methods
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)configureTextField {
    self.userAccountTextField.leftViewMode = UITextFieldViewModeAlways;
    self.userPassTextField.leftViewMode = UITextFieldViewModeAlways;
    
    UIImageView *accountLeftImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon"]];
    accountLeftImageView.frame = CGRectMake(0, 0, 55, 67);
    accountLeftImageView.contentMode = UIViewContentModeCenter;
    self.userAccountTextField.leftView = accountLeftImageView;
    
    UIImageView *passLeftImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lock"]];
    passLeftImageView.frame = CGRectMake(0, 0, 55, 67);
    passLeftImageView.contentMode = UIViewContentModeCenter;
    self.userPassTextField.leftView = passLeftImageView;
}

- (void)configureScrollView {
    // Configure left: forgetPassView
    OTTForgetPassView *forgetPassView = [[[NSBundle mainBundle] loadNibNamed:@"OTTForgetPassView" owner:nil options:nil] firstObject];
    forgetPassView.frame = CGRectMake(-OTT_WINDOW_WIDTH, 0, self.baseScrollView.bounds.size.width, OTT_WINDOW_HEIGHT);
    forgetPassView.delegate = self;
    
    [self.baseScrollView addSubview:forgetPassView];
    // Configure right: registerView
    OTTRegisterView *registerView = [[[NSBundle mainBundle] loadNibNamed:@"OTTRegisterView" owner:nil options:nil] firstObject];
    registerView.frame = CGRectMake(OTT_WINDOW_WIDTH, 0, self.baseScrollView.bounds.size.width, OTT_WINDOW_HEIGHT);
    registerView.delegate = self;
    
    [self.baseScrollView addSubview:registerView];
}

#pragma mark - IBAction
- (IBAction)loginAction {
    if (self.userAccountTextField.text.length > 0 && self.userPassTextField.text.length > 0) {
        
    }else {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"登录失败" message:@"必须输入用户名和密码" actions:@[cancelAction]];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (IBAction)registerAction {
    [self.baseScrollView setContentOffset:CGPointMake(OTT_WINDOW_WIDTH, 0) animated:YES];
}

- (IBAction)forgetPassAction {
    [self.baseScrollView setContentOffset:CGPointMake(-OTT_WINDOW_WIDTH, 0) animated:YES];
}

- (IBAction)backAndDismiss {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - OTTForgetPassViewDelegate
- (void)ottForgetPassViewDidCancelPasswordChanging:(OTTForgetPassView *)ottForgetPassView {
    [self.baseScrollView setContentOffset:CGPointZero animated:YES];
}

- (void)ottForgetPassView:(OTTGeneralRegisterAndMissingView *)ottForgetPassView didFinishEnterWithVertification:(NSString *)ver phoneNum:(NSString *)num {
    [SMSSDK commitVerificationCode:ver phoneNumber:num zone:@"86" result:^(NSError *error) {
        if (!error) {
            // Change password
            [self.baseScrollView setContentOffset:CGPointZero animated:YES];
        }else {
            // Error
        }
    }];
}

- (void)ottForgetPassView:(OTTGeneralRegisterAndMissingView *)ottForgetPassView didFinishEnterWithRegisterInfo:(NSDictionary *)info {
    if (info) {
        [self.baseScrollView setContentOffset:CGPointZero];
    }
}

@end
