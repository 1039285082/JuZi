//
//  SessionData.h
//  白卡回收
//
//  Created by WuShan on 2018/4/3.
//  Copyright © 2018年 Maideed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppConfigurationCache.h"
@class SessionData;
@interface SessionData : NSObject
+(SessionData*)getInstance;

@property NSMutableArray* selectedTags;
@property NSString* nandSize;
@property AppConfigurationCache *configLoader;
@property AppConfiguration* config;
-(bool) refreshAppConfigurationAndAsset;
-(NSString *)deviceIPAddress;
-(NSString *)getCountryCode;
-(BOOL) isDeviceInUS;
-(BOOL) isTimeZoneInUS;
@end
