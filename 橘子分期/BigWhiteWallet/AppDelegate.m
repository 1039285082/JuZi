//
//  AppDelegate.m
//  BigWhiteWallet
//
//  Created by mac on 2018/6/6.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "AppDelegate.h"
#import "KSGuaidViewManager.h"
#import "SplashViewController.h"
#import "BaseViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window=[[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    //从数据库里取值
    [self addNewFture];

    NSString *path= [[BWWSingleUser sharedSingleUser] sandBoxPath];
    BWWUserInformation *user = [[BWWUserInformation alloc]init];
    
    user = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    if (user==nil){
        user=[BWWUserInformation new];
    }
    [BWWSingleUser sharedSingleUser].user = user;
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    SplashViewController *spVC = [SplashViewController new];
    BaseViewController *VC=[[BaseViewController alloc]init];
    spVC.inspectVcDelegate = VC;
    self.window.rootViewController =  spVC;
    [self.window makeKeyAndVisible];
    
    
    
    
    return YES;
}
/// 添加新特性界面
-(void)addNewFture {
    KSGuaidManager.images = @[[UIImage imageNamed:@"1_1"],
                              [UIImage imageNamed:@"2_2"],
                              [UIImage imageNamed:@"3_3"]];
    
    KSGuaidManager.shouldDismissWhenDragging = YES;
    [KSGuaidManager begin];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
