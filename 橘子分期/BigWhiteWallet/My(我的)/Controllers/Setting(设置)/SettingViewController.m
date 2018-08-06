//
//  SettingViewController.m
//  BigWhiteWallet
//
//  Created by mac on 2018/6/25.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "SettingViewController.h"
#import "CKAlertViewController.h"
#import "CYloginRegisterViewController.h"
@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic)UITableView * tableView;

@property (strong,nonatomic)UIButton * button;        //
@end

@implementation SettingViewController
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
    // Do any additional setup after loading the view from its nib.
    self.title=@"设置";
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    _button=[[UIButton alloc]initWithFrame:CGRectMake(20, 100, KScreenWidth-40, 40)];
    
    _button.layer.cornerRadius=5.0;
    _button.layer.masksToBounds=YES;
    
        [_button addTarget:self action:@selector(logoutBtnClick) forControlEvents:UIControlEventTouchUpInside];

    _button.backgroundColor=kBackGroundColor;
    [self.tableView addSubview:_button];
    [self.view addSubview:self.tableView];
    
}
-(void)viewWillAppear:(BOOL)animated{
    if ([BWWSingleUser sharedSingleUser].user.isLogin==NO){
        [_button setTitle:@"登录" forState:UIControlStateNormal];
    }else{
        [_button setTitle:@"注销登录" forState:UIControlStateNormal];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell=[[UITableViewCell alloc]init];
    cell.textLabel.text=@"清除缓存";
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.imageView.image=[UIImage imageNamed:@"dingdan_1.png"];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CKAlertViewController *alertVC = [CKAlertViewController alertControllerWithTitle:@"缓存已清除" message:nil ];
    
 
    
    CKAlertAction *sure = [CKAlertAction actionWithTitle:@"确定" handler:^(CKAlertAction *action) {
       
        
    }];
    
    
    [alertVC addAction:sure];
    
    [self presentViewController:alertVC animated:NO completion:nil];
    
}

-(void)logoutBtnClick{
    
    if ([BWWSingleUser sharedSingleUser].user.isLogin==NO) {
        CYloginRegisterViewController *loVC=[[CYloginRegisterViewController alloc]init];
        
        [self presentViewController:loVC animated:YES completion:nil];
        
    }else{
        
        NSString *path=[[BWWSingleUser sharedSingleUser] sandBoxPath];
        BWWUserInformation *user=[[BWWUserInformation alloc]init];
        
        user=[NSKeyedUnarchiver unarchiveObjectWithFile:path];
        if (user==nil) {
            user = [BWWUserInformation new];
            
        }
        user.isLogin=NO;
        
        user.IDinfo_name=nil;
        user.IDinfo_code=nil;
        user.user_bankName=nil;
        user.user_bankNumber=nil;
        user.IDinfo_address=nil;
        
        [BWWSingleUser sharedSingleUser].user=user;
        [NSKeyedArchiver archiveRootObject:user toFile:path];
        
        CKAlertViewController *alertVC = [CKAlertViewController alertControllerWithTitle:@"提示" message:@"您已成功注销,请重新登录!" ];
        
        
        CKAlertAction *sure = [CKAlertAction actionWithTitle:@"好" handler:^(CKAlertAction *action) {
            
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
        //        [alertVC addAction:sure];
        [alertVC addAction:sure];
        
        [self presentViewController:alertVC animated:NO completion:nil];
    }
    
    
}
@end
