//
//  BWWCertificateGuideViewController.m
//  BigWhiteWallet
//
//  Created by mac on 2018/6/8.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BWWCertificateGuideViewController.h"
#import "CertificationViewController.h"
@interface BWWCertificateGuideViewController ()
@property (strong,nonatomic)UIButton * regestBtn;        //
@end

@implementation BWWCertificateGuideViewController

//隐藏底部bottombar
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{

    self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed=YES;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    NSString *path=[[BWWSingleUser sharedSingleUser] sandBoxPath];
//    BWWUserInformation *user=[NSKeyedUnarchiver unarchiveObjectWithFile:path];
//
    

}
-(void)viewWillAppear:(BOOL)animated{
        [self didRegisted];
     
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)didRegisted{
    
    if (([BWWSingleUser sharedSingleUser].user.IDinfo_name==nil)||([BWWSingleUser sharedSingleUser].user.IDinfo_address==nil)||([BWWSingleUser sharedSingleUser].user.user_bankName==nil)) {
       
        self.title=@"认证向导";
        self.view.backgroundColor=[UIColor whiteColor];
        
        UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(100, 200, KScreenWidth-200, KScreenHeight/4)];
        image.image=[UIImage imageNamed:@"renzheng.png"];
        [self.view addSubview:image];
        
        self.regestBtn=[[UIButton alloc]initWithFrame:CGRectMake(10, KScreenHeight-80, KScreenWidth-20, 40)];
        self.regestBtn.layer.cornerRadius=5.0;
        self.regestBtn.layer.masksToBounds=YES;
        
        [self.regestBtn setTitle:@"开始认证" forState:UIControlStateNormal];
        [self.regestBtn setBackgroundColor:kBackGroundColor];
        [self.regestBtn addTarget:self action:@selector(registStart) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.regestBtn];
        
    }
    

    
    
    
}




-(void)registStart{
     CertificationViewController *certificatVC=[[CertificationViewController alloc]init];
//    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:certificatVC animated:YES];

    
}
@end
