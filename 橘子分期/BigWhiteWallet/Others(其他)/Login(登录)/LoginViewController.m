//
//  LoginViewController.m
//  BigWhiteWallet
//
//  Created by mac on 2018/6/12.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginVIew.h"
#import "RegisterView.h"
#import "BottomScrollView.h"
#import "BWWMyViewController.h"
#import "BaseNavigationController.h"
#import "BWWStoreViewController.h"

#import <MBProgressHUD.h>
#import <Masonry.h>
@interface LoginViewController ()<UIScrollViewDelegate,UIGestureRecognizerDelegate>
//@property (weak, nonatomic) IBOutlet UIScrollView *bottomScrollView;
@property (strong,nonatomic)BottomScrollView * bottomScrollView;        //
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@property (strong,nonatomic)NSString * loginText;        //
@property (strong,nonatomic)LoginVIew *myView2;        //
@property (strong,nonatomic)RegisterView * myView1;        //
@property (strong,nonatomic)UIPageControl * pageControl;        //
@property (assign,nonatomic) BOOL isRegist;
@end

@implementation LoginViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}  
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
  
    
    self.bottomScrollView.showsHorizontalScrollIndicator=NO;
    CGRect frame1=CGRectMake(0, 0, self.bottomScrollView.frame.size.width, self.bottomScrollView.frame.size.height);
     CGRect frame2=CGRectMake( self.bottomScrollView.frame.size.width, 0,  self.bottomScrollView.frame.size.width, self.bottomScrollView.frame.size.height);
    self.myView1.frame = frame1;
    self.myView2.frame=frame2;

    self.bottomScrollView.contentSize=CGSizeMake(KScreenWidth*2, KScreenHeight-(self.segmentControl.frame.origin.y+self.segmentControl.frame.size.height));
     self.bottomScrollView.frame=CGRectMake(0, 200, KScreenWidth, KScreenHeight-(self.segmentControl.frame.origin.y+self.segmentControl.frame.size.height));

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"登录";
    self.bottomScrollView=[[BottomScrollView alloc]init];
    self.bottomScrollView.frame=CGRectMake(0, self.segmentControl.bounds.size.height, KScreenWidth, KScreenHeight-(self.segmentControl.frame.origin.y+self.segmentControl.frame.size.height));
    [self.view addSubview:self.bottomScrollView];
    
    RegisterView *view1=[[RegisterView alloc]init];
    [self.bottomScrollView addSubview:view1];
    self.myView1=view1;
    
    LoginVIew *view2=[[LoginVIew alloc]init];
    self.myView2 =view2;
    [self.bottomScrollView addSubview:self.myView2];
    
    
    self.bottomScrollView.delegate=self;
    self.bottomScrollView.pagingEnabled=YES;
    [self.pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    
    self.pageControl.numberOfPages=2;
    
    [self.segmentControl addTarget:self action:@selector(changeSegmengt:) forControlEvents:UIControlEventValueChanged];
    self.bottomScrollView.delaysContentTouches = NO;
    self.bottomScrollView.canCancelContentTouches=YES;
//    [self.bottomScrollView touchesShouldCancelInContentView:self.bottomScrollView]=YES;
    [self loginRegist];
   
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
   
}
-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    
}
//segmentcontrol的点击方法

-(void)changeSegmengt:(UISegmentedControl *)sender{
    
      [self.bottomScrollView setContentOffset:CGPointMake(sender.selectedSegmentIndex*self.bottomScrollView.bounds.size.width, 0) animated:YES];
   
}
#pragma mark - 登录注册
-(void)loginRegist{
    [self.myView1.registBtn addTarget:self action:@selector(registBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.myView2.loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.myView1.backBtn1 addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.myView2.backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
}
-(void)backBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)registBtnClick{
   
    if (self.myView1.registTextFiled.text.length<11) {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.label.numberOfLines=0;
        hud.label.text=@"您输入的手机号有误！";
        [hud hideAnimated:YES afterDelay:1.0];
    }else{
        
        NSString *path=[[BWWSingleUser sharedSingleUser] sandBoxPath];
        BWWUserInformation *user=[[BWWUserInformation alloc]init];
        
        user=[NSKeyedUnarchiver unarchiveObjectWithFile:path];
        if (user==nil) {
            user = [BWWUserInformation new];
            
        }
        user.user_account=self.myView1.registTextFiled.text;
        user.user_password=self.myView1.registTextFiledPassword.text;
        [BWWSingleUser sharedSingleUser].user=user;
        [NSKeyedArchiver archiveRootObject:user toFile:path];
        
        [self.myView1.registTextFiled resignFirstResponder];
        [self.myView1.registTextFiledPassword resignFirstResponder];
        
        [self.bottomScrollView setContentOffset:CGPointMake(self.bottomScrollView.frame.size.width, 0) animated:YES];
        self.pageControl.currentPage=1;
        self.segmentControl.selectedSegmentIndex=1;
        
    }
    
    
}
-(void)loginBtnClick{
    
    if (([BWWSingleUser sharedSingleUser].user.user_account==nil)||([BWWSingleUser sharedSingleUser].user.user_password==nil)) {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.label.numberOfLines=0;
        hud.label.text=@"您还没有注册，请先注册！";
        [hud hideAnimated:YES afterDelay:0.1];
        [self.bottomScrollView setContentOffset:CGPointMake(-self.bottomScrollView.frame.size.width, 0) animated:YES];
        self.pageControl.currentPage=0;
        self.segmentControl.selectedSegmentIndex=0;
       
        
    }else{
        
        
        if ([self.myView2.loginTextFiled.text isEqualToString:[BWWSingleUser sharedSingleUser].user.user_account]&&[self.myView2.loginTextFiledPassword.text isEqualToString:[BWWSingleUser sharedSingleUser].user.user_password]) {
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.label.numberOfLines=0;
            hud.label.text=@"登录成功";
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 [self.navigationController popViewControllerAnimated:YES];
                
            });
           
        }else{
            
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.label.numberOfLines=0;
            hud.label.text=@"您输入的账号或密码错误!请重新输入";
            [hud hideAnimated:YES afterDelay:1.0];
        }
        
    }

    
}
//pageControl的方法

-(void)changePage:(id)sender{
    
    CGRect rect=self.bottomScrollView.frame;
    rect.origin.x=self.pageControl.currentPage*self.bottomScrollView.frame.size.width;
    rect.origin.y=0;
    
    [self.bottomScrollView scrollRectToVisible:rect animated:YES];
}

#pragma mark-----UIScrollViewDelegate---------
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    CGFloat pagWith = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pagWith/2)/pagWith)+1;
    self.pageControl.currentPage=page;
    self.segmentControl.selectedSegmentIndex=page;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
