//
//  MYGiftNumberLabel.m
//  MYGiftAnimation
//
//  Created by mayan on 2017/10/31.
//  Copyright © 2017年 mayan. All rights reserved.
//

#import "MYGiftNumberLabel.h"

@implementation MYGiftNumberLabel

#pragma mark - Set
- (void)setOutsideColor:(UIColor *)outsideColor
{
    _outsideColor = outsideColor;
}

- (void)setInsideColor:(UIColor *)insideColor
{
    _insideColor = insideColor;
}

- (void)showNumberAnimation:(void (^)(void))isFinished
{
    [UIView animateKeyframesWithDuration:0.25 delay:0 options:0 animations:^{
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.5 animations:^{
            self.transform = CGAffineTransformMakeScale(3.0, 3.0);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.5 animations:^{
            self.transform = CGAffineTransformMakeScale(0.7, 0.7);
        }];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:10 options:0 animations:^{
            self.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            if (isFinished) {
                isFinished();
            }
        }];
    }];
}


#pragma mark - Init
- (void)drawTextInRect:(CGRect)rect
{
    // 1.获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 2.给上下文线段设置一个宽度，通过该宽度画出文本
    CGContextSetLineWidth(context, 5);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetTextDrawingMode(context, kCGTextStroke);
    self.textColor = _outsideColor ?: [UIColor orangeColor];
    [super drawTextInRect:rect];
    
    CGContextSetTextDrawingMode(context, kCGTextFill);
    self.textColor = _insideColor ?: [UIColor whiteColor];
    [super drawTextInRect:rect];
}

@end
