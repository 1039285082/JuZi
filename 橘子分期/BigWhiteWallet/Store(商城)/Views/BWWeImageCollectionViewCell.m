//
//  BWWeImageCollectionViewCell.m
//  BigWhiteWallet
//
//  Created by mac on 2018/6/6.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BWWeImageCollectionViewCell.h"
#import <SDCycleScrollView.h>
@implementation BWWeImageCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    SDCycleScrollView*cycleScrollView=[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, KScreenWidth, 200) imageNamesGroup:@[@"h1.png",@"h2.png",@"h3.png"]];
    [self.contentView addSubview:cycleScrollView];
}

@end
