//
//  OrderModel.m
//  BigWhiteWallet
//
//  Created by mac on 2018/6/22.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "OrderModel.h"

@implementation OrderModel
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.order_name forKey:@"order_name"];
    [aCoder encodeObject:self.order_address forKey:@"order_address"];
    [aCoder encodeObject:self.order_detailAddress forKey:@"order_detailAddress"];
    [aCoder encodeObject:self.order_phoneNmuber forKey:@"order_phoneNmuber"];
    [aCoder encodeObject:self.order_image forKey:@"order_image"];
    [aCoder encodeObject:self.order_title forKey:@"order_title"];
    [aCoder encodeObject:self.order_price forKey:@"order_price"];
    [aCoder encodeObject:self.order_orderTime forKey:@"order_orderTime"];
    [aCoder encodeObject:self.order_orderNumber forKey:@"order_orderNumber"];
    [aCoder encodeObject:self.order_mouthNumber forKey:@"order_mouthNumber"];
    [aCoder encodeObject:self.order_mouthPrice forKey:@"order_mouthPrice"];
}

- (instancetype)initWithCoder:( NSCoder *)aDecoder {
    self.order_name=[aDecoder decodeObjectForKey:@"order_name"];
    self.order_address=[aDecoder decodeObjectForKey:@"order_address"];
    self.order_detailAddress=[aDecoder decodeObjectForKey:@"order_detailAddress"];
    self.order_phoneNmuber=[aDecoder decodeObjectForKey:@"order_phoneNmuber"];
    self.order_image=[aDecoder decodeObjectForKey:@"order_image"];
    self.order_title=[aDecoder decodeObjectForKey:@"order_title"];
    self.order_price=[aDecoder decodeObjectForKey:@"order_price"];
    self.order_orderTime=[aDecoder decodeObjectForKey:@"order_orderTime"];
    self.order_orderNumber=[aDecoder decodeObjectForKey:@"order_orderNumber"];
    
    self.order_mouthNumber=[aDecoder decodeObjectForKey:@"order_mouthNumber"];
    self.order_mouthPrice=[aDecoder decodeObjectForKey:@"order_mouthPrice"];
    return self;
}


@end
