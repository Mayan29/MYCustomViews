//
//  MYChatToolsView.m
//  MYChatToolsView
//
//  Created by mayan on 2017/10/19.
//  Copyright © 2017年 mayan. All rights reserved.
//

#import "MYChatToolsView.h"
#import "MYChatToolsPrivateView.h"

@interface MYChatToolsView () <MYChatToolsPrivateViewDelegate>

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, weak) id<MYChatToolsViewDelegate> my_delegate;
@property (nonatomic, strong) MYChatToolsPrivateView *chatToolsPrivateView;

@end

@implementation MYChatToolsView


#pragma mark - Init
+ (instancetype)chatToolsViewWithDelegate:(id<MYChatToolsViewDelegate>)delegate
{
    MYChatToolsView *chatToolsView = [[MYChatToolsView alloc] initWithFrame:CGRectZero];
    chatToolsView.my_delegate = delegate;
    chatToolsView.inputAccessoryView = chatToolsView.chatToolsPrivateView;
    return chatToolsView;
}


#pragma mark - Action
- (void)showKeyboard
{
    [[UIApplication sharedApplication].keyWindow addSubview:self.bgView];
    
    [self becomeFirstResponder];
    [self.inputAccessoryView becomeFirstResponder];
}

- (void)hiddenKeyboard
{
    [self.bgView removeFromSuperview];
    
    [self.inputAccessoryView resignFirstResponder];
    [self resignFirstResponder];
}


#pragma mark - MYChatToolsPrivateViewDelegate
- (void)chatToolsPrivateView:(MYChatToolsPrivateView *)chatToolsPrivateView message:(NSString *)message
{
    if ([_my_delegate respondsToSelector:@selector(chatToolsView:message:)]) {
        [_my_delegate chatToolsView:self message:message];
    }
    [self hiddenKeyboard];
}


#pragma mark - Lazy load
- (MYChatToolsPrivateView *)chatToolsPrivateView
{
    if (!_chatToolsPrivateView) {
        _chatToolsPrivateView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([MYChatToolsPrivateView class]) owner:nil options:nil].firstObject;
        _chatToolsPrivateView.frame = CGRectMake(0, 0, 0, 44);
        _chatToolsPrivateView.delegate = self;
    }
    return _chatToolsPrivateView;
}

- (UIView *)bgView
{
    if (!_bgView) {
        
        _bgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _bgView.backgroundColor = [UIColor clearColor];
        [_bgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenKeyboard)]];
    }
    return _bgView;
}

@end
