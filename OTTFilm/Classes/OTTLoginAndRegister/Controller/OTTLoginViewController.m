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
#import "OTTUserTool.h"
#import <SMS_SDK/SMSSDK.h>

@interface OTTLoginViewController () <OTTRegisterAndMissingViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userAccountTextField;
@property (weak, nonatomic) IBOutlet UITextField *userPassTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (weak, nonatomic) IBOutlet UIScrollView *baseScrollView;
@property (strong, nonatomic) OTTForgetPassView *forgetPassView;
@property (strong, nonatomic) OTTRegisterView *registerView;
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
    if (![self.baseScrollView.subviews containsObject:self.forgetPassView]) {
        [self.baseScrollView addSubview:self.forgetPassView];
    }
    // Configure right: registerView
    if (![self.baseScrollView.subviews containsObject:self.registerView]) {
        [self.baseScrollView addSubview:self.registerView];
    }
}

- (OTTForgetPassView *)forgetPassView {
    if (!_forgetPassView) {
        _forgetPassView = [[[NSBundle mainBundle] loadNibNamed:@"OTTForgetPassView" owner:nil options:nil] firstObject];
        _forgetPassView.frame = CGRectMake(-OTT_WINDOW_WIDTH, 0, self.baseScrollView.bounds.size.width, OTT_WINDOW_HEIGHT);
        _forgetPassView.delegate = self;
    }
    return _forgetPassView;
}

- (OTTRegisterView *)registerView {
    if (!_registerView) {
        _registerView = [[[NSBundle mainBundle] loadNibNamed:@"OTTRegisterView" owner:nil options:nil] firstObject];
        _registerView.frame = CGRectMake(OTT_WINDOW_WIDTH, 0, self.baseScrollView.bounds.size.width, OTT_WINDOW_HEIGHT);
        _registerView.delegate = self;
    }
    return _registerView;
}

- (void)refreshView:(UIView *)view {
    [view removeFromSuperview];
    view = nil;
    [self configureScrollView];
}

#pragma mark - IBAction
- (IBAction)loginAction {
    if (self.userAccountTextField.text.length > 0 && self.userPassTextField.text.length > 0) {
        if ([OTTUserTool userLoginWithAccess:@{@"account":self.userAccountTextField.text, @"pass":self.userPassTextField.text}]) {
            [self backAndDismiss];
        }
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
        BOOL result = [OTTUserTool userRegisterWithUserInfo:info];
        if (result) {
            [self.baseScrollView setContentOffset:CGPointZero];
            [self refreshView:self.registerView];
        }
    }
}

@end
