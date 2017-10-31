//
//  MYGiftNumberLabel.h
//  MYGiftAnimation
//
//  Created by mayan on 2017/10/31.
//  Copyright © 2017年 mayan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYGiftNumberLabel : UILabel

@property (nonatomic, strong) UIColor *outsideColor;
@property (nonatomic, strong) UIColor *insideColor;

- (void)showNumberAnimation:(void(^)(void))isFinished;

@end
