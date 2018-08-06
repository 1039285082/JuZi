//
//  RealBuyViewController.m
//  BigWhiteWallet
//
//  Created by mac on 2018/6/21.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RealBuyViewController.h"

#import "RepayAddressTableViewCell.h"
#import "ReapayOrderTableViewCell.h"
#import "ReapayOrderNumberTableViewCell.h"
#import "RecevierAddressViewController.h"
#import "DWQOrderListViewController.h"
#import "RepaymentViewController.h"
#import "OrderModel.h"
#import "JKAlertDialog.h"

@interface RealBuyViewController ()<UITableViewDelegate,UITableViewDataSource,MBProgressHUDDelegate>
@property (strong,nonatomic)UITableView * tableView;        //
@property (strong,nonatomic)NSMutableArray  * dataArr;        //
@property (strong,nonatomic)OrderModel * orderModel;        //
@end

@implementation RealBuyViewController
//隐藏底部bottombar
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed=YES;
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
//    _orderModel
    _orderModel=[OrderModel new];
    _orderModel.order_name=[BWWSingleUser sharedSingleUser].user.order_name;
    _orderModel.order_phoneNmuber=[BWWSingleUser sharedSingleUser].user.order_phoneNmuber;
    _orderModel.order_address=[BWWSingleUser sharedSingleUser].user.order_address;
    _orderModel.order_detailAddress=[BWWSingleUser sharedSingleUser].user.order_detailAddress;
    _orderModel.order_image=_model.image;
    _orderModel.order_title=_model.title;
    _orderModel.order_price=_model.price_text;
    _orderModel.order_orderNumber=_orderNumber;
    _orderModel.order_orderTime=_orderTime;
    _orderModel.order_mouthNumber=_orderMouth;
    _orderModel.order_mouthPrice=_orderMouthPrice;
    
    [self.tableView reloadData];
  
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    NSLog(@"------------------------%@",[BWWSingleUser sharedSingleUser].user.arr);
  
    self.title=@"下单";
    
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.sectionHeaderHeight=10;
    [self.view addSubview:self.tableView];
    NSArray *type1=@[@"地址",@"编辑按钮"];
    NSArray *type2=@[@"物品",@"金额",@"租期"];
    NSArray *type3=@[@"优惠",@"商品金额"];
    
    _dataArr=[NSMutableArray new];
    [_dataArr addObject:type1];
    [_dataArr addObject:type2];
    [_dataArr addObject:type3];
    
    UINib *nib1=[UINib nibWithNibName:@"RepayAddressTableViewCell" bundle:nil];
    [self.tableView registerNib:nib1 forCellReuseIdentifier:@"RepayAddressTableViewCell"];
    UINib *nib2=[UINib nibWithNibName:@"ReapayOrderTableViewCell" bundle:nil];
    [self.tableView registerNib:nib2 forCellReuseIdentifier:@"ReapayOrderTableViewCell"];
    UINib *nib3=[UINib nibWithNibName:@"ReapayOrderNumberTableViewCell" bundle:nil];
    [self.tableView registerNib:nib3 forCellReuseIdentifier:@"ReapayOrderNumberTableViewCell"];
    
    _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0.0f,0.0f,_tableView.bounds.size.width,0.01f)];
    _tableView.sectionHeaderHeight = 5;
    _tableView.sectionFooterHeight = 5;
    
     [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
//    if (self._isOrder) {
//        [self.navigationItem setHidesBackButton:TRUE animated:NO];
//    }
//    self.navigationItem.hidesBackButton=YES;
    
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
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            if ([BWWSingleUser sharedSingleUser].user.order_address!=nil&&[BWWSingleUser sharedSingleUser].user.order_phoneNmuber!=nil&&[BWWSingleUser sharedSingleUser].user.order_name!=nil) {
                RepayAddressTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"RepayAddressTableViewCell"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.recevierName.text=[NSString stringWithFormat:@"%@ %@",[BWWSingleUser sharedSingleUser].user.order_name,[BWWSingleUser sharedSingleUser].user.order_phoneNmuber];
                cell.recevierAddress.text=[NSString stringWithFormat:@"%@ %@",[BWWSingleUser sharedSingleUser].user.order_address,[BWWSingleUser sharedSingleUser].user.order_detailAddress];
                
                return cell;
            }else{
                cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
                cell.textLabel.text=@"请添加收货地址";
                return cell;
                
            }
        }else{
            
            UIButton*button=[[UIButton alloc]init];
            
            
            if ([BWWSingleUser sharedSingleUser].user.order_address!=nil&&[BWWSingleUser sharedSingleUser].user.order_phoneNmuber!=nil&&[BWWSingleUser sharedSingleUser].user.order_name!=nil){
                [button setTitle:@"点击编辑" forState:UIControlStateNormal];
                
            }else{
                return  cell;
            }
           
            [button setTitleColor:RGBA(253, 109, 12, 1) forState:UIControlStateNormal];
            button.titleLabel.font=[UIFont boldSystemFontOfSize:14];
            
            [button.layer setMasksToBounds:YES];
            button.layer.borderWidth = 0.5;
            [button.layer setCornerRadius:1];
            [button.layer setBorderColor:[RGBA(253, 109, 12, 1)CGColor]];
            
            button.frame = CGRectMake(KScreenWidth-100, 10, 80, 30);
            [button addTarget:self action:@selector(didClickEditBtn) forControlEvents:UIControlEventTouchUpInside];
            
            [cell.contentView addSubview:button];
            return cell;
        }
        
        
    }else if(indexPath.section==1){
        if (indexPath.row==0) {
            ReapayOrderTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ReapayOrderTableViewCell"];
            [cell.orderImage sd_setImageWithURL:[NSURL URLWithString:_model.image]];
            cell.titleLabel.text=_model.title;
            cell.priceLabel.text=[NSString stringWithFormat:@"￥%.2f",[[self.model.price_text substringFromIndex:1] floatValue]];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            return cell;
        }else if(indexPath.row==1){
            cell.textLabel.text=@"月租金";
            cell.textLabel.font=[UIFont boldSystemFontOfSize:14];
            cell.textLabel.tintColor=[UIColor grayColor];
            
            
            UILabel *label=[[UILabel alloc]init];
            label.text=[NSString stringWithFormat:@"%@",self.orderMouthPrice];
//            label.text=[NSString stringWithFormat:@"￥%.2f",[[self.model.price_text substringFromIndex:1] floatValue]];
            label.textColor=RGBA(253, 109, 12, 1);
            label.font=[UIFont boldSystemFontOfSize:14];
            [label sizeToFit];
            label.backgroundColor=[UIColor clearColor];
            label.frame = CGRectMake(KScreenWidth-label.frame.size.width-10, 14, label.frame.size.width, label.frame.size.height);
            [cell.contentView addSubview:label];
            return cell;
            
        }else{
            cell.textLabel.text=@"租期";
            cell.textLabel.font=[UIFont boldSystemFontOfSize:14];
            cell.textLabel.tintColor=[UIColor grayColor];
            
            
            UILabel *label=[[UILabel alloc]init];
            label.text=[NSString stringWithFormat:@"%@个月",self.orderMouth];
            //            label.text=[NSString stringWithFormat:@"￥%.2f",[[self.model.price_text substringFromIndex:1] floatValue]];
            label.textColor=RGBA(253, 109, 12, 1);
            label.font=[UIFont boldSystemFontOfSize:14];
            [label sizeToFit];
            label.backgroundColor=[UIColor clearColor];
            label.frame = CGRectMake(KScreenWidth-label.frame.size.width-10, 14, label.frame.size.width, label.frame.size.height);
            [cell.contentView addSubview:label];
            return cell;
            
        }
       
        
    }else{
        if (indexPath.row==0) {
            ReapayOrderNumberTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ReapayOrderNumberTableViewCell"];
            cell.orderTimeLabel.text=self.orderTime;
            cell.orderNumberLabel.text=self.orderNumber;
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            UIButton*button=[[UIButton alloc]init];
            [button setTitle:@"点击下单" forState:UIControlStateNormal];
            [button setTitleColor:RGBA(253, 109, 12, 1) forState:UIControlStateNormal];
            button.titleLabel.font=[UIFont boldSystemFontOfSize:14];
           
            [button.layer setMasksToBounds:YES];
            button.layer.borderWidth = 0.5;
            [button.layer setCornerRadius:1];
            [button.layer setBorderColor:[RGBA(253, 109, 12, 1)CGColor]];
          
            button.frame = CGRectMake(KScreenWidth-100, 10, 80, 30);
            [button addTarget:self action:@selector(didPayEditBtn) forControlEvents:UIControlEventTouchUpInside];
            
//            UIButton*button1=[[UIButton alloc]init];
//            [button1 setTitle:@"取消订单" forState:UIControlStateNormal];
//            [button1 setTitleColor:RGBA(253, 109, 12, 1) forState:UIControlStateNormal];
//            button1.titleLabel.font=[UIFont boldSystemFontOfSize:14];
//
//            [button1.layer setMasksToBounds:YES];
//            button1.layer.borderWidth = 0.5;
//            [button1.layer setCornerRadius:1];
//            [button1.layer setBorderColor:[RGBA(253, 109, 12, 1)CGColor]];
//
//            button1.frame = CGRectMake(KScreenWidth-200, 10, 80, 30);
//            [button1 addTarget:self action:@selector(didCllickCancelBtn) forControlEvents:UIControlEventTouchUpInside];
            
//            [cell.contentView addSubview:button1];
            
            [cell.contentView addSubview:button];
        }
        
        
        
    }
    
    
    return  cell;
    
    
    
    
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        if ([BWWSingleUser sharedSingleUser].user.order_address!=nil&&[BWWSingleUser sharedSingleUser].user.order_phoneNmuber!=nil&&[BWWSingleUser sharedSingleUser].user.order_name!=nil) {
            
            
        }
        else{
            RecevierAddressViewController *vc=[[RecevierAddressViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
     
        
    }
    
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_dataArr[section] count];
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _dataArr.count;
}
//点击编辑按钮
-(void)didClickEditBtn{
    
    RecevierAddressViewController *vc=[[RecevierAddressViewController alloc]init];
    vc.name=[BWWSingleUser sharedSingleUser].user.order_name;
    vc.number=[BWWSingleUser sharedSingleUser].user.order_phoneNmuber;
    vc.address=[BWWSingleUser sharedSingleUser].user.order_address;
    vc.detailAddress=[BWWSingleUser sharedSingleUser].user.order_detailAddress;
   
    [self.navigationController pushViewController:vc animated:YES];
    
}
//点击付款按钮
-(void)didPayEditBtn{
    if ([BWWSingleUser sharedSingleUser].user.order_address!=nil&&[BWWSingleUser sharedSingleUser].user.order_detailAddress!=nil&&[BWWSingleUser sharedSingleUser].user.order_name!=nil&&[BWWSingleUser sharedSingleUser].user.order_phoneNmuber!=nil) {
//        UIView *alertView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,270, 150)];
        //    alertView .backgroundColor=kBackGroundColor;
        JKAlertDialog *alert = [[JKAlertDialog alloc]initWithTitle:@"确定下单?" message:@""];
//        alert.contentView=alertView;
//
//
//        NSString *bankName= [BWWSingleUser sharedSingleUser].user.user_bankName;
//        NSString *bankNumber=[BWWSingleUser sharedSingleUser].user.user_bankNumber;
//
//        NSString *number=[NSString stringWithFormat:@"**** **** **** %@",[bankNumber substringWithRange:NSMakeRange(bankNumber.length-4, 4)]];
//
//        UIImageView *backImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 20, 270, 130)];
//        UIImageView *IconImageView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 40, 40)];
//        UIImageView *backIconImageView=[[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 50, 50)];
//        backIconImageView.backgroundColor=[UIColor whiteColor];
//        backIconImageView.layer.cornerRadius=25;
//        backIconImageView.layer.masksToBounds=YES;
//
//        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(80, 30, 200, 21)];
//        label.text=bankName;
//        label.textColor=[UIColor whiteColor];
//        UILabel *numberLabel=[[UILabel alloc]initWithFrame:CGRectMake(80, 70, 200, 21)];
//        numberLabel.text=number;
//        numberLabel.textColor=[UIColor whiteColor];
//
//        if ([bankName isEqualToString:@"招商银行"]) {
//            backImageView.image=[UIImage imageNamed:@"zs_yh"];
//            IconImageView.image=[UIImage imageNamed:@"zs_icon.png"];
//
//        }else if([bankName isEqualToString:@"农业银行"]||[bankName isEqualToString:@"中国农业银行"]){
//            backImageView.image=[UIImage imageNamed:@"ny_yh"];
//            IconImageView.image=[UIImage imageNamed:@"ny_icon.png"];
//
//        }else if([bankName isEqualToString:@"工商银行"]||[bankName isEqualToString:@"中国工商银行"]){
//            backImageView.image=[UIImage imageNamed:@"gs_yh"];
//            IconImageView.image=[UIImage imageNamed:@"gs_icon.png"];
//
//        }
//
//        [backImageView addSubview:backIconImageView];
//        [backImageView addSubview:IconImageView];
//        [backImageView addSubview:label];
//        [backImageView addSubview:numberLabel];
//
//        [alertView addSubview:backImageView];
        
        [alert addButton:Button_OTHER withTitle:@"确定" handler:^(JKAlertDialogItem *item) {
            [self orderGuiDang];
            
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.label.text=@"您的订单已下单，请在5个工作日内等待工作人员与您联系";
            hud.label.numberOfLines=0;
            [hud hideAnimated:YES afterDelay:3.0];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (self._isOrder==YES) {
                    NSString *path1=[[BWWSingleUser sharedSingleUser] sandBoxNotArrPath];
                    NSMutableArray *arr=[NSKeyedUnarchiver unarchiveObjectWithFile:path1];

                    [arr removeObjectAtIndex:_index];
                    [NSKeyedArchiver archiveRootObject:arr toFile:path1];
                }
                RepaymentViewController *vc=[[RepaymentViewController alloc]init];
                vc.model=[OrderModel new];
                vc.model=_orderModel;
                
                [self.navigationController pushViewController:vc animated:YES];
                
                
            });
            
            
            
        }];;
        [alert addButton:Button_OTHER withTitle:@"以后再说" handler:^(JKAlertDialogItem *item) {
            if (self._isOrder==NO) {
                [self notOrderGuiDang];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
//                [self.navigationController popToRootViewControllerAnimated:YES];
             
            }
            
        }];
        [alert show];
        
    }else{
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.label.text=@"您还没有添加收货地址";
        hud.label.numberOfLines=0;
        [hud hideAnimated:YES afterDelay:1.0];
        
    }
    
}

