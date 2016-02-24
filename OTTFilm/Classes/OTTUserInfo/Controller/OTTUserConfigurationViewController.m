//
//  OTTUserConfigurationViewController.m
//  OTTFilm
//
//  Created by 郭正豪 on 16/2/24.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import "OTTUserConfigurationViewController.h"
#import "OTTUserTool.h"
#import "OTTUserPasswordChangingView.h"
#import "NSString+Addtion.h"

@interface OTTUserConfigurationViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, OTTUserPasswordChangingViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *imagePickerButton;
@property (weak, nonatomic) IBOutlet UITextField *nickNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *mailTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (strong, nonatomic) OTTUserPasswordChangingView *passwordChangingView;

@end

@implementation OTTUserConfigurationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self showUserInfo];
    [self.view addSubview:self.passwordChangingView];
}

- (OTTUserPasswordChangingView *)passwordChangingView {
    if (!_passwordChangingView) {
        _passwordChangingView = [[[NSBundle mainBundle] loadNibNamed:@"OTTUserPassChangingView" owner:nil options:nil] lastObject];
        _passwordChangingView.delegate = self;
        self.passwordChangingView.frame = CGRectMake((OTT_WINDOW_WIDTH-240)/2, self.phoneTextField.frame.origin.y + 70, 240, 210);
        self.passwordChangingView.hidden = YES;
    }
    return _passwordChangingView;
}

- (void)showUserInfo {
    self.nickNameTextField.text = @"123";
    self.mailTextField.text = [[OTTUserTool sharedOTTUserTool] userMail];
    self.phoneTextField.text = [[OTTUserTool sharedOTTUserTool] userPhoneNum];
}

#pragma mark - IBAction
- (IBAction)cancelConfigurationAndBack {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)confirmConfiguration {
    NSDictionary *info = @{
                           @"phoneNum":self.phoneTextField.text,
                           @"mail":self.mailTextField.text
                           };
    if ([OTTUserTool userUpdateInfoWith:info]) {
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }else {
        NSLog(@"Failure");
    }
}

- (IBAction)displayPasswordChangingView {
    self.passwordChangingView.hidden = !self.passwordChangingView.hidden;
}

- (IBAction)pickUserHeadImage {
    UIImagePickerController *imagePC = [[UIImagePickerController alloc] init];
    imagePC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePC.delegate = self;
    
    [self presentViewController:imagePC animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker.presentingViewController dismissViewControllerAnimated:YES completion:^{
        [self.imagePickerButton setImage:info[UIImagePickerControllerOriginalImage] forState:UIControlStateNormal];
    }];
    
}

#pragma mark - OTTUserPassChangingDelegate
- (void)passwordChangingView:(OTTUserPasswordChangingView *)passView confirmChangeWithParams:(NSDictionary *)params {
    if ([OTTUserTool userUpdatePasswordWith:params]) {
        [self displayPasswordChangingView];
    }
}












@end
