//
//  ViewController.m
//  MYWaterFall
//
//  Created by mayan on 2017/10/9.
//  Copyright © 2017年 mayan. All rights reserved.
//

#import "ViewController.h"
#import "MYWaterFallLayout.h"

// RGB颜色
#define MYColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
// 随机色
#define MYRandomColor MYColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))


@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, assign) NSUInteger cellCount;  // 每次显示的 item 数量，上拉加载用

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _cellCount = 30;

    MYWaterFallLayout *layout = [[MYWaterFallLayout alloc] init];
    
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 5;
    layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    [self.view addSubview:collectionView];
}

#pragma mark - collectionView delegate and data source
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = MYRandomColor;
    
    // 添加数字编号
    for (UIView *view in cell.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            [view removeFromSuperview];
        }
    }
    UILabel *label = [[UILabel alloc] initWithFrame:cell.bounds];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:40];
    label.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    [cell addSubview:label];
    
    // 模拟上拉刷新
    if (indexPath.item == _cellCount - 1) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            _cellCount += 30;
            [collectionView reloadData];
        });
    }
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _cellCount;
}

@end
