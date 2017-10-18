//
//  ViewController.m
//  MYGiftKeyboard
//
//  Created by mayan on 2017/10/16.
//  Copyright © 2017年 mayan. All rights reserved.
//

#import "ViewController.h"
#import "MYGiftKeyboard.h"

@interface ViewController () 

@property (nonatomic, strong) MYGiftKeyboard *giftKeyboard;

@end

@implementation ViewController

// 弹起礼物键盘
- (IBAction)giftClick:(UIButton *)sender
{
    [_giftKeyboard showKeyboard];
}


- (void)viewDidLoad {
    [super viewDidLoad];
 
    // 1. 标题
    NSArray *titles = @[@"热门", @"高级", @"豪华", @"专属"];
    // 2. 样式
    MYGiftKeyboardStyle *style = [[MYGiftKeyboardStyle alloc] init];
    // 3. 传入模型（模型需要根据数据情况自行封装）
    NSMutableArray *models = [NSMutableArray array];
    for (int i = 0; i < titles.count; i++) {
        NSMutableArray *arr = [NSMutableArray array];
        for (int j = 0; j < 10; j++) {
            [arr addObject:[[MYGiftKeyboardModel alloc] init]];
        }
        [models addObject:arr];
    }
    
    _giftKeyboard = [MYGiftKeyboard keyboardWithTitles:titles style:style models:models];
    _giftKeyboard.commitClickBlock = ^(MYGiftKeyboardModel *model) {
        NSLog(@"点击了 %@", model);
    };
    [self.view addSubview:_giftKeyboard];
}

@end
