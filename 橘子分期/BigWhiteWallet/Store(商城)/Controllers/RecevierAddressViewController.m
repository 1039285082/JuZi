//
//  RecevierAddressViewController.m
//  BigWhiteWallet
//
//  Created by mac on 2018/6/21.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RecevierAddressViewController.h"
#import "SHPlacePickerView.h"
@interface RecevierAddressViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic)UITableView * tableView;        //
@property (strong,nonatomic)SHPlacePickerView * shplacePicker;        //



@end

@implementation RecevierAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"编辑地址";
    
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    self.tableView.backgroundColor=[UIColor whiteColor];

    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(40, KScreenHeight/2, KScreenWidth-80, 30)];
    
    [button setTitle:@"保存新地址" forState:UIControlStateNormal];
    button.layer.cornerRadius=5.0;
    button.layer.masksToBounds=YES;
    button.backgroundColor=[UIColor orangeColor];
    [button addTarget:self action:@selector(didClickResaveBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [self.tableView addSubview:button];
    [self.view addSubview:self.tableView];
     _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0.0f,0.0f,_tableView.bounds.size.width,0.01f)];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==3) {
        return 100;
    }
    return 44;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[UITableViewCell new];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if (indexPath.row==0) {
        cell.textLabel.text=@"收货人";
        self.textFiled1=[[UITextField alloc]initWithFrame:CGRectMake(100, 3, KScreenWidth-80, 40)];
         self.textFiled1.placeholder=@"请输入姓名";
        self.textFiled1.text=_name;
        if (_name!=nil) {
            [self.textFiled1 becomeFirstResponder];
        }

        [cell.contentView addSubview: self.textFiled1];
        
        return cell;
    }else if (indexPath.row==1){
        cell.textLabel.text=@"联系方式";
         self.textFiled2=[[UITextField alloc]initWithFrame:CGRectMake(100, 3, KScreenWidth-80, 40)];
         self.textFiled2.placeholder=@"请输入联系电话";
         self.textFiled2.text=_number;
        [cell.contentView addSubview: self.textFiled2];
        
        
        return cell;
    }else if (indexPath.row==2){
        cell.textLabel.text=@"所在区域";
        
       
        
         self.textFiled3=[[UITextField alloc]initWithFrame:CGRectMake(100, 3, KScreenWidth-80, 40)];
        self.textFiled3.placeholder=@"请选择";
        self.textFiled3.userInteractionEnabled=NO;
        self.textFiled3.text=_address;
      
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        [cell.contentView addSubview:self.textFiled3];
        return cell;
    }else{
        self.textFiled4=[[UITextField alloc]initWithFrame:CGRectMake(20, 0, KScreenWidth-40, 44)];
         self.textFiled4.text=_detailAddress;
        [cell.contentView addSubview:_textFiled4];
        
        return cell;
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==2) {
        [self.textFiled1 resignFirstResponder];
        [self.textFiled2 resignFirstResponder];
        [self.textFiled4 resignFirstResponder];
      
        __weak __typeof(self)weakSelf = self;
        self.shplacePicker = [[SHPlacePickerView alloc] initWithIsRecordLocation:YES SendPlaceArray:^(NSArray *placeArray) {
            
//            [weakSelf.selectButton setTitle:[NSString stringWithFormat:@"省:%@ 市:%@ 区:%@",placeArray[0],placeArray[1],placeArray[2]] forState:UIControlStateNormal];
            [weakSelf.textFiled3 setText:[NSString stringWithFormat:@"%@ %@ %@",placeArray[0],placeArray[1],placeArray[2]]];
      
        }];
        [self.view addSubview:self.shplacePicker];
        
      
    }
}
-(void)viewWillAppear:(BOOL)animated{
    
   
  
    
    
}

//点击保存新地址
-(void)didClickResaveBtn{
    NSString *path=[[BWWSingleUser sharedSingleUser] sandBoxPath];
    BWWUserInformation *user=[[BWWUserInformation alloc]init];
    
    user=[NSKeyedUnarchiver unarchiveObjectWithFile:path];
    if (user==nil) {
        user = [BWWUserInformation new];
        
    }
    user.order_name=self.textFiled1.text;
    user.order_phoneNmuber=self.textFiled2.text;
    user.order_address=self.textFiled3.text;
    user.order_detailAddress=self.textFiled4.text;
    [BWWSingleUser sharedSingleUser].user=user;
    [NSKeyedArchiver archiveRootObject:user toFile:path];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
