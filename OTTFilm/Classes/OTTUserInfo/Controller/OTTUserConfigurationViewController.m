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
#import <MBProgressHUD.h>

@interface OTTUserConfigurationViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, OTTUserPasswordChangingViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *imagePickerButton;
@property (weak, nonatomic) IBOutlet UITextField *nickNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *mailTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (strong, nonatomic) OTTUserPasswordChangingView *passwordChangingView;

@property (assign, nonatomic, getter=isShown) BOOL shown;
@end

@implementation OTTUserConfigurationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

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
        self.passwordChangingView.frame = CGRectMake(20, OTT_WINDOW_HEIGHT + 210, OTT_WINDOW_WIDTH-40, OTT_WINDOW_HEIGHT/3);
        self.passwordChangingView.hidden = YES;
    }
    return _passwordChangingView;
}

- (void)showUserInfo {
    UIImage *image = [UIImage imageWithData:[[OTTUserTool sharedOTTUserTool] userHeadIcon]];
    [self.imagePickerButton setImage:image forState:UIControlStateNormal];
    self.nickNameTextField.text = [[OTTUserTool sharedOTTUserTool] userNickname];
    self.mailTextField.text = [[OTTUserTool sharedOTTUserTool] userMail];
    self.phoneTextField.text = [[OTTUserTool sharedOTTUserTool] userPhoneNum];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - IBAction
- (IBAction)cancelConfigurationAndBack {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)confirmConfiguration {
    if (self.phoneTextField.text.length == 0 || self.mailTextField.text.length == 0) {
        return;
    }
    NSData *data = UIImageJPEGRepresentation(self.imagePickerButton.currentImage, 1.0);
    NSDictionary *info = @{
                           @"phoneNum":self.phoneTextField.text,
                           @"mail":self.mailTextField.text,
                           @"nickname":self.nickNameTextField.text,
                           @"headIcon":data
                           };
    if ([OTTUserTool userUpdateInfoWith:info]) {
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }else {
        NSLog(@"Failure");
    }
}

- (IBAction)displayPasswordChangingView:(UIButton *)sender {
    sender.enabled = NO;
    self.shown = !self.isShown;
    if (self.isShown) {
        self.passwordChangingView.hidden = NO;
    }
    [UIView animateWithDuration:0.7 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.7 options:UIViewAnimationOptionCurveEaseOut animations:^{
        CGRect frame = self.passwordChangingView.frame;
        frame.origin.y = self.isShown? OTT_WINDOW_HEIGHT/3 : OTT_WINDOW_HEIGHT + 210;
        self.passwordChangingView.frame = frame;
    } completion:^(BOOL finished) {
        sender.enabled = YES;
        self.passwordChangingView.hidden = !self.isShown;
    }];
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
        [self displayPasswordChangingView:nil];
    }
}

- (void)passwordChangingViewCancelChange:(OTTUserPasswordChangingView *)passView {
    [self displayPasswordChangingView:nil];
}










@end
