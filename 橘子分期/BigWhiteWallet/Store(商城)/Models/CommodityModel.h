//
//  CommodityModel.h
//  BigWhiteWallet
//
//  Created by mac on 2018/6/11.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommodityModel : NSObject
@property (copy,nonatomic)NSString * title;        //商品名称
@property (copy,nonatomic)NSString * price_text;    //总价
@property (copy,nonatomic)NSString * mouthPrice;        //月供
@property (strong,nonatomic)NSString * image;        //图片网址
@property (strong,nonatomic)NSString * link;        //详情h5

@end
