//
//  MyView.h
//  弹出动画_demo2
//
//  Created by liman on 11/26/15.
//  Copyright © 2015 apple. All rights reserved.
//

#import "PopView.h"
@class MyView;
@protocol MyViewDelegate <NSObject>

- (void)myView:(MyView *)myView didSelectedSelf:(id)sender;
- (void)myView:(MyView *)myView didSelectedShadow:(id)sender;
- (void)myView:(MyView *)myView;

@end

@interface MyView : PopView

@property (strong,nonatomic)NSString * price;
@property (weak, nonatomic) id <MyViewDelegate> delegate;
@property (strong,nonatomic)UITableView * table;        //
      //
@end
