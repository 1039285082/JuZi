//
//  PayBankViewController.m
//  BigWhiteWallet
//
//  Created by mac on 2018/6/14.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "PayBankViewController.h"
#import "PayBankTableViewCell.h"
#import "AddPayBankViewController.h"
@interface PayBankViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic)UITableView * tableView;        //
      //
@end

@implementation PayBankViewController
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
    self.title=@"银行卡";
    
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) style:UITableViewStyleGrouped];
    UINib *nib=[UINib nibWithNibName:@"PayBankTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"PayBankTableViewCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
   
//    _tableView.sectionHeaderHeight = 1;
//    _tableView.sectionFooterHeight = 1;
    _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0.0f,0.0f,_tableView.bounds.size.width,0.01f)];
    [self.view addSubview:self.tableView];
 
    
}
-(void)viewWillAppear:(BOOL)animated{
    
      [self.tableView reloadData];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        
        return 125;
    }else{
        return UITableViewAutomaticDimension;
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        PayBankTableViewCell *cell=[self.tableView dequeueReusableCellWithIdentifier:@"PayBankTableViewCell"];

        NSString *bankName=[BWWSingleUser sharedSingleUser].user.user_bankName;
        NSString *number=[BWWSingleUser sharedSingleUser].user.user_bankNumber;
        NSString *bankNumber=[NSString stringWithFormat:@"**** **** **** %@",[number substringWithRange:NSMakeRange(number.length-4, 4)]];
        NSRange range=[bankName rangeOfString:@"银行"];
        range.location=range.location-2;
        range.length=range.length+2;
        bankName = [bankName substringWithRange:range];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
//        cell.backImcageView.image=[UIImage imageNamed:@"gs_yh"];
        
        cell.iconImage.backgroundColor=[UIColor whiteColor];
        cell.iconImage.layer.cornerRadius=20;
        
        cell.iconImage.layer.masksToBounds=YES;
        cell.firstIcon.backgroundColor=[UIColor whiteColor];
        
        cell.firstIcon.layer.cornerRadius=25;
        cell.firstIcon.layer.masksToBounds=YES;
        
        cell.bankNameLabel.text=bankName;
        cell.bankNumberLabel.text=bankNumber;
        
        if ([bankName isEqualToString:@"招商银行"]) {
            cell.backImageView.image=[UIImage imageNamed:@"zs_yh"];
            cell.iconImage.image=[UIImage imageNamed:@"zs_icon.png"];
            
        }else if([bankName isEqualToString:@"农业银行"]){
            cell.backImageView.image=[UIImage imageNamed:@"ny_yh"];
            cell.iconImage.image=[UIImage imageNamed:@"ny_icon.png"];
            
        }else if([bankName isEqualToString:@"工商银行"]){
            cell.backImageView.image=[UIImage imageNamed:@"gs_yh"];
            cell.iconImage.image=[UIImage imageNamed:@"gs_icon.png"];
            
        }
        
        return cell;
    }else{
        UITableViewCell * cell = [[UITableViewCell alloc]init];
        cell.textLabel.text=@"修改银行卡";
        cell.imageView.image=[UIImage imageNamed:@"bank_card"];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
         cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==1) {
        UIBarButtonItem *backItem=[[UIBarButtonItem alloc]init];
        backItem.title=@"返回";
        self.navigationItem.backBarButtonItem=backItem;
        AddPayBankViewController * vc=[[AddPayBankViewController alloc]init];
        vc.bankNumber=nil;
        [self.navigationController pushViewController:vc animated:YES];
    }
}


@end
