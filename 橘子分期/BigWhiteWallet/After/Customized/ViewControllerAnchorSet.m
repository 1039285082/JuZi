//
//  ViewControllerAnchorSet.m
//  白卡回收
//
//  Created by WuShan on 2018/4/2.
//  Copyright © 2018年 Maideed. All rights reserved.
//

#import "ViewControllerAnchorSet.h"
#import "GlobalConfig.h"
#import "SessionData.h"

MainTabViewController* rootTabVcAfterLoad;

@implementation ViewControllerAnchorSet

+(MainTabViewController *) mainTabVcAfterLoad {
    if(!rootTabVcAfterLoad) {
        rootTabVcAfterLoad =  [MainTabViewController new];
        AppConfiguration* config = [SessionData getInstance].config;
        NSMutableArray* subVcList = [[NSMutableArray alloc] initWithArray: rootTabVcAfterLoad.viewControllers];
        NSArray* tabBarItems = rootTabVcAfterLoad.tabBar.items;
        if(config != nil) {
            for(int i = 0;i < 4;i++) {
                NSString* tabUrl = [config hunt_tabUrlAtIndex:i];
                if(tabUrl && ![tabUrl isEqualToString:@""]) {
                    UINavigationController* navVc = [ViewControllerAnchorSet instanciateNavVcForAXWebVcWithAddress:tabUrl];
                    navVc.tabBarItem = tabBarItems[i];
                    subVcList[i] = navVc;
                }
                    
                NSString* navTitle = [config hunt_tabTitleAtIndex:i];
                if(navTitle && ![navTitle isEqualToString:@""]) {
                    UINavigationController* navV = (UINavigationController*)(subVcList[i]);
                    navV.title = navTitle;
                    navV.title = navTitle;
                }
                NSString* tabImgUrl = [config hunt_tabImageAtIndex:i];
                if(tabImgUrl && ![tabImgUrl isEqualToString:@""]) {
                    NSData* imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:tabImgUrl]];
                    UIImage* img = [UIImage imageWithData:imageData];
                    if(img) {
                        [(UITabBarItem*)(tabBarItems[i]) setImage:img];
                    }
                }
            }
        }
        
        [rootTabVcAfterLoad setViewControllers:subVcList];
//        [rootTabVcAfterLoad setvie];
    }
    return rootTabVcAfterLoad;
}

+(AXWebViewController*) instanciateAXWebVcForAddress:(NSString *)address {
    AXWebViewController* axWebVc = [[AXWebViewController alloc] initWithAddress:address];
    axWebVc.showsToolBar = NO;
    axWebVc.navigationController.navigationBar.translucent = NO;
    return axWebVc;
    /*UINavigationController* axWebNavVc = [[UINavigationController alloc] initWithRootViewController:axWebVc];
    axWebNavVc.tabBarItem = rootTabVcAfterLoad.viewControllers[1].tabBarItem;
    axWebNavVc.navigationBar.tintColor = [UIColor colorWithRed:0.100f green:0.100f blue:0.100f alpha:0.800f];
    axWebNavVc.navigationBar.barTintColor = [UIColor colorWithRed:0.996f green:0.867f blue:0.522f alpha:1.00f];
     */
}

+(UINavigationController*) instanciateNavVcForAXWebVcWithAddress:(NSString *)address {
    AXWebViewController* axWebVc = [[AXWebViewController alloc] initWithAddress:address];
    axWebVc.showsToolBar = NO;
    axWebVc.navigationController.navigationBar.translucent = NO;
    UINavigationController* axWebNavVc = [[UINavigationController alloc] initWithRootViewController:axWebVc];
    axWebNavVc.tabBarItem = rootTabVcAfterLoad.viewControllers[1].tabBarItem;
    axWebNavVc.navigationBar.tintColor = [UIColor colorWithRed:0.100f green:0.100f blue:0.100f alpha:0.800f];
    axWebNavVc.navigationBar.barTintColor = [UIColor colorWithRed:0.996f green:0.867f blue:0.522f alpha:1.00f];
//    axWebNavVc.navigationBar.barTintColor = [UIColor whiteColor];
    return axWebNavVc;
}

@end
