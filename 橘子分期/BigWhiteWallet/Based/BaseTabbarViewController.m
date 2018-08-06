//
//  BaseTabbarViewController.m
//  BigWhiteWallet
//
//  Created by mac on 2018/6/26.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BaseTabbarViewController.h"
#import "BaseNavigationController.h"
#import "BWWStoreViewController.h"
#import "RepaymentViewController.h"
#import "LoginViewController.h"
#import "BWWMyViewController.h"
#import "DWQOrderListViewController.h"

@interface BaseTabbarViewController ()

@end

@implementation BaseTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    UITabBarController *tabBarVC=[[UITabBarController alloc]init];
    BWWStoreViewController *bwwVC=[[BWWStoreViewController alloc]init];
    BWWMyViewController*myVc=[[BWWMyViewController alloc]init];
    //    RepaymentViewController *payVc=[[RepaymentViewController alloc]init];
    DWQOrderListViewController *payVc=[[DWQOrderListViewController alloc]init];
    
    BaseNavigationController *bsVC1=[[BaseNavigationController alloc]initWithRootViewController:bwwVC];
    BaseNavigationController *bsVC2=[[BaseNavigationController alloc]initWithRootViewController:myVc];
    BaseNavigationController *bsVC3=[[BaseNavigationController alloc]initWithRootViewController:payVc];
    
    
    bsVC1.tabBarItem.title=@"商城";
    bsVC2.tabBarItem.title=@"我的";
    bsVC3.tabBarItem.title=@"订单";
    
    bsVC1.tabBarItem.image=[[UIImage imageNamed:@"shouye"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    bsVC1.tabBarItem.selectedImage=[[UIImage imageNamed:@"shouye_select"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    bsVC2.tabBarItem.image=[[UIImage imageNamed:@"wode"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    bsVC2.tabBarItem.selectedImage=[[UIImage imageNamed:@"wode_select"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    bsVC3.tabBarItem.image=[[UIImage imageNamed:@"dingdan"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    bsVC3.tabBarItem.selectedImage=[[UIImage imageNamed:@"dingdan_select"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    NSDictionary *dictHome1 = [NSDictionary dictionaryWithObject:[UIColor orangeColor] forKey:NSForegroundColorAttributeName];
    [bsVC1.tabBarItem setTitleTextAttributes:dictHome1 forState:UIControlStateSelected];
    
    NSDictionary *dictHome2 = [NSDictionary dictionaryWithObject:[UIColor orangeColor] forKey:NSForegroundColorAttributeName];
    [bsVC2.tabBarItem setTitleTextAttributes:dictHome2 forState:UIControlStateSelected];
    
    NSDictionary *dictHome3 = [NSDictionary dictionaryWithObject:[UIColor orangeColor] forKey:NSForegroundColorAttributeName];
    [bsVC3.tabBarItem setTitleTextAttributes:dictHome3 forState:UIControlStateSelected];
    
    
    self.tabBar.backgroundColor=[UIColor whiteColor];
    self.viewControllers=@[bsVC1,bsVC3,bsVC2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
