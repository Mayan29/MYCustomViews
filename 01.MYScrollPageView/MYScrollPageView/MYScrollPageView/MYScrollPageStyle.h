//
//  MYScrollPageStyle.h
//  MYScrollPageView
//
//  Created by mayan on 2017/10/11.
//  Copyright © 2017年 mayan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MYScrollPageStyleType) {
    MYScrollPageStyleTypeDefault1,  // 带底部滚动条
    MYScrollPageStyleTypeDefault2,  // 不带底部滚动条
    MYScrollPageStyleTypeDefault3,  // 所选 item 文字放大
};

@interface MYScrollPageStyle : NSObject

// MYScrollPageView
@property (nonatomic, assign) MYScrollPageStyleType type;

// MYScrollPageTitleBar
@property (nonatomic, assign) CGFloat titleBarHeight;   // titleBar 高度，默认 44
@property (nonatomic, assign) CGFloat titleItemMargin;  // titleItem 间隔，默认 30

@property (nonatomic, strong) UIColor  *titleNormalColor;    // 文字未选中状态颜色，默认黑色
@property (nonatomic, strong) UIColor  *titleSelectedColor;  // 文字选中状态颜色，默认橘色
@property (nonatomic, assign) UIFont   *titleFont;           // 文字大小，默认 15

@property (nonatomic, assign) CGFloat  titleScrollLineHeight;  // 文字下方滚动条高度，默认 2
@property (nonatomic, strong) UIColor *titleScrollLineColor;   // 文字下方滚动条颜色，默认橘色

// MYScrollPageCollectionView


@end
