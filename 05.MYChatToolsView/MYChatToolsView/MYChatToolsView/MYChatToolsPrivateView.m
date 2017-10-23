//
//  MYChatToolsPrivateView.m
//  MYChatToolsView
//
//  Created by mayan on 2017/10/19.
//  Copyright © 2017年 mayan. All rights reserved.
//

#import "MYChatToolsPrivateView.h"

@interface MYChatToolsPrivateView () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@property (weak, nonatomic) IBOutlet UIButton    *sendMsgButton;

@end

@implementation MYChatToolsPrivateView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    // 1. 初始化 inputView 中的 rightView
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"MYChatToolsViewResources/emoji"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"MYChatToolsViewResources/keyboard"] forState:UIControlStateSelected];
    [button addTarget:self action:@selector(emojiButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _inputTextField.rightView                     = button;
    _inputTextField.rightViewMode                 = UITextFieldViewModeAlways;
    _inputTextField.allowsEditingTextAttributes   = YES;
    _inputTextField.delegate                      = self;
    _inputTextField.enablesReturnKeyAutomatically = YES;
    [_inputTextField addTarget:self action:@selector(textInfo:) forControlEvents:UIControlEventEditingChanged];
    
    // 2. 初始化 sendMsgButton
    _sendMsgButton.layer.cornerRadius = _sendMsgButton.bounds.size.height / 4;
    _sendMsgButton.enabled            = NO;
}

#pragma mark - Button click
// 表情
- (void)emojiButtonClick:(UIButton *)sender
{
    sender.selected = !sender.isSelected;
}

// 发送
- (IBAction)sendMsgClick:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(chatToolsPrivateView:message:)]) {
        [self.delegate chatToolsPrivateView:self message:_inputTextField.text];
    }
    _inputTextField.text = @"";
    [self textInfo:_inputTextField];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self sendMsgClick:_sendMsgButton];
    return YES;
}

- (void)textInfo:(UITextField *)textField
{
    _sendMsgButton.enabled = !(textField.text.length == 0);
    [_sendMsgButton setBackgroundColor:(textField.text.length ? [UIColor orangeColor] : [UIColor darkGrayColor])];
}

#pragma mark - Action
- (void)becomeFirstResponder
{
    [_inputTextField becomeFirstResponder];
}

- (void)resignFirstResponder
{
    [_inputTextField resignFirstResponder];
}

@end



