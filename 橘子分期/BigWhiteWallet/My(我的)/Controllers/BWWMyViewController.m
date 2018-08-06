//
//  BWWMyViewController.m
//  BigWhiteWallet
//
//  Created by mac on 2018/6/20.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BWWMyViewController.h"
#import "BWWMyTableViewHeadVIew.h"
#import <MBProgressHUD.h>
#import "BWWCertificateGuideViewController.h"
#import "BWWRegistCertificatViewController.h"
#import "HelpViewController.h"
#import "SettingViewController.h"
#import "AboutUsViewController.h"

#import "DWQOrderListViewController.h"
#import "CYloginRegisterViewController.h"
#import "LoginViewController.h"
#import "BWWMyTableViewCell.h"


@interface BWWMyViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic)UITableView * tableView;        //
@property (strong,nonatomic)NSMutableArray * textLabelArr;        //
@property (strong,nonatomic)NSMutableArray * imageArr;        //
@property (strong,nonatomic)MBProgressHUD * hud;        //
@property (strong,nonatomic)BWWMyTableViewHeadVIew * myHeadView;        //
@property (strong,nonatomic)UILabel * accountLabel;
@end

@implementation BWWMyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.navigationItem.title=@"我的";
    
    
    NSArray *type1=@[@"认证中心",@"订单记录"];
    NSArray *type3=@[@"设置"];
    NSArray *type4=@[@"关于我们"];
    
    _textLabelArr=[NSMutableArray new];
    [_textLabelArr addObject:type1];
//    [_textLabelArr addObject:type2];
    [_textLabelArr addObject:type3];
    [_textLabelArr addObject:type4];
    NSArray* image1=@[@"anquan",@"dingdan"];
//    NSArray* image2=@[@"yinghang",@"bangzhu"];
    NSArray* image3=@[@"shezhi"];
     NSArray* image4=@[@"chikaren"];
    _imageArr = [NSMutableArray new];
    [_imageArr addObject:image1];
//     [_imageArr addObject:image2];
     [_imageArr addObject:image3];
    [_imageArr addObject:image4];
//
//    UINib *nib=[UINib nibWithNibName:@"BWWMyTableViewCell" bundle:nil];
//    [self.tableView registerNib:nib forCellReuseIdentifier:@"BWWMyTableViewCell"];
    
    UINib *nib2=[UINib nibWithNibName:@"BWWMyTableViewHeadVIew" bundle:nil];
    BWWMyTableViewHeadVIew *headView=[nib2 instantiateWithOwner:nil options:nil][0];
    [headView setFrame:CGRectMake(0, 0, KScreenWidth, 100)];
    self.myHeadView=headView;
    
    
    self.tableView.tableHeaderView=self.myHeadView;
    self.tableView.tableHeaderView.userInteractionEnabled=YES;

    
 
    [self.view addSubview:self.tableView];
    
}

-(void)viewWillAppear:(BOOL)animated{

    if ([BWWSingleUser sharedSingleUser].user.isLogin==NO){
        [self.myHeadView.loginBtn setTitle:@"请登录!" forState:UIControlStateNormal];
        NSLog(@"%d",[BWWSingleUser sharedSingleUser].user.isLogin);
         [self.myHeadView.loginBtn addTarget:self action:@selector(loginButtonClick) forControlEvents:UIControlEventTouchUpInside];
        self.myHeadView.loginBtn.enabled=YES;
    }else{
        [self.myHeadView.loginBtn setTitle:[BWWSingleUser sharedSingleUser].user.user_account forState:UIControlStateNormal];
        self.myHeadView.loginBtn.enabled=NO;
    }
    
    [self.tableView reloadData];
}
//登录按钮点击事件
-(void)loginButtonClick{
        
//    CYloginRegisterViewController
    CYloginRegisterViewController *loVC=[[CYloginRegisterViewController alloc]init];
  
    [self presentViewController:loVC animated:YES completion:nil];
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _textLabelArr.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_textLabelArr[section] count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [[UITableViewCell alloc]init];
    cell.selectionStyle=NO;
    
    
    long index=indexPath.row;
    cell.textLabel.text=_textLabelArr[indexPath.section][index];
    cell.imageView.image=[UIImage imageNamed:_imageArr[indexPath.section][index]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([BWWSingleUser sharedSingleUser].user.isLogin==NO) {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.label.text=@"你还没有登录,请先登录";
        
        [hud hideAnimated:YES afterDelay:1.0];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            CYloginRegisterViewController *loVC=[[CYloginRegisterViewController alloc]init];
            
            [self presentViewController:loVC animated:YES completion:nil];
        });
        
        
    }else{
        [self regestCenter:indexPath];
    }
    
    
    
    
    
}
-(void)regestCenter:(NSIndexPath*)indexPath{
    long index=indexPath.row;
    BWWCertificateGuideViewController *ceVC=[[BWWCertificateGuideViewController alloc]init];
    if ([_textLabelArr[indexPath.section][index] isEqualToString:@"认证中心"]) {
        
        if (([BWWSingleUser sharedSingleUser].user.IDinfo_name==nil)||([BWWSingleUser sharedSingleUser].user.IDinfo_address==nil)||([BWWSingleUser sharedSingleUser].user.user_bankName==nil)){
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.label.numberOfLines=0;
            hud.label.text=@"您还没有认证，请先认证！";
            [hud hideAnimated:YES afterDelay:0.5];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.hidesBottomBarWhenPushed=YES;
                if(![self.navigationController.topViewController isKindOfClass:[ceVC class]]){
                    
                    [self.navigationController pushViewController:ceVC animated:YES];
                    self.hidesBottomBarWhenPushed=NO;
                    
                }
                
                
            });
            
        }else{
            BWWRegistCertificatViewController*rcVC=[[BWWRegistCertificatViewController alloc]init];
            self.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:rcVC animated:YES];
            self.hidesBottomBarWhenPushed=NO;
            
        }
        
    }if ([_textLabelArr[indexPath.section][index] isEqualToString:@"订单记录"]){
        DWQOrderListViewController *bVC=[[DWQOrderListViewController alloc]init];
       
        self.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:bVC animated:YES];
        
        self.hidesBottomBarWhenPushed=NO;
        
        
    }if ([_textLabelArr[indexPath.section][index] isEqualToString:@"设置"]){
        
        SettingViewController *vc=[[SettingViewController alloc]init];
        
        [self.navigationController pushViewController:vc animated:YES];
        

        NSLog(@"%@%@",[BWWSingleUser sharedSingleUser].user.user_account,[BWWSingleUser sharedSingleUser].user.user_password);
    }
//    if ([_textLabelArr[indexPath.section][index] isEqualToString:@"帮助中心"]){
//        HelpViewController *vc=[[HelpViewController alloc]init];
//        [self.navigationController pushViewController:vc animated:YES];
//    }
    if ([_textLabelArr[indexPath.section][index] isEqualToString:@"关于我们"]){
        AboutUsViewController *vc=[[AboutUsViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
    
}

@end
