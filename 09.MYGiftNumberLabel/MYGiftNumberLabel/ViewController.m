//
//  ViewController.m
//  MYGiftNumberLabel
//
//  Created by mayan on 2017/10/31.
//  Copyright © 2017年 mayan. All rights reserved.
//

#import "ViewController.h"
#import "MYGiftNumberLabel.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet MYGiftNumberLabel *giftNumberLabel;
@property (nonatomic, strong) UIButton *currentButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _giftNumberLabel.outsideColor = [UIColor orangeColor];
    _giftNumberLabel.insideColor  = [UIColor whiteColor];
}

- (IBAction)giftClick:(UIButton *)sender
{
    NSInteger num = _giftNumberLabel.text.length ? [_giftNumberLabel.text substringFromIndex:1].integerValue + 1 : 1;
    _giftNumberLabel.text = (_currentButton == sender) ? [NSString stringWithFormat:@"X%ld", num] : @"X1";
    _currentButton = sender;
    
    [_giftNumberLabel showNumberAnimation:^{
        NSLog(@"动画完成");
    }];
}


@end
