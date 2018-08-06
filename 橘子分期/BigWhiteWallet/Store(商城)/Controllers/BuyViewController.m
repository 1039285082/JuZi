//
//  BuyViewController.m
//  BigWhiteWallet
//
//  Created by mac on 2018/6/12.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BuyViewController.h"
#import "StageNumberTableViewCell.h"
#import "StageDetailTableViewCell.h"
#import "MyViewDetailTableViewCell.h"
#import "BuyViewControllerImageTableViewCell.h"
#import "PayBankViewController.h"
#import "PopView.h"
#import "MyView.h"
#import "MyViewTableViewHeadView.h"
#import "RealBuyViewController.h"

@interface BuyViewController ()<UITableViewDelegate,UITableViewDataSource,MyViewDelegate>
@property (strong,nonatomic) MyView* myView;        //

@property (strong,nonatomic)UITableView * tableView;        //
@property (strong,nonatomic)NSMutableArray  * dataArr;        //       //

       //
@property (strong,nonatomic)NSString * mouthPrice;        //每月还款
@property (strong,nonatomic)NSString * mouthNumber;        //租借月数
@property (strong,nonatomic)MyViewTableViewHeadView *headView;        //

@property (assign,nonatomic)BOOL  isOpen;        //是否展开cell
@end

@implementation BuyViewController
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
    self.title=@"租赁详情";
    self.view.backgroundColor=[UIColor whiteColor];
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    self.tableView.sectionHeaderHeight=10;
     [self.view addSubview:self.tableView];
    NSArray *type1=@[@"订单照片"];
    NSArray *type3=@[@"买断须知",@"买断须知",@"买断须知",@"买断须知"];
    NSArray *type2=@[@"租期",@"分期详情"];
    
    _dataArr=[NSMutableArray new];
    [_dataArr addObject:type1];
    [_dataArr addObject:type3];
     [_dataArr addObject:type2];

    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(10, KScreenHeight-44-5, KScreenWidth-20, 44)];
    [button setTitle:@"开始下单" forState:UIControlStateNormal];
    button.layer.cornerRadius=5.0;
    button.layer.masksToBounds=YES;
    
    [button setBackgroundColor:RGBA(253, 109, 12, 1)];
    [button addTarget:self action:@selector(didClickPayBtn) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:button];
    [self.view bringSubviewToFront:button];
    
    UINib *nib=[UINib nibWithNibName:@"StageNumberTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"StageNumberTableViewCell"];
    UINib *nib2=[UINib nibWithNibName:@"StageDetailTableViewCell" bundle:nil];
    [self.tableView registerNib:nib2 forCellReuseIdentifier:@"StageDetailTableViewCell"];
      UINib *nib3=[UINib nibWithNibName:@"BuyViewControllerImageTableViewCell" bundle:nil];
    [self.tableView registerNib:nib3 forCellReuseIdentifier:@"BuyViewControllerImageTableViewCell"];
    
    _tableView.sectionHeaderHeight = 5;
    _tableView.sectionFooterHeight = 5;
    _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0.0f,0.0f,_tableView.bounds.size.width,0.01f)];
    [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    

   
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.mouthPrice=[NSString stringWithFormat:@"%.2f",[self.Price floatValue]/20];
    self.mouthNumber=@"6";
    self.isOpen=NO;
    [self.tableView reloadData];
    
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

    if (indexPath.section==1) {
            if (self.isOpen==NO) {
                return 0;
            }else{
                return 60;
            }
    }
    return UITableViewAutomaticDimension;
    
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell=[UITableViewCell new];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section==0) {
        BuyViewControllerImageTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"BuyViewControllerImageTableViewCell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        [cell.payImageView sd_setImageWithURL:[NSURL URLWithString:_model.image]];
        return cell;
        
    }else if (indexPath.section==1){
        cell.clipsToBounds=YES;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 2*cell.bounds.size.width);
        if (indexPath.row==0) {
            UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(20, 5, 100, 15)];
            label.text=@"买断须知";
            label.textColor=[UIColor grayColor];
            label.font=[UIFont boldSystemFontOfSize:14];
            
            UILabel *dtLabel=[[UILabel alloc]init];
