//
//  OTTGeneralRegisterAndMissingView.h
//  OTTFilm
//
//  Created by 郭正豪 on 16/2/17.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OTTGeneralRegisterAndMissingView;
@protocol OTTRegisterAndMissingViewDelegate <NSObject>

- (void)ottForgetPassViewDidCancelPasswordChanging:(OTTGeneralRegisterAndMissingView  *)ottForgetPassView;
- (void)ottForgetPassView:(OTTGeneralRegisterAndMissingView *)ottForgetPassView didFinishEnterWithVertification:(NSString *)ver phoneNum:(NSString *)num;
- (void)ottForgetPassView:(OTTGeneralRegisterAndMissingView *)ottForgetPassView didFinishEnterWithRegisterInfo:(NSDictionary *)info;

@end

@interface OTTGeneralRegisterAndMissingView : UIView

@property (weak, nonatomic) id<OTTRegisterAndMissingViewDelegate> delegate;

- (void)cancelAndBack;
- (void)commitAndBackWithVertification:(NSString *)ver phoneNum:(NSString *)num;
- (void)commitAndBackWithRegisgerInfo:(NSDictionary *)info;

@end
