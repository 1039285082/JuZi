//
//  MyView.m
//  弹出动画_demo2
//
//  Created by liman on 11/26/15.
//  Copyright © 2015 apple. All rights reserved.
//
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

#import "MyView.h"
#import "UIViewExt.h"
#import "MyViewTableViewHeadView.h"
#import "MyViewSubView.h"
@interface MyView()

@end
@implementation MyView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 设置参数 (否则用默认值)
//        self.popType = PopTypeScale;
//        self.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
//        self.animateDuration = 0.5;
//        self.backgroundColor = [UIColor purpleColor];
        
        // 设置参数 (否则用默认值)
//        self.popType = PopTypeMove;
//        self.moveAppearCenterY = [UIApplication sharedApplication].keyWindow.centerY;
//        self.moveAppearDirection = MoveAppearDirectionFromBottom;
//        self.moveDisappearDirection = MoveDisappearDirectionToBottom;
//        self.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
//        self.animateDuration = 0.5;
//        self.backgroundColor = [UIColor purpleColor];
        
        // 设置参数 (否则用默认值)
        self.popType = PopTypeMove;
        self.moveAppearCenterY = SCREEN_HEIGHT - self.height/2;
        self.moveAppearDirection = MoveAppearDirectionFromBottom;
        self.moveDisappearDirection = MoveDisappearDirectionToBottom;
        self.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        self.animateDuration = 0.5;
        self.radius = 0;
        self.backgroundColor = [UIColor purpleColor];
        
        
        
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selfTapped)]];
        
        NSArray *nibView=[[NSBundle mainBundle]loadNibNamed:@"MyViewSubView" owner:self options:nil];
        UIView *detailView=[nibView objectAtIndex:0];
        detailView.frame=self.frame;
        [self addSubview:detailView];
        
        UINib *nib=[UINib nibWithNibName:@"MyViewSubView" bundle:nil];
        MyViewSubView *view=[nib instantiateWithOwner:nil options:nil][0];
        [view setFrame:self.bounds];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(20, 60, KScreenWidth/2-30, 80);
        button.backgroundColor = kBackGroundColor;
        //设置button正常状态下的图片
        [button setImage:[UIImage imageNamed:@"0yuanpeifu.png"] forState:UIControlStateNormal];
        //button图片的偏移量，距上左下右分别(10, 10, 10, 60)像素点
        button.imageEdgeInsets = UIEdgeInsetsMake(10, 10,10, 60);
        [button setTitle:@"0元赔付" forState:UIControlStateNormal];
        //button标题的偏移量，这个偏移量是相对于图片的
        button.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        //设置button正常状态下的标题颜色
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.layer.cornerRadius=10.0;
        button.layer.masksToBounds=YES;
        
        
        UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        button1.frame = CGRectMake(KScreenWidth/2+10, 60, KScreenWidth/2-30, 80);
        button1.backgroundColor = kBackGroundColor;
        [button1 setImage:[UIImage imageNamed:@"0yuanweixiu.png"] forState:UIControlStateNormal];
        button1.imageEdgeInsets = UIEdgeInsetsMake(10, 10,10, 60);
        [button1 setTitle:@"0元维修" forState:UIControlStateNormal];
        button1.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button1.titleLabel.font = [UIFont systemFontOfSize:14];
        button1.layer.cornerRadius=10.0;
        button1.layer.masksToBounds=YES;
        
        
        UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        button2.frame = CGRectMake(20, 140, KScreenWidth/2-30, 80);
        button2.backgroundColor = kBackGroundColor;
        [button2 setImage:[UIImage imageNamed:@"0yuanyajin.png"] forState:UIControlStateNormal];
        button2.imageEdgeInsets = UIEdgeInsetsMake(10, 10,10, 60);
        [button2 setTitle:@"0元押金" forState:UIControlStateNormal];
        button2.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button2.titleLabel.font = [UIFont systemFontOfSize:14];
        button2.layer.cornerRadius=10.0;
        button2.layer.masksToBounds=YES;
        
        UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
        button3.frame = CGRectMake(KScreenWidth/2+10, 60, KScreenWidth/2-30, 80);
        button3.backgroundColor = kBackGroundColor;
        [button3 setImage:[UIImage imageNamed:@"shunfengbaoyou.png"] forState:UIControlStateNormal];
        button3.imageEdgeInsets = UIEdgeInsetsMake(10, 10,10, 60);
        [button3 setTitle:@"极速邮寄" forState:UIControlStateNormal];
        button3.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        [button3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button3.titleLabel.font = [UIFont systemFontOfSize:14];
        button3.layer.cornerRadius=10.0;
        button3.layer.masksToBounds=YES;
        
        UIButton *button4 = [UIButton buttonWithType:UIButtonTypeCustom];
        button4.frame = CGRectMake(KScreenWidth/2+10, 60, KScreenWidth/2-30, 80);
        button4.backgroundColor = kBackGroundColor;
        [button4 setImage:[UIImage imageNamed:@"yinsibaohu.png"] forState:UIControlStateNormal];
        button4.imageEdgeInsets = UIEdgeInsetsMake(10, 10,10, 60);
        [button4 setTitle:@"隐私保护" forState:UIControlStateNormal];
        button4.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        [button4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button4.titleLabel.font = [UIFont systemFontOfSize:14];
        button4.layer.cornerRadius=10.0;
        button4.layer.masksToBounds=YES;
        
        UIButton *button5 = [UIButton buttonWithType:UIButtonTypeCustom];
        button5.frame = CGRectMake(KScreenWidth/2+10, 60, KScreenWidth/2-30, 80);
        button5.backgroundColor = kBackGroundColor;
        [button5 setImage:[UIImage imageNamed:@"zhengpin.png"] forState:UIControlStateNormal];
        button5.imageEdgeInsets = UIEdgeInsetsMake(10, 10,10, 60);
        [button5 setTitle:@"正品行货" forState:UIControlStateNormal];
        button5.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        [button5 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button5.titleLabel.font = [UIFont systemFontOfSize:14];
        button5.layer.cornerRadius=10.0;
        button5.layer.masksToBounds=YES;
        
        
        [view addSubview:button];
        [view addSubview:button1];
        [view addSubview:button2];
        [view addSubview:button3];
        [view addSubview:button4];
        [view addSubview:button5];
        [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(button);
            make.right.mas_equalTo(-20);
            make.width.mas_equalTo(button);
            make.height.mas_equalTo(button);
        }];
        [button2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(button.bottom+10);
            make.left.mas_equalTo(20);
            make.width.mas_equalTo(button);
            make.height.mas_equalTo(button);
        }];
        [button3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(button2);
            make.right.mas_equalTo(-20);
            make.width.mas_equalTo(button2);
            make.height.mas_equalTo(button2);
        }];
        [button4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(button2.bottom+20);
            make.left.mas_equalTo(20);
            make.width.mas_equalTo(button);
            make.height.mas_equalTo(button);
        }];
        [button5 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(button4);
            make.right.mas_equalTo(-20);
            make.width.mas_equalTo(button2);
            make.height.mas_equalTo(button2);
        }];
        
        [self addSubview:view];
     
    }
//    NSLog(@"%@",_price);
    return self;
}

#pragma mark - 重写父类
- (void)PopViewShadowTapped:(UITapGestureRecognizer *)tap
{
    if ([_delegate respondsToSelector:@selector(myView:didSelectedShadow:)]) {
        [_delegate myView:self didSelectedShadow:nil];
    }
}

#pragma mark - target action
- (void)selfTapped
{
    if ([_delegate respondsToSelector:@selector(myView:didSelectedSelf:)]) {
        [_delegate myView:self didSelectedSelf:nil];
    }
}

@end