//            dtLabel.lineBreakMode=NSLineBreakByWordWrapping;
            dtLabel.lineBreakMode = NSLineBreakByWordWrapping;;
            
//            CGSize expectSize = [dtLabel sizeThatFits:maximumLabelSize];
            dtLabel.numberOfLines=0;
            dtLabel.font=[UIFont systemFontOfSize:12];
            dtLabel.textColor=[UIColor lightGrayColor];
            NSString *str=@"买断款=商品价格*买断系数-已付租金,买断系数为112%,买断系数会随业务调整变动";
            dtLabel.text=str;
            dtLabel.frame=CGRectMake(20, 25, KScreenWidth-40, 30);
            
            [cell.contentView addSubview:dtLabel];
            [cell.contentView addSubview:label];
            
        } if (indexPath.row==1) {
             UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(20, 5, 100, 15)];
            label.text=@"全新正品";
            label.textColor=[UIColor grayColor];
            label.font=[UIFont boldSystemFontOfSize:14];
            
            UILabel *dtLabel=[[UILabel alloc]init];
            //            dtLabel.lineBreakMode=NSLineBreakByWordWrapping;
            dtLabel.lineBreakMode = NSLineBreakByWordWrapping;;
            
            //            CGSize expectSize = [dtLabel sizeThatFits:maximumLabelSize];
            dtLabel.numberOfLines=0;
            dtLabel.font=[UIFont systemFontOfSize:12];
            dtLabel.textColor=[UIColor lightGrayColor];
            NSString *str=@"全新正品,品质保障,让您租的放心,用的省心";
            dtLabel.text=str;
            dtLabel.frame=CGRectMake(20, 25, KScreenWidth-40, 30);
            
            [cell.contentView addSubview:dtLabel];
            [cell.contentView addSubview:label];
            
        }if (indexPath.row==2) {
             UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(20, 5, 100, 15)];
            label.text=@"售后无忧";
            label.textColor=[UIColor grayColor];
            label.font=[UIFont boldSystemFontOfSize:14];
            
            UILabel *dtLabel=[[UILabel alloc]init];
            //            dtLabel.lineBreakMode=NSLineBreakByWordWrapping;
            dtLabel.lineBreakMode = NSLineBreakByWordWrapping;;
            
            //            CGSize expectSize = [dtLabel sizeThatFits:maximumLabelSize];
            dtLabel.numberOfLines=0;
            dtLabel.font=[UIFont systemFontOfSize:12];
            dtLabel.textColor=[UIColor lightGrayColor];
            NSString *str=@"意外保障,免费维修,让租赁没有后顾之忧";
            dtLabel.text=str;
            dtLabel.frame=CGRectMake(20, 25, KScreenWidth-40, 30);
            
            [cell.contentView addSubview:dtLabel];
            [cell.contentView addSubview:label];
            
        }if (indexPath.row==3) {
             UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(20, 5, 100, 15)];;
            label.text=@"收货须知";
            label.textColor=[UIColor grayColor];
            label.font=[UIFont boldSystemFontOfSize:14];
            
            UILabel *dtLabel=[[UILabel alloc]init];
            //            dtLabel.lineBreakMode=NSLineBreakByWordWrapping;
            dtLabel.lineBreakMode = NSLineBreakByWordWrapping;;
            
            //            CGSize expectSize = [dtLabel sizeThatFits:maximumLabelSize];
            dtLabel.numberOfLines=0;
            dtLabel.font=[UIFont systemFontOfSize:12];
            dtLabel.textColor=[UIColor lightGrayColor];
            NSString *str=@"我们会用快递运送,收货时需提供一张本人身份证正反面复印件以确认收货,并交给快递小哥寄回橘子分期存档";
            dtLabel.text=str;
            dtLabel.frame=CGRectMake(20, 25, KScreenWidth-40, 30);
            
            [cell.contentView addSubview:dtLabel];
            [cell.contentView addSubview:label];
            
        }
        
        return cell;
        
    }else {
        if (indexPath.row==0) {
            StageNumberTableViewCell *cell=[self.tableView dequeueReusableCellWithIdentifier:@"StageNumberTableViewCell"];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.label.text=@"租期";
            
            [cell.button1 setTitle:@"6个月" forState:UIControlStateNormal];
            [cell.button1.layer setMasksToBounds:YES];
            [cell.button1.layer setCornerRadius:4.0];
            [cell.button1.layer setBorderWidth:1.0];
            if (cell.button2.layer.borderColor != [UIColor orangeColor].CGColor) {
                
                [cell.button1.layer setBorderColor:[UIColor orangeColor].CGColor];
                [cell.button1 setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            }
            
            
            
            
            [cell.button2 setTitle:@"12个月" forState:UIControlStateNormal];
            [cell.button2.layer setMasksToBounds:YES];
            [cell.button2.layer setCornerRadius:4.0];
            [cell.button2.layer setBorderWidth:1.0];
            
            
            
            [cell.button1 addTarget:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];
            [cell.button2 addTarget:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell.button1 setTag:10000+1];
            [cell.button2 setTag:10000+2];
            
            
            [cell.contentView addSubview:cell.label];
            [cell.contentView addSubview:cell.button1];
            [cell.contentView addSubview:cell.button2];
            
            return cell;
            
        }else{
            StageDetailTableViewCell *cell=[self.tableView dequeueReusableCellWithIdentifier:@"StageDetailTableViewCell"];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.topPriceLabel.text=[NSString stringWithFormat:@"￥%.2f",[self.mouthPrice floatValue]*[self.mouthNumber floatValue]];
            cell.mouthPriceLabel.text=[NSString stringWithFormat:@"￥%.2f",[self.mouthPrice floatValue]];
            cell.totalMouthLabel.text=[NSString stringWithFormat:@"租%@月",self.mouthNumber];
            //             cell.totalMouthLabel.backgroundColor = [UIColor redColor];
            cell.totalMouthLabel.layer.borderColor = [RGBA(253, 109, 12, 1)CGColor];
            cell.totalMouthLabel.layer.borderWidth = 0.5f;
            cell.totalMouthLabel.layer.masksToBounds = YES;
            
            [cell.detailBtn addTarget:self action:@selector(didClickDetailBtn) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }
        
        
    }
    
    return cell;
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row==1) {
            PayBankViewController *pVC=[[PayBankViewController alloc]init];
            [self.navigationController pushViewController:pVC animated:YES];
            
        }
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==1) {
        return 100;
    }
    return 0.1;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headView = [UIView new];
    if (section==1) {
        
        UIView *view=[[UIView alloc]init];
        view.frame=CGRectMake(0, 0, self.view.frame.size.width, 100);
        view.backgroundColor=[UIColor whiteColor];
        view.tag=100+section;
        UIImageView *image1=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"maiduan.png"]];
