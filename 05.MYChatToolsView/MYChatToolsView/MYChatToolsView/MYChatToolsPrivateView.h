//
//  MYChatToolsPrivateView.h
//  MYChatToolsView
//
//  Created by mayan on 2017/10/19.
//  Copyright © 2017年 mayan. All rights reserved.
//
//  私有控件

#import <UIKit/UIKit.h>

@class MYChatToolsPrivateView;
@protocol MYChatToolsPrivateViewDelegate <NSObject>

- (void)chatToolsPrivateView:(MYChatToolsPrivateView *)chatToolsPrivateView message:(NSString *)message;

@end


@interface MYChatToolsPrivateView : UIView

@property (nonatomic, weak) id<MYChatToolsPrivateViewDelegate> delegate;

- (void)becomeFirstResponder;
- (void)resignFirstResponder;

@end
