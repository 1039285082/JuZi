//
//  BWWUserInformation.m
//  BigWhiteWallet
//
//  Created by mac on 2018/6/8.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BWWUserInformation.h"

@implementation BWWUserInformation
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
        self.user_account=[aDecoder decodeObjectForKey:@"account"];
        self.user_password=[aDecoder decodeObjectForKey:@"password"];
        self.user_phoneNumber=[aDecoder decodeObjectForKey:@"phoneNumber"];
        self.user_bankName=[aDecoder decodeObjectForKey:@"bankName"];
        self.user_bankNumber=[aDecoder decodeObjectForKey:@"bankNumber"];
        self.IDinfo_code=[aDecoder decodeObjectForKey:@"code"];
        self.IDinfo_name=[aDecoder decodeObjectForKey:@"name"];
        self.IDinfo_address=[aDecoder decodeObjectForKey:@"address"];
    self.order_name=[aDecoder decodeObjectForKey:@"order_name"];
    self.order_address=[aDecoder decodeObjectForKey:@"order_address"];
    self.order_detailAddress=[aDecoder decodeObjectForKey:@"order_detailAddress"];
    self.order_phoneNmuber=[aDecoder decodeObjectForKey:@"order_phoneNmuber"];
    self.order_image=[aDecoder decodeObjectForKey:@"order_image"];
    self.order_title=[aDecoder decodeObjectForKey:@"order_title"];
    self.order_price=[aDecoder decodeObjectForKey:@"order_price"];
    self.isLogin=[aDecoder decodeBoolForKey:@"isLogin"];
    
    
    
    return self;
}

- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
    [aCoder encodeObject:self.user_account forKey:@"account"];
    [aCoder encodeObject:self.user_password forKey:@"password"];
    [aCoder encodeObject:self.user_phoneNumber forKey:@"phoneNumber"];
    [aCoder encodeObject:self.user_bankName forKey:@"bankName"];
    [aCoder encodeObject:self.user_bankNumber forKey:@"bankNumber"];
    [aCoder encodeObject:self.IDinfo_code forKey:@"code"];
    [aCoder encodeObject:self.IDinfo_name forKey:@"name"];
    [aCoder encodeObject:self.IDinfo_address forKey:@"address"];
    [aCoder encodeObject:self.order_name forKey:@"order_name"];
    [aCoder encodeObject:self.order_address forKey:@"order_address"];
    [aCoder encodeObject:self.order_detailAddress forKey:@"order_detailAddress"];
    [aCoder encodeObject:self.order_phoneNmuber forKey:@"order_phoneNmuber"];
    [aCoder encodeObject:self.order_image forKey:@"order_image"];
    [aCoder encodeObject:self.order_title forKey:@"order_title"];
    [aCoder encodeObject:self.order_price forKey:@"order_price"];
    [aCoder encodeBool:self.isLogin forKey:@"isLogin"];
 
}


@end
