//
//  BWWSingleUser.m
//  BigWhiteWallet
//
//  Created by mac on 2018/6/8.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BWWSingleUser.h"
static BWWSingleUser*single=nil;

@implementation BWWSingleUser
+(BWWSingleUser *)sharedSingleUser{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        single=[[BWWSingleUser alloc]init];
    
    });
    return single;
}
-(NSString *)sandBoxPath{
    
    NSString *path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    path = [path stringByAppendingPathComponent:@"user.plist"];
    return path;
}
-(NSString*)sandBoxArrPath{
    NSString *path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    path = [path stringByAppendingPathComponent:@"arr.plist"];
    return path;
}
-(NSString*)sandBoxNotArrPath{
    NSString *path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    path = [path stringByAppendingPathComponent:@"notArr.plist"];
    return path;
    
    
}

@end
