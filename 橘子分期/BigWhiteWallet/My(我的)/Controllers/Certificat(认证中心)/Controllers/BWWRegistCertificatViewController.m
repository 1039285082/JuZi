//
//  BWWRegistCertificatViewController.m
//  BigWhiteWallet
//
//  Created by mac on 2018/6/14.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BWWRegistCertificatViewController.h"

@interface BWWRegistCertificatViewController ()

@end

@implementation BWWRegistCertificatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"认证中心";
    self.view.backgroundColor=[UIColor redColor];
    UILabel *name=[[UILabel alloc]initWithFrame:CGRectMake(50, 100, 100, 40)];
    name.text=@"姓名:";
    name.textColor=[UIColor whiteColor];
    
    UILabel *nameText=[[UILabel alloc]initWithFrame:CGRectMake(100, 100, 100, 40)];
    nameText.text=[BWWSingleUser sharedSingleUser].user.IDinfo_name;
     nameText.textColor=[UIColor whiteColor];
    
    UILabel *ID=[[UILabel alloc]initWithFrame:CGRectMake(50, 150, 100, 40)];
    ID.text=@"身份证号码:";
    ID.textColor=[UIColor whiteColor];
    
    UILabel *IDInfo=[[UILabel alloc]initWithFrame:CGRectMake(150, 150, KScreenWidth-150, 40)];
    IDInfo.text=[BWWSingleUser sharedSingleUser].user.IDinfo_code;
    IDInfo.textColor=[UIColor whiteColor];
    
    UILabel *bank=[[UILabel alloc]initWithFrame:CGRectMake(50, 200, 100, 40)];
    bank.text=@"银行卡名称:";
    bank.textColor=[UIColor whiteColor];
    
    UILabel *bankName=[[UILabel alloc]initWithFrame:CGRectMake(150, 200, KScreenWidth-150, 40)];
    bankName.text=[BWWSingleUser sharedSingleUser].user.user_bankName;
    bankName.textColor=[UIColor whiteColor];
    
    UILabel *bankID=[[UILabel alloc]initWithFrame:CGRectMake(50, 250, 100, 40)];
    bankID.text=@"银行卡号:";
    bankID.textColor=[UIColor whiteColor];
    
    UILabel *bankIDNumber=[[UILabel alloc]initWithFrame:CGRectMake(150, 250, KScreenWidth-150, 40)];
   
    NSString *number= [BWWSingleUser sharedSingleUser].user.user_bankNumber;
    bankIDNumber.text=[NSString stringWithFormat:@"**** **** **** %@",[number substringWithRange:NSMakeRange(number.length-4, 4)]];
    bankIDNumber.textColor=[UIColor whiteColor];
    
    UIImageView *image=[[UIImageView alloc]initWithFrame:self.view.bounds];
    image.image=[UIImage imageNamed:@"bg.png"];
    [self.view addSubview:image];
    
    [self.view addSubview:nameText];
    [self.view addSubview:name];
    [self.view addSubview:bank];
    [self.view addSubview:bankName];
    [self.view addSubview:ID];
    [self.view addSubview:IDInfo];
    [self.view addSubview:bankID];
    [self.view addSubview:bankIDNumber];
    
  
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
