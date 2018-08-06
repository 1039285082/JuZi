//
//  Helper.m
//  MeiDai-OC
//
//  Created by WuShan on 17/2/11.
//  Copyright © 2017年 Maideed. All rights reserved.
//

#import "Helper.h"
#import <UIKit/UIKit.h>
#import "AppConfiguration.h"

@implementation Helper

+(NSString*)getStringFromUrlRequest:urlString {
    NSURL* url = [NSURL URLWithString:urlString];
    NSURLResponse* response=nil;
    NSError* error = nil;
    @try {
        NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:2.0];
        [request setHTTPMethod: @"GET"];
        [request setTimeoutInterval: 2.0];
        NSData * data =[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
        if (httpResponse != nil) {
            if(httpResponse.statusCode == 200) {
                NSString* rawStr = [[NSString alloc] initWithData:data encoding: NSUTF8StringEncoding];
                NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:rawStr options:0];
                NSString *decodedString = [[NSString alloc] initWithData:decodedData encoding:NSUTF8StringEncoding];
                if(decodedData) {
                    return decodedString;
                } else {
                    return rawStr;
                }
            }
        }
    } @catch (NSException *exception) {
        return nil;
    } @finally {
        
    }
    return nil;
}

@end
