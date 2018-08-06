//
//  StageDetailTableViewCell.h
//  BigWhiteWallet
//
//  Created by mac on 2018/6/14.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StageDetailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *topPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *mouthPriceLabel;
@property (weak, nonatomic) IBOutlet UIButton *detailBtn;
@property (weak, nonatomic) IBOutlet UILabel *totalMouthLabel;

@end
