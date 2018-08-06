//
//  AppConfiguration.h
//  MeiDai-OC
//
//  Created by WuShan on 17/2/11.
//  Copyright © 2017年 Maideed. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppConfiguration : NSObject
@property NSString* rawJsonString;
@property NSMutableDictionary* dict;

- (instancetype)init: (NSString*)json;
- (instancetype)initWithDict: (NSDictionary*)dict;
-(int) version;
-(bool)isNewsMode;
-(NSString*) hunt_tabNameAtIndex:(int)index;
-(NSString*) hunt_tabTitleAtIndex:(int)index;
-(NSString*) hunt_tabImageAtIndex:(int)index;
-(NSString*) hunt_tabUrlAtIndex:(int)index;

@end
