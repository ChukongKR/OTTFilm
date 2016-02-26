//
//  OTTForgetPassView.m
//  OTTFilm
//
//  Created by 郭正豪 on 16/2/16.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import "OTTForgetPassView.h"
#import "OTTUserTool.h"
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
    sender.enabled = NO;
    if (self.phoneNumTextField.text.length == 11 && [OTTUserTool userQueryAccessForChangingPassWithPhoneNum:self.phoneNumTextField.text]) {
        self.currentTime = 60;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
        self.vertificationSent = YES;
        
        [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.phoneNumTextField.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
            if (!error) {
                
            }
        }];
    }else {
        // 输入正确的手机号
        sender.enabled = YES;
    }
}

- (IBAction)confirmAccount {
    if (self.isVertificationSent && self.vertificationTextFeild.text.length > 0) {
        [self commitAndBackWithVertification:self.vertificationTextFeild.text phoneNum:self.phoneNumTextField.text];
    }
}

- (void)updateTime {
    if (self.currentTime != 0) {
        [self.sendMessageButton setTitle:[NSString stringWithFormat:@"%ld", self.currentTime] forState:UIControlStateNormal];
        self.currentTime--;
    }else {
        self.sendMessageButton.enabled = YES;
        [self.sendMessageButton setTitle:@"发送" forState:UIControlStateNormal];
        [self.timer invalidate];
        self.timer = nil;
    }
}

@end
