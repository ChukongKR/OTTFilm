//
//  OTTGeneralRegisterAndMissingView.m
//  OTTFilm
//
//  Created by 郭正豪 on 16/2/17.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import "OTTGeneralRegisterAndMissingView.h"

@implementation OTTGeneralRegisterAndMissingView

- (void)cancelAndBack {
    if ([self.delegate respondsToSelector:@selector(ottForgetPassViewDidCancelPasswordChanging:)]) {
        [self.delegate ottForgetPassViewDidCancelPasswordChanging:self];
    }
}

- (void)commitAndBackWithVertification:(NSString *)ver phoneNum:(NSString *)num {
    if ([self.delegate respondsToSelector:@selector(ottForgetPassView:didFinishEnterWithVertification:phoneNum:)]) {
        [self.delegate ottForgetPassView:self didFinishEnterWithVertification:ver phoneNum:num];
    }
}

- (void)commitAndBackWithRegisgerInfo:(NSDictionary *)info {
    if ([self.delegate respondsToSelector:@selector(ottForgetPassView:didFinishEnterWithRegisterInfo:)]) {
        [self.delegate ottForgetPassView:self didFinishEnterWithRegisterInfo:info];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
}

@end
