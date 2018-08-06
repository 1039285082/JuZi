//
//  OrderModel.h
//  BigWhiteWallet
//
//  Created by mac on 2018/6/22.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderModel : NSObject<NSCoding>
// ******************订单******************
@property (copy,nonatomic)NSString * order_name;        //订单名字
@property (copy,nonatomic)NSString * order_phoneNmuber;        //订单电话号码
@property (copy,nonatomic)NSString * order_address;        //订单地址
@property (copy,nonatomic)NSString * order_detailAddress;        //订单详细地址
@property (copy,nonatomic)NSString *order_image;        //订单照片
@property (copy,nonatomic)NSString * order_title;        //订单标题
@property (copy,nonatomic)NSString * order_price;        //订单价钱
@property (copy,nonatomic)NSString * order_orderNumber;        //订单号

@property (copy,nonatomic)NSString * order_orderTime;        //订单时间
@property (copy,nonatomic)NSString * order_mouthNumber;        //订单分期月数
@property (copy,nonatomic)NSString * order_mouthPrice;        //订单分期每月价格
@end
//[self.Price intValue]/[self.mouthPrice intValue] + 1
