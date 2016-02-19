//
//  OTTRegisterView.m
//  OTTFilm
//
//  Created by 郭正豪 on 16/2/17.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import "OTTRegisterView.h"
@interface OTTRegisterView()
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextField;
@property (weak, nonatomic) IBOutlet UITextField *passTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPassTextField;
@property (weak, nonatomic) IBOutlet UITextField *mailTextField;

@end
@implementation OTTRegisterView

- (IBAction)cancel {
    [self cancelAndBack];
}

- (IBAction)commitAndBack {
    if (self.accountTextField.text.length > 0
        && self.phoneNumTextField.text.length > 0
        && self.passTextField.text.length > 0
        && self.confirmPassTextField.text.length > 0
        && self.mailTextField.text.length > 0
        ) {
        if ([self.passTextField.text isEqualToString:self.confirmPassTextField.text]) {
            [self commitAndBackWithRegisgerInfo:@{
                                                  @"account" : self.accountTextField.text,
                                                  @"phoneNum" : self.phoneNumTextField.text,
                                                  @"pass" : self.passTextField.text,
                                                  @"mail" : self.mailTextField.text
                                                  }];
        }
    }
}

@end
