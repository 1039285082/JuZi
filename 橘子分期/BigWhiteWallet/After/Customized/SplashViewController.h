//
//  SplashViewController.h
//  白卡回收
//
//  Created by WuShan on 2018/4/3.
//  Copyright © 2018年 Maideed. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol GetInspectModeViewControllerDelegate <NSObject>
    @required
    -(UIViewController*) viewControllerForInspectMode;
@end

@interface SplashViewController : UINavigationController
@property (weak, nonatomic) id <GetInspectModeViewControllerDelegate> inspectVcDelegate;
@end
