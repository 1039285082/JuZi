//
//  RealBuyViewController.h
//  BigWhiteWallet
//
//  Created by mac on 2018/6/21.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommodityModel.h"

@interface RealBuyViewController : UIViewController
@property (strong,nonatomic) CommodityModel * model;        //
@property (strong,nonatomic)NSString * orderNumber;        //
@property (strong,nonatomic)NSString * orderTime;        //
@property (strong,nonatomic)NSString * orderMouth;        //
@property (strong,nonatomic)NSString * orderMouthPrice;        //
@property (assign,nonatomic)BOOL  _isOrder;        //
@property (assign,nonatomic)long index;        //

@end
