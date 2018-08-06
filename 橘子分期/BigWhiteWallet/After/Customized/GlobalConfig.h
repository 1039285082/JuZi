//
//  GlobalConfig.h
//  MeiDai-OC
//
//  Created by WuShan on 17/2/11.
//  Copyright © 2017年 Maideed. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalConfig : NSObject
+(NSString*) Cheer_ConfigServerAddress;
+(int) Cheer_ConfigServerPort;
+(NSMutableDictionary*) ChooCheerMapping;
@end
