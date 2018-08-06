//
//  AppConfigurationCache.m
//  MeiDai-OC
//
//  Created by WuShan on 17/2/11.
//  Copyright © 2017年 Maideed. All rights reserved.
//

#import "AppConfigurationCache.h"
#import "GlobalConfig.h"
#import "Helper.h"

@implementation AppConfigurationCache

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSString* bundleId = [[NSBundle mainBundle] bundleIdentifier];
        self.appSecret = GlobalConfig.ChooCheerMapping[bundleId];
        self.defaultConfig = [[AppConfiguration alloc] init];
        
        self.local_AppConfiguration = self.defaultConfig;
        self.server_address = GlobalConfig.Cheer_ConfigServerAddress;
        self.server_port = GlobalConfig.Cheer_ConfigServerPort;
    }
    return self;
}

-(bool)Charm_IsRefreshNeeded{
    return YES;
}

-(bool)Charm_RefreshConfig{
    int server_config_ver = 100;
    NSString* urlString = [NSString stringWithFormat:@"http://%@:%d/config/%@/config_%d.xson", self.server_address, self.server_port, self.appSecret, server_config_ver];
    NSString* json = [Helper getStringFromUrlRequest:urlString];
    if(json == nil) {
        self.local_AppConfiguration = self.defaultConfig;
        return false;
    }
    NSDictionary* jsonObj = [NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
    if(jsonObj == nil) {
        self.local_AppConfiguration = self.defaultConfig;
        return false;
    }
    self.local_AppConfiguration = [[AppConfiguration alloc] initWithDict: jsonObj];
    [self.local_AppConfiguration setRawJsonString: json];
    return true;
}

-(AppConfiguration*)Charm_DefaultConfig{
    return self.defaultConfig;
}
@end
