//
//  AppConfigurationCache.h
//  MeiDai-OC
//
//  Created by WuShan on 17/2/11.
//  Copyright © 2017年 Maideed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppConfiguration.h"

@interface AppConfigurationCache : NSObject
@property NSString* appSecret;
@property AppConfiguration* defaultConfig;
@property NSData* defaultJson;
@property NSString* server_address;
@property int server_port;
@property AppConfiguration* local_AppConfiguration;
-(bool)Charm_IsRefreshNeeded;
-(bool)Charm_RefreshConfig;
-(AppConfiguration*)Charm_DefaultConfig;

@end
