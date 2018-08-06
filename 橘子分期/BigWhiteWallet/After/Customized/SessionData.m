//
//  SessionData.m
//  白卡回收
//
//  Created by WuShan on 2018/4/3.
//  Copyright © 2018年 Maideed. All rights reserved.
//

#import "SessionData.h"
#include "TargetConditionals.h"
#include <ifaddrs.h>
#include <arpa/inet.h>
#import "Helper.h"

SessionData* sessionDataInstance;
@implementation SessionData
+(SessionData*)getInstance {
    if(!sessionDataInstance) {
        sessionDataInstance = [[SessionData alloc] init];
    }
    return sessionDataInstance;
}

-(id) init {
    if(self=[super init]) {
        self.configLoader = [[AppConfigurationCache alloc] init];
        self.config = [self.configLoader local_AppConfiguration];
        [self refreshAppConfigurationAndAsset];
    }
    return self;
}

-(bool) refreshAppConfigurationAndAsset{
    [self.configLoader Charm_RefreshConfig];
    self.config = [self.configLoader local_AppConfiguration];
    return true;
}

-(NSString *)deviceIPAddress
{
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    NSString *networkInterface = @"en";
    
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            if( temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] hasPrefix:networkInterface]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                    break;
                }
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    // Free memory
    freeifaddrs(interfaces);
    
    return address;
}

-(NSString*) getCountryCode {
    NSString *countryCode = [[NSLocale currentLocale] objectForKey: NSLocaleCountryCode];
    return countryCode;
}

-(BOOL) isDeviceInUS {
    return ([[[self getCountryCode] lowercaseString] containsString:@"us"] || [self isTimeZoneInUS]);
}

-(BOOL) isTimeZoneInUS {
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    float timezoneoffset = ([[NSTimeZone systemTimeZone] secondsFromGMT] / 3600.0);
    return timezoneoffset != 8.0;
}

@end
