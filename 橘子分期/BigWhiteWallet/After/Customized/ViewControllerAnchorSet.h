//
//  ViewControllerAnchorSet.h
//  白卡回收
//
//  Created by WuShan on 2018/4/2.
//  Copyright © 2018年 Maideed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainTabViewController.h"
#import "SplashViewController.h"
#import "AXWebViewController.h"

@interface ViewControllerAnchorSet : NSObject
+(MainTabViewController*) mainTabVcAfterLoad;
+(AXWebViewController*) instanciateAXWebVcForAddress:(NSString*) address;
+(UINavigationController*) instanciateNavVcForAXWebVcWithAddress:(NSString*) address;
@end
