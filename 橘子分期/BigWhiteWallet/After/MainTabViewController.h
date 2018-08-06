//
//  MainTabViewController.h
//  MeiDai-OC
//
//  Created by WuShan on 17/1/29.
//  Copyright © 2017年 Maideed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "AppConfiguration.h"

@interface MainTabViewController : UITabBarController
@property AppDelegate* app_delegate;
@property AppConfiguration* config;
@property UIActivityIndicatorView* spinner;
@property bool isNetworkReachable;
@end
