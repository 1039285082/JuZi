//
//  BWWSingleUser.h
//  BigWhiteWallet
//
//  Created by mac on 2018/6/8.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BWWUserInformation.h"
#import "OrderModel.h"
@interface BWWSingleUser : NSObject
@property (strong,nonatomic)BWWUserInformation * user;        //
@property (strong,nonatomic)NSMutableArray * orderArr;        //
@property (strong,nonatomic)NSMutableArray * notOrderArr;        //
+(BWWSingleUser*)sharedSingleUser;
-(NSString*)sandBoxPath;
-(NSString*)sandBoxArrPath;
-(NSString*)sandBoxNotArrPath;
@end
