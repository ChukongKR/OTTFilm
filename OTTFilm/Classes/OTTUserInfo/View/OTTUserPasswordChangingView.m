//
//  OTTUserPasswordChangingView.m
//  OTTFilm
//
//  Created by 郭正豪 on 16/2/24.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import "OTTUserPasswordChangingView.h"
@interface OTTUserPasswordChangingView()
@property (weak, nonatomic) IBOutlet UITextField *originalPass;
@property (weak, nonatomic) IBOutlet UITextField *currentPass;
@property (weak, nonatomic) IBOutlet UITextField *confirmPass;

@end
@implementation OTTUserPasswordChangingView


- (IBAction)confirmPassChange {
    if (self.originalPass.text.length == 0 || self.currentPass.text.length == 0 || self.confirmPass.text.length == 0) {
        return;
    }
    if ([self.delegate respondsToSelector:@selector(passwordChangingView:confirmChangeWithParams:)] && [self.currentPass.text isEqualToString:self.confirmPass.text]) {
        [self.delegate passwordChangingView:self
                    confirmChangeWithParams:@{
                                            @"originalPass":self.originalPass.text,
                                            @"newPass":self.currentPass.text
                                            }];
    }
}

- (void)setHidden:(BOOL)hidden {
    [super setHidden:hidden];
    if (self.hidden == YES) {
        self.originalPass.text = nil;
        self.currentPass.text = nil;
        self.confirmPass.text = nil;
    }
}

@end
