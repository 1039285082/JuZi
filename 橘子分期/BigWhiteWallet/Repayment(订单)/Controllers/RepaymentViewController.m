//
//  RepaymentViewController.m
//  BigWhiteWallet
//
//  Created by mac on 2018/6/21.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RepaymentViewController.h"




#import "RepayAddressTableViewCell.h"
#import "ReapayOrderTableViewCell.h"
#import "ReapayOrderNumberTableViewCell.h"
#import "RepayOrderMouthTableViewCell.h"
#import "PayBankTableViewCell.h"
@interface RepaymentViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic)UITableView * tableView;        //
@property (strong,nonatomic)NSMutableArray  * dataArr;        //


@end

@implementation RepaymentViewController

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
    // Do any additional setup after loading the view.
    
 
        
    self.title=@"订单";
    self.view.backgroundColor=[UIColor whiteColor];
    if ([BWWSingleUser sharedSingleUser].user.order_name==nil) {
        UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(40, 100, 200, 30)];
        lable.text=@"你还没有订单";
        [self.view addSubview:lable];
    }else{
 
    }
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.sectionHeaderHeight=10;
    [self.view addSubview:self.tableView];
    NSArray *type1=@[@"地址"];
    NSArray *type2=@[@"物品"];
    NSArray *type3=@[@"优惠",@"商品金额"];
//    NSArray *type4=@[@"银行卡",@"银行卡详情"];
    
    _dataArr=[NSMutableArray new];
    [_dataArr addObject:type1];
    [_dataArr addObject:type2];
    [_dataArr addObject:type3];
//     [_dataArr addObject:type4];
    UINib *nib1=[UINib nibWithNibName:@"RepayAddressTableViewCell" bundle:nil];
    [self.tableView registerNib:nib1 forCellReuseIdentifier:@"RepayAddressTableViewCell"];
    UINib *nib2=[UINib nibWithNibName:@"ReapayOrderTableViewCell" bundle:nil];
     [self.tableView registerNib:nib2 forCellReuseIdentifier:@"ReapayOrderTableViewCell"];
    UINib *nib3=[UINib nibWithNibName:@"ReapayOrderNumberTableViewCell" bundle:nil];
    [self.tableView registerNib:nib3 forCellReuseIdentifier:@"ReapayOrderNumberTableViewCell"];
    UINib *nib4=[UINib nibWithNibName:@"RepayOrderMouthTableViewCell" bundle:nil];
    [self.tableView registerNib:nib4 forCellReuseIdentifier:@"RepayOrderMouthTableViewCell"];
    
    UINib *nib5=[UINib nibWithNibName:@"PayBankTableViewCell" bundle:nil];
    [self.tableView registerNib:nib5 forCellReuseIdentifier:@"PayBankTableViewCell"];
    
    _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0.0f,0.0f,_tableView.bounds.size.width,0.01f)];
    _tableView.sectionHeaderHeight = 0.1;
    _tableView.sectionFooterHeight = 0.1;
    
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(20, KScreenHeight-120, KScreenWidth-40, 40)];
    
    [button setBackgroundColor:kBackGroundColor];
    [button setTitle:@"确认" forState:UIControlStateNormal];
    button.layer.cornerRadius=5;
    button.layer.masksToBounds=YES;
    [button addTarget:self action:@selector(didClickConfirmBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [self.tableView addSubview:button];
    
//    RepayAddressTableViewCell.h
    self.navigationItem.hidesBackButton=YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewAutomaticDimension;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    UITableViewCell *cell=[UITableViewCell new];
    if (indexPath.section==0) {
        RepayAddressTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"RepayAddressTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
        cell.recevierName.text=[NSString stringWithFormat:@"%@ %@",_model.order_name,_model.order_phoneNmuber];
        cell.recevierAddress.text=[NSString stringWithFormat:@"%@ %@",_model.order_address,_model.order_detailAddress];;
        return cell;
    }else if(indexPath.section==1){
        ReapayOrderTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ReapayOrderTableViewCell"];
        [cell.orderImage sd_setImageWithURL:[NSURL URLWithString:_model.order_image]];
        cell.titleLabel.text=_model.order_title;
        cell.priceLabel.text=_model.order_price;
        
        return cell;
        
    }else if (indexPath.section==2) {
        if (indexPath.row==0) {
            RepayOrderMouthTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"RepayOrderMouthTableViewCell"];
          
            cell.mouthPriceLabel.text=_model.order_mouthPrice;
            cell.mouthNumberLabel.text=[NSString stringWithFormat:@"%@个月",_model.order_mouthNumber];
            cell.orderStatusLabel.text=@"已下单";
            cell.orderStatusLabel.textColor=kBackGroundColor;
            [cell.orderStatusLabel setFont:[UIFont systemFontOfSize:14]];
            return cell;
            
            
           
        }else{
            ReapayOrderNumberTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ReapayOrderNumberTableViewCell"];
            cell.orderTimeLabel.text=_model.order_orderTime;
            cell.orderNumberLabel.text=_model.order_orderNumber;
            
            return cell;
        }
        
        
    }else if (indexPath.section==3){
//        if (indexPath.row==0) {
//            cell.textLabel.text=@"付款银行卡";
//        }else{
//              PayBankTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"PayBankTableViewCell"];
//            NSString *bankName=[BWWSingleUser sharedSingleUser].user.user_bankName;
//            NSString *number=[BWWSingleUser sharedSingleUser].user.user_bankNumber;
//            NSString *bankNumber=[NSString stringWithFormat:@"**** **** **** %@",[number substringWithRange:NSMakeRange(number.length-4, 4)]];
//            NSRange range=[bankName rangeOfString:@"银行"];
//            range.location=range.location-2;
//            range.length=range.length+2;
//            bankName = [bankName substringWithRange:range];
//            cell.selectionStyle=UITableViewCellSelectionStyleNone;
//
//            //        cell.backImcageView.image=[UIImage imageNamed:@"gs_yh"];
//
//            cell.iconImage.backgroundColor=[UIColor whiteColor];
//            cell.iconImage.layer.cornerRadius=20;
//
//            cell.iconImage.layer.masksToBounds=YES;
//            cell.firstIcon.backgroundColor=[UIColor whiteColor];
//
//            cell.firstIcon.layer.cornerRadius=25;
//            cell.firstIcon.layer.masksToBounds=YES;
//
//            cell.bankNameLabel.text=bankName;
//            cell.bankNumberLabel.text=bankNumber;
//
//            if ([bankName isEqualToString:@"招商银行"]) {
//                cell.backImageView.image=[UIImage imageNamed:@"zs_yh"];
//                cell.iconImage.image=[UIImage imageNamed:@"zs_icon.png"];
//
//            }else if([bankName isEqualToString:@"农业银行"]){
//                cell.backImageView.image=[UIImage imageNamed:@"ny_yh"];
//                cell.iconImage.image=[UIImage imageNamed:@"ny_icon.png"];
//
//            }else if([bankName isEqualToString:@"工商银行"]){
//                cell.backImageView.image=[UIImage imageNamed:@"gs_yh"];
//                cell.iconImage.image=[UIImage imageNamed:@"gs_icon.png"];
//
//            }
//
//            return cell;
//        }



    }
    
    
    return  cell;
      
   
            

    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 
        return [_dataArr[section] count];
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
   
    return _dataArr.count;
}

//确定按钮
-(void)didClickConfirmBtn{
    
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}


@end