//确定按钮归档
-(void)orderGuiDang{
    
    NSString *path1=[[BWWSingleUser sharedSingleUser] sandBoxArrPath];
    
    NSMutableArray *arr=[NSMutableArray new];
    arr=[NSKeyedUnarchiver unarchiveObjectWithFile:path1];
    if (arr==nil) {
        arr=[NSMutableArray new];
    }
    OrderModel *orderModel=[OrderModel new];
    
    orderModel.order_name=[BWWSingleUser sharedSingleUser].user.order_name;
    orderModel.order_phoneNmuber=[BWWSingleUser sharedSingleUser].user.order_phoneNmuber;
    orderModel.order_address=[BWWSingleUser sharedSingleUser].user.order_address;
    orderModel.order_detailAddress=[BWWSingleUser sharedSingleUser].user.order_detailAddress;
    orderModel.order_image=_model.image;
    orderModel.order_title=_model.title;
    orderModel.order_price=_model.price_text;
    orderModel.order_orderNumber=_orderNumber;
    orderModel.order_orderTime=_orderTime;
    orderModel.order_mouthNumber=_orderMouth;
    orderModel.order_mouthPrice=_orderMouthPrice;
    
    [arr addObject:orderModel];
    
    [NSKeyedArchiver archiveRootObject:arr toFile:path1];

        
        
    
}
//订单未付款归档
-(void)notOrderGuiDang{
    
  
        
        NSString *path1=[[BWWSingleUser sharedSingleUser] sandBoxNotArrPath];
        
        NSMutableArray *arr=[NSMutableArray new];
        arr=[NSKeyedUnarchiver unarchiveObjectWithFile:path1];
        if (arr==nil) {
            arr=[NSMutableArray new];
        }

        [arr addObject:_orderModel];
        
        [NSKeyedArchiver archiveRootObject:arr toFile:path1];
    
    
    
}
-(void)didCllickCancelBtn{
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
