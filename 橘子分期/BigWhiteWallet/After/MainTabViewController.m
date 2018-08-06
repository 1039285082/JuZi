//
//  MainTabViewController.m
//  MeiDai-OC
//
//  Created by WuShan on 17/1/29.
//  Copyright © 2017年 Maideed. All rights reserved.
//

#import "MainTabViewController.h"
#import "SessionData.h"

@interface MainTabViewController ()

@end

@implementation MainTabViewController

-(id) init {
    if(self = [super init]) {
        
        NSMutableArray* vcList = [NSMutableArray new];
        for(int i = 0; i < 4;i++) {
            UIViewController* vc = [UIViewController new];
            vc.title = [NSString stringWithFormat: @"VC%d", i + 1];
            UINavigationController *vcNav = [[UINavigationController alloc]
                                              initWithRootViewController:vc];
            [vcList addObject:vcNav];
        }
        
        self.viewControllers = vcList;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.config = [SessionData getInstance].config;
    if(self.config != nil) {
        for(int i=0;i<4;i++) {
            [[[self tabBar] items][i] setTitle: [self.config hunt_tabNameAtIndex:i]];
        }
    }
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
