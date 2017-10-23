//
//  MYChatToolsView.h
//  MYChatToolsView
//
//  Created by mayan on 2017/10/19.
//  Copyright © 2017年 mayan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MYChatToolsView;
@protocol MYChatToolsViewDelegate <NSObject>

- (void)chatToolsView:(MYChatToolsView *)chatToolsView message:(NSString *)message;

@end


@interface MYChatToolsView : UITextField

+ (instancetype)chatToolsViewWithDelegate:(id<MYChatToolsViewDelegate>)delegate;

- (void)showKeyboard;

@end
