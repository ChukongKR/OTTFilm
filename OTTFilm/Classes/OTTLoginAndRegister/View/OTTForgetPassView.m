//
//  OTTForgetPassView.m
//  OTTFilm
//
//  Created by 郭正豪 on 16/2/16.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import "OTTForgetPassView.h"
#import <SMS_SDK/SMSSDK.h>
@interface OTTForgetPassView()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextField;
@property (weak, nonatomic) IBOutlet UITextField *vertificationTextFeild;
@property (assign, nonatomic, getter=isVertificationSent) BOOL vertificationSent;

@property (strong, nonatomic) NSTimer *timer;
@property (assign, nonatomic) NSInteger currentTime;
@property (weak, nonatomic) IBOutlet UIButton *sendMessageButton;

@end
@implementation OTTForgetPassView

- (IBAction)cancel {
    [self cancelAndBack];
}

- (IBAction)getVertification:(UIButton *)sender {
    self.vertificationSent = YES;
    if (self.phoneNumTextField.text.length == 11) {
        [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.phoneNumTextField.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
            if (!error) {
                sender.enabled = !self.vertificationSent;
                self.currentTime = 60;
                self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
                [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
            }
        }];
    }else {
        // 输入正确的手机号
    }
}

- (IBAction)confirmAccount {
    if (self.isVertificationSent && self.vertificationTextFeild.text.length > 0) {
        [self commitAndBackWithVertification:self.vertificationTextFeild.text phoneNum:self.phoneNumTextField.text];
    }
}

- (void)updateTime {
    self.currentTime--;
    if (self.currentTime != 0) {
        [self.sendMessageButton setTitle:[NSString stringWithFormat:@"%ld", self.currentTime] forState:UIControlStateDisabled];
    }else {
        self.sendMessageButton.enabled = YES;
        [self.timer invalidate];
    }
}


@end