//        image1.frame=CGRectMake(40, 20, 44, 44);
        [view addSubview:image1];
        [image1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@20);
            make.width.equalTo(@44);
            make.height.equalTo(@44);
            make.left.equalTo(@40);
        }];
        
        UIImageView *image2=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shouhouwuyou.png"]];
        [view addSubview:image2];
        [image2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(image1.mas_top);
            make.width.equalTo(image1.mas_width);
            make.height.equalTo(image1.mas_height);
            make.left.equalTo(image1.mas_right).with.offset((self.view.frame.size.width-80-44*4)/3);
        }];
        
        UIImageView *image3=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shouhuoxuzhi.png"]];
        [view addSubview:image3];
        [image3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(image2.mas_top);
            make.width.equalTo(image2.mas_width);
            make.height.equalTo(image2.mas_height);
            make.left.equalTo(image2.mas_right).with.offset((self.view.frame.size.width-80-44*4)/3);
        }];
        
        UIImageView *image4=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"zhengpin1.png"]];
        [view addSubview:image4];
        [image4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(image3.mas_top);
            make.width.equalTo(image3.mas_width);
            make.height.equalTo(image3.mas_height);
            make.left.equalTo(image3.mas_right).with.offset((self.view.frame.size.width-80-44*4)/3);
        }];
        
        UILabel *label1=[[UILabel alloc]init];
        label1.text=@"买断须知";
        label1.font=[UIFont systemFontOfSize:10];
        label1.textColor=RGBA(117, 117, 117, 1);
        [view addSubview:label1];
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(image1.mas_bottom).offset(5);
            make.left.equalTo(@40);
            make.width.equalTo(image1.mas_width);
            make.height.equalTo(@21);
        }];
        
        UILabel *label2=[[UILabel alloc]init];
        label2.text=@"全新正品";
        label2.font=[UIFont systemFontOfSize:10];
        label2.textColor=RGBA(117, 117, 117, 1);
        [view addSubview:label2];
        [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(image2.mas_bottom).offset(5);
            make.left.equalTo(label1.mas_right).with.offset((self.view.frame.size.width-80-44*4)/3);
            make.width.equalTo(image2.mas_width);
            make.height.equalTo(@21);
        }];
        
        UILabel *label3=[[UILabel alloc]init];
        label3.text=@"售后无忧";
        label3.font=[UIFont systemFontOfSize:10];
        label3.textColor=RGBA(117, 117, 117, 1);
        [view addSubview:label3];
        [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(image1.mas_bottom).offset(5);
            make.left.equalTo(label2.mas_right).with.offset((self.view.frame.size.width-80-44*4)/3);
            make.width.equalTo(image1.mas_width);
            make.height.equalTo(@21);
        }];
        
        UILabel *label4=[[UILabel alloc]init];
        label4.text=@"收货须知";
        label4.font=[UIFont systemFontOfSize:10];
        label4.textColor=RGBA(117, 117, 117, 1);
        [view addSubview:label4];
        [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(image1.mas_bottom).offset(5);
            make.left.equalTo(label3.mas_right).with.offset((self.view.frame.size.width-80-44*4)/3);
            make.width.equalTo(image1.mas_width);
            make.height.equalTo(@21);
        }];
        
        
