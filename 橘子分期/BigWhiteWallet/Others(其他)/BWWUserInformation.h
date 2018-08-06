//
//  BWWUserInformation.h
//  BigWhiteWallet
//
//  Created by mac on 2018/6/8.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BWWUserInformation : NSObject<NSCoding>
@property (copy,nonatomic)NSString * user_phoneNumber;        //用户电话号码
@property (copy,nonatomic)NSString * user_account;        //用户账号
@property (copy,nonatomic)NSString * user_password;        //用户密码
@property (assign,nonatomic)BOOL isLogin;        //是否登录了

// ******************银行卡认证******************
@property (copy,nonatomic)NSString * user_bankNumber;        //用户银行卡号
@property (copy,nonatomic)NSString * user_bankName;        //用户银行名称
// ******************身份证认证******************
@property (copy,nonatomic)NSString * IDinfo_name;        //姓名
@property (copy,nonatomic)NSString * IDinfo_address;        //地址
@property (copy,nonatomic) NSString * IDinfo_code;        //身份证号
// ******************订单******************
@property (copy,nonatomic)NSString * order_name;        //订单名字
@property (copy,nonatomic)NSString * order_phoneNmuber;        //订单电话号码
@property (copy,nonatomic)NSString * order_address;        //订单地址
@property (copy,nonatomic)NSString * order_detailAddress;        //订单详细地址
@property (copy,nonatomic)NSString *order_image;        //订单照片
@property (copy,nonatomic)NSString * order_title;        //订单标题
@property (copy,nonatomic)NSString * order_price;        //订单价钱

//  704308
@end
