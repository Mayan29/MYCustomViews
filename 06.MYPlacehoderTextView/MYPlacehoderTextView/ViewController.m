//
//  ViewController.m
//  MYPlacehoderTextView
//
//  Created by mayan on 2017/10/23.
//  Copyright © 2017年 mayan. All rights reserved.
//

#import "ViewController.h"
#import "MYPlacehoderTextView.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    MYPlacehoderTextView *textView = [[MYPlacehoderTextView alloc] init];
    textView.frame = CGRectMake(20, 50, self.view.bounds.size.width - 40, 200);
    textView.placeholder = @"请输入您的姓名";
    
    [self.view addSubview:textView];
}


@end
