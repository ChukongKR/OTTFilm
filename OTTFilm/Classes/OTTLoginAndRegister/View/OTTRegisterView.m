//
//  OTTRegisterView.m
//  OTTFilm
//
//  Created by 郭正豪 on 16/2/17.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import "OTTRegisterView.h"
#import "UIAlertController+Addtion.h"
@interface OTTRegisterView() <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *nicknameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextField;
@property (weak, nonatomic) IBOutlet UITextField *passTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPassTextField;
@property (weak, nonatomic) IBOutlet UITextField *mailTextField;
@property (weak, nonatomic) IBOutlet UIImageView *headIconImageView;
@property (strong, nonatomic) NSData *headIconData;

@end
@implementation OTTRegisterView
@dynamic delegate;
- (IBAction)cancel {
    [self cancelAndBack];
}

- (IBAction)commitAndBack {
    if (   self.accountTextField.text.length >= 6
        && self.phoneNumTextField.text.length == 11
        && self.passTextField.text.length >= 6
        && self.confirmPassTextField.text.length >= 6
        && self.mailTextField.text.length > 0
        && self.nicknameTextField.text.length > 0
        ) {
        if ([self.passTextField.text isEqualToString:self.confirmPassTextField.text]) {
            [self commitAndBackWithRegisgerInfo:@{
                                                  @"account" : self.accountTextField.text,
                                                  @"nickname" : self.nicknameTextField.text,
                                                  @"phoneNum" : self.phoneNumTextField.text,
                                                  @"pass" : self.passTextField.text,
                                                  @"mail" : self.mailTextField.text,
                                                  @"headIcon" : self.headIconData
                                                  }];
        }
    }else {
        if ([self.delegate respondsToSelector:@selector(ottForgetPassView:didFinishEnterWithRegisterInfo:)]) {
            [self.delegate registerView:self failureWithInfo:@"输入正确的用户信息"];
        }
    }
}

- (IBAction)selectHeadIcon {
    if ([self.delegate respondsToSelector:@selector(ottRegisterViewSelectImage:)]) {
        [self.delegate ottRegisterViewSelectImage:self];
    }
}

- (void)setHeadIcon:(UIImage *)image {
    _headIconData = UIImageJPEGRepresentation(image, 1.0);
    self.headIconImageView.image = [UIImage imageWithData:_headIconData];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == self.confirmPassTextField || textField == self.mailTextField) {
        [UIView animateWithDuration:0.33 animations:^{
            self.bounds = CGRectMake(0, 230, self.bounds.size.width, self.bounds.size.height);
        }];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == self.confirmPassTextField || textField == self.mailTextField) {
        [UIView animateWithDuration:0.33 animations:^{
            self.bounds = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
        }];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
