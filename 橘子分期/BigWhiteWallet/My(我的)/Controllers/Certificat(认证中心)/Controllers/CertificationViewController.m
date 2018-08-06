//
//  CertificationViewController.m
//  BigWhiteWallet
//
//  Created by mac on 2018/6/8.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "CertificationViewController.h"
#import "WYIDScanViewController.h"

#import "BWWBankViewController.h"
#import "BWWIDFrontViewController.h"
#import "BWWIDDownViewController.h"

@interface CertificationViewController ()

@property (strong,nonatomic)UIButton * bt1;        //
@property (strong,nonatomic)UIButton * bt2;
@property (strong,nonatomic)UIButton * bt3;
@end

@implementation CertificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"扫描信息";
    self.view.backgroundColor = [UIColor whiteColor];
  
   
    
    
//    [self Certificat];
}
-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"%@,%@",[BWWSingleUser sharedSingleUser].user.IDinfo_name,[BWWSingleUser sharedSingleUser].user.IDinfo_address);
    
    CGFloat Width = [UIScreen mainScreen].bounds.size.width;
    
    self.bt1 = [[UIButton alloc] initWithFrame:CGRectMake((Width - 250)/2, 160, 250, 40)];
    [self.bt1 setBackgroundColor:kBackGroundColor];
    [self.bt1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.bt1 setTitle:@"身份证正面" forState:UIControlStateNormal];
    [self.bt1 addTarget:self action:@selector(pushFront:) forControlEvents:UIControlEventTouchUpInside];
    self.bt1.layer.cornerRadius=5.0;
    self.bt1.layer.masksToBounds=YES;
    if ([BWWSingleUser sharedSingleUser].user.IDinfo_name!=nil) {
        [self.bt1 setTitle:@"已认证" forState:UIControlStateNormal];
       self.bt1.layer.cornerRadius=5.0;
        self.bt1.layer.masksToBounds=YES;
        self.bt1.userInteractionEnabled=NO;
    }
    
    
    [self.view addSubview:self.bt1];
    
    self.bt2= [[UIButton alloc] initWithFrame:CGRectMake((Width - 250)/2, 240, 250, 40)];
    
    
    [self.bt2 setBackgroundColor:kBackGroundColor];
    [self.bt2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.bt2 setTitle:@"身份证反面" forState:UIControlStateNormal];
    [self.bt2 addTarget:self action:@selector(pushDown:) forControlEvents:UIControlEventTouchUpInside];
    self.bt2.layer.cornerRadius=5.0;
    self.bt2.layer.masksToBounds=YES;
    
    if ([BWWSingleUser sharedSingleUser].user.IDinfo_address!=nil) {
        [self.bt2 setTitle:@"已认证" forState:UIControlStateNormal];
        self.bt2.layer.cornerRadius=5.0;
        self.bt2.layer.masksToBounds=YES;
        self.bt2.userInteractionEnabled=NO;
    }
    
    [self.view addSubview: self.bt2];
    
    
    
    self.bt3 = [[UIButton alloc] initWithFrame:CGRectMake((Width - 250)/2, 320, 250, 40)];
    [self.bt3 setBackgroundColor:kBackGroundColor];
    [self.bt3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.bt3 setTitle:@"银行卡" forState:UIControlStateNormal];
    [self.bt3 addTarget:self action:@selector(pushBank:) forControlEvents:UIControlEventTouchUpInside];
    self.bt3.layer.cornerRadius=5.0;
    self.bt3.layer.masksToBounds=YES;
    if ([BWWSingleUser sharedSingleUser].user.user_bankName!=nil) {
        [self.bt3 setTitle:@"已认证" forState:UIControlStateNormal];
        self.bt3.layer.cornerRadius=5.0;
        self.bt3.layer.masksToBounds=YES;
        self.bt3.userInteractionEnabled=NO;
    }
    [self.view addSubview:self.bt3];
    
    
    UIButton *bt4 = [[UIButton alloc] initWithFrame:CGRectMake((Width - 250)/2, 400, 250, 40)];
    [bt4 setBackgroundColor:kBackGroundColor];
    [bt4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bt4 setTitle:@"完成认证" forState:UIControlStateNormal];
    bt4.layer.cornerRadius=5.0;
    bt4.layer.masksToBounds=YES;
    [bt4 addTarget:self action:@selector(Certificat) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:bt4];
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)Certificat{
    if (([BWWSingleUser sharedSingleUser].user.IDinfo_name!=nil)&&([BWWSingleUser sharedSingleUser].user.IDinfo_address!=nil)&&([BWWSingleUser sharedSingleUser].user.user_bankName!=nil)) {
         [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请完成认证" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
        [alert show];
       
    }
   
    
  
    
    
}



- (void)pushFront:(UIButton *)sender
{
    WYIDScanViewController *VC = [[WYIDScanViewController alloc] initWithCarInfo:CardIDFront];
    
    [VC scanDidFinishCarInfo:^(CardType status, WYScanResultModel *scanModel) {
        
        
        BWWIDFrontViewController *VC = [BWWIDFrontViewController new];
        VC.resultModel = scanModel;
        [self.navigationController pushViewController:VC animated:YES];
        
    }];
    
    [self.navigationController pushViewController:VC animated:YES];
    
}


- (void)pushDown:(UIButton *)sender
{
    WYIDScanViewController *VC = [[WYIDScanViewController alloc] initWithCarInfo:CardIDDown];
    
    [VC scanDidFinishCarInfo:^(CardType status, WYScanResultModel *scanModel) {
        
        BWWIDDownViewController *VC = [BWWIDDownViewController new];
        VC.resultModel = scanModel;
        [self.navigationController pushViewController:VC animated:YES];
        
    }];
    
    [self.navigationController pushViewController:VC animated:YES];
    
}


- (void)pushBank:(UIButton *)sender
{
    WYIDScanViewController *VC = [[WYIDScanViewController alloc] initWithCarInfo:CardIDBank];
    
    [VC scanDidFinishCarInfo:^(CardType status, WYScanResultModel *scanModel) {
        
        
        BWWBankViewController *VC = [BWWBankViewController new];
        VC.resultModel = scanModel;
        [self.navigationController pushViewController:VC animated:YES];
        
    }];
    
    [self.navigationController pushViewController:VC animated:YES];
    
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
