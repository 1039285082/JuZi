//
//  SplashViewController.m
//  白卡回收
//
//  Created by WuShan on 2018/4/3.
//  Copyright © 2018年 Maideed. All rights reserved.
//

#import "SplashViewController.h"
#import "SessionData.h"
#import "ViewControllerAnchorSet.h"

@interface SplashViewController ()

@end

@implementation SplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self setNavigationBarHidden:YES];
    
    [self setupMainViewControllers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(void) setupMainViewControllers {
    SessionData* session = [SessionData getInstance];
    if(session.config.isNewsMode) {
        UIViewController* vc = nil;
        if(self.inspectVcDelegate && [self.inspectVcDelegate respondsToSelector:@selector(viewControllerForInspectMode)]) {
            vc = [self.inspectVcDelegate viewControllerForInspectMode];
        } else {
            vc = [[UIViewController alloc] init];
            [vc.view setFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height)];
            UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, UIScreen.mainScreen.bounds.size.height / 2, UIScreen.mainScreen.bounds.size.width, 40)];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = UIColor.darkGrayColor;
            label.font = [label.font fontWithSize:10.0];
            label.text = @"错误！本页面不应出现！未设置代理SplashViewController.inspectVcDelegate!";
            [vc.view addSubview:label];
        }
        [self setViewControllers:@[vc]];
    } else {
        UITabBarController* tabVc = [ViewControllerAnchorSet mainTabVcAfterLoad];
        [self setViewControllers:@[tabVc]];
    }
}


@end
