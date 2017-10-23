//
//  ViewController.m
//  MYChatToolsView
//
//  Created by mayan on 2017/10/19.
//  Copyright © 2017年 mayan. All rights reserved.
//

#import "ViewController.h"
#import "MYChatToolsView.h"

@interface ViewController () <MYChatToolsViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *showLabel;

@property (nonatomic, strong) MYChatToolsView *chatToolsView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _chatToolsView = [MYChatToolsView chatToolsViewWithDelegate:self];
    [self.view addSubview:_chatToolsView];
}

// 点击首页的聊天按钮
- (IBAction)chatClick:(UIButton *)sender
{
    [_chatToolsView showKeyboard];
}

#pragma mark - MYChatToolsViewDelegate
- (void)chatToolsView:(MYChatToolsView *)chatToolsView message:(NSString *)message
{
    self.showLabel.text = [NSString stringWithFormat:@"输入的信息为：%@", message];
}

@end
