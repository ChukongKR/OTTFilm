//
//  OTTUserPasswordChangingView.h
//  OTTFilm
//
//  Created by 郭正豪 on 16/2/24.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OTTUserPasswordChangingView;
@protocol OTTUserPasswordChangingViewDelegate <NSObject>

- (void)passwordChangingView:(OTTUserPasswordChangingView *)passView confirmChangeWithParams:(NSDictionary *)params;

@end

@interface OTTUserPasswordChangingView : UIView

@property (weak, nonatomic) id<OTTUserPasswordChangingViewDelegate> delegate;

@end
