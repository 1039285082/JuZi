//
//  DetailsViewController.h
//  BigWhiteWallet
//
//  Created by mac on 2018/6/11.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommodityModel.h"
@interface DetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong,nonatomic) NSMutableArray* detailsModelArr;        //
@property (weak, nonatomic) IBOutlet UILabel *topPrice;
@property (weak, nonatomic) IBOutlet UILabel *mouthPrice;
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;

@property (strong,nonatomic)CommodityModel  * model;        //
@end