//        UILabel *sectionLabel = [[UILabel alloc] init];
//        sectionLabel.frame = CGRectMake(0, 0, self.view.frame.size.width, 444);
//        sectionLabel.textColor = [UIColor orangeColor];
//        sectionLabel.text = [NSString stringWithFormat:@"组%d",section];
//        sectionLabel.textAlignment = NSTextAlignmentCenter;
//
//        sectionLabel.userInteractionEnabled = YES;
//        sectionLabel.backgroundColor = [UIColor whiteColor];
//        sectionLabel.tag = 100 + section;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sectionClick:)];
        [view addGestureRecognizer:tap];
        
        return view;
    }

    
  
    
    return headView;
}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    if (section==1) {
//
//        if (self.isOpen==NO) {
//            return 0;
//        }else{
//            return [_dataArr[section] count];
//        }
//
//    }
        return [_dataArr[section] count];

  
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    if (tableView==_myView.table) {
//        
//   
//        return 1;
//    }
    return _dataArr.count;
}
//点击分期按钮

-(void)didClickButton:(UIButton*)button{
    
    //初始化进度框，置于当前的View当中
    

 
    
    
    UIButton *btn1 = [self.view viewWithTag:10001];
    UIButton *btn2 = [self.view viewWithTag:10002];
    if (btn1 == button) {
        
        [btn1 setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
         btn1.layer.borderColor=[UIColor orangeColor].CGColor;
        [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
       btn2.layer.borderColor=[UIColor blackColor].CGColor;
        
     
        self.mouthPrice=[NSString stringWithFormat:@"%.2f",[self.Price floatValue]/20];
        self.mouthNumber=@"6";
        
    }else{
        
        [btn2 setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
          btn2.layer.borderColor=[UIColor orangeColor].CGColor;
        [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
         btn1.layer.borderColor=[UIColor blackColor].CGColor;
        self.mouthPrice=[NSString stringWithFormat:@"%.2f",[self.Price floatValue]/20];
        self.mouthNumber=@"12";
    }
    if (button.selected==YES) {
        button.selected=NO;
    }else{
        button.selected=YES;
    }
    
    
    
    button.selected=!button.selected;
    MBProgressHUD *hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [hud hideAnimated:YES afterDelay:0.5];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.tableView reloadData];
    });
    
   
}
//点击开始下单按钮
-(void)didClickPayBtn{

    NSDate *now = [NSDate date];
//    NSLog(@"now date is: %@", now);
   
      NSCalendar *calendar = [NSCalendar currentCalendar];
      NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
       NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    
    long year = [dateComponent year];
    long month = [dateComponent month];
    long day = [dateComponent day];
    long hour = [dateComponent hour];
    long minute = [dateComponent minute];
    long second = [dateComponent second];

    NSString *orderNumber=[NSString stringWithFormat:@"JZ01%ld%02ld%02ld%02ld%02ld%02ld",year,month,day,hour,minute,second];
    
    NSString *orderTime=[NSString stringWithFormat:@"%ld-%02ld-%02ld %02ld:%02ld:%02ld",year,month,day,hour,minute,second];
    
    NSString *path=[[BWWSingleUser sharedSingleUser] sandBoxPath];
    BWWUserInformation *user=[[BWWUserInformation alloc]init];
    
    user=[NSKeyedUnarchiver unarchiveObjectWithFile:path];
    if (user==nil) {
        user = [BWWUserInformation new];
        
    }
    user.order_image=self.model.image;
    user.order_title=self.model.title;
    user.order_price=self.model.price_text;
    [BWWSingleUser sharedSingleUser].user=user;
    [NSKeyedArchiver archiveRootObject:user toFile:path];
    
   

    RealBuyViewController *vc=[[RealBuyViewController alloc]init];
    vc.model=self.model;
    vc.orderNumber=orderNumber;
    vc.orderTime=orderTime;
    vc.orderMouth=self.mouthNumber;
    vc.orderMouthPrice=self.mouthPrice;
    [self.navigationController pushViewController:vc animated:YES];
    
}
//点击详情按钮
-(void)didClickDetailBtn{
    NSLog(@"%d",[self.Price intValue]/[self.mouthPrice intValue]);

    _myView = [[MyView alloc] initWithFrame:CGRectMake(0, 0,KScreenWidth, KScreenHeight/3*2)];
    _myView.delegate = self;
  //  _myView.table.dataSource=self;
//    _myView.price=_Price;


    //UINib *nib2=[UINib nibWithNibName:@"MyViewTableViewHeadView" bundle:nil];
   // MyViewTableViewHeadView* headView=[nib2 instantiateWithOwner:nil options:nil][0];
   // headView.frame=CGRectMake(0, 0, KScreenWidth, 250) ;
    
   // headView.pirce.text=[NSString stringWithFormat:@"%.2f",[_mouthPrice floatValue]*[_mouthNumber floatValue]];
    //_myView.table.tableHeaderView=headView;
   // UINib *nib=[UINib nibWithNibName:@"MyViewDetailTableViewCell" bundle:nil];
   // [_myView.table registerNib:nib forCellReuseIdentifier:@"MyViewDetailTableViewCell"];
    // [_myView.table setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    
    [_myView showIn:self.view];
   
    
}
#pragma mark - MyViewDelegate
// 点击了自己
- (void)myView:(MyView *)myView didSelectedSelf:(id)sender
{
    [myView hide];
}

// 点击了阴影
- (void)myView:(MyView *)myView didSelectedShadow:(id)sender
{
    [myView hide];
}
- (void)myView:(MyView *)myView{
    
    myView.price=self.Price;
    
}
//点击展开
- (void)sectionClick:(UITapGestureRecognizer *)tap{
    int index = tap.view.tag % 100;
    
    NSMutableArray *indexArray = [[NSMutableArray alloc]init];
    NSArray *arr = _dataArr[index];
    for (int i = 0; i < arr.count; i ++) {
        NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:index];
        [indexArray addObject:path];
    }
    //展开
    if (self.isOpen==NO) {
        self.isOpen=YES;
        [_tableView reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationBottom];  //使用下面注释的方法就 注释掉这一句
    } else { //收起
        self.isOpen=NO;
        [_tableView reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationTop]; //使用下面注释的方法就 注释掉这一句
    }
   
}
@end
