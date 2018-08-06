//
//  allOrderViewController.m
//  DWQListOfDifferentOrderStatus
//
//  Created by 杜文全 on 15/11/1.
//  Copyright © 2015年 com.iOSDeveloper.duwenquan. All rights reserved.
//

#import "allOrderViewController.h"
#import "CKAlertViewController.h"
#import "OrderTableViewCell.h"
#import "OrderModel.h"
#import "RepaymentViewController.h"
@interface allOrderViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic)UITableView * tableView;        //
@property (strong,nonatomic)NSMutableArray  * dataArr;        //

@end

@implementation allOrderViewController
//-(NSMutableArray *)dataArr{
//    if (_dataArr==nil) {
//        _dataArr=[NSMutableArray array];
//
//        }
//
//
//
//    return _dataArr;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
 
    UINib *nib1=[UINib nibWithNibName:@"OrderTableViewCell" bundle:nil];
    [self.tableView registerNib:nib1 forCellReuseIdentifier:@"OrderTableViewCell"];
    _tableView.sectionHeaderHeight = 1;
    _tableView.sectionFooterHeight = 1;
    _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0.0f,0.0f,_tableView.bounds.size.width,0.01f)];
   

    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    NSString *path=[[BWWSingleUser sharedSingleUser] sandBoxArrPath];
    _dataArr = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
  
    if (_dataArr != nil && ![_dataArr isKindOfClass:[NSNull class]] && _dataArr.count != 0) {
        //        UIImageView* imgView = [UIImageView new];
        //        imgView.image = [UIImage imageNamed:@""];
        [self.tableView setBackgroundView:nil];
        
        
    }else{
        UIImageView *image=[[UIImageView alloc]init];
        image.image=[UIImage imageNamed:@"no_order.jpg"];
        [self.tableView setBackgroundView:image];
        
    }
 
    [self.tableView reloadData];
}
#pragma - mark tableview数据源方法
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewAutomaticDimension;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
//    UITableViewCell *cell=[UITableViewCell new];
//    cell.textLabel.text=@"商品";
    
    long index= indexPath.section;
    OrderTableViewCell *cell=[self.tableView dequeueReusableCellWithIdentifier:@"OrderTableViewCell"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    OrderModel *model =_dataArr[index];
    
    cell.titleLabel.text=model.order_title;
    [cell.image sd_setImageWithURL:[NSURL URLWithString:model.order_image]];
    cell.totalPrice.text=model.order_price;
    cell.mouthPrice.text=model.order_mouthPrice;
    cell.fenQiLabel.text=[NSString stringWithFormat:@"%@个月",model.order_mouthNumber];
    cell.orderNumberLabel.text=[NSString stringWithFormat: @"订单号：%@",model.order_orderNumber];
    
    [cell.cancelBtn setTitleColor:RGBA(253, 109, 12, 1) forState:UIControlStateNormal];
    cell.cancelBtn.titleLabel.font=[UIFont boldSystemFontOfSize:14];
    
    [cell.cancelBtn.layer setMasksToBounds:YES];
    cell.cancelBtn.layer.borderWidth = 0.5;
    [cell.cancelBtn.layer setCornerRadius:1];
    [cell.cancelBtn.layer setBorderColor:[RGBA(253, 109, 12, 1)CGColor]];
//    objc_setAssociatedObject(cell.cancelBtn, "firstObject", indexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [cell.cancelBtn addTarget:self action:@selector(didClckCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    
       
    
    return  cell;
    
    
    
    
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RepaymentViewController*vc=[[RepaymentViewController alloc]init];
    long index= indexPath.section;
     OrderModel *model =_dataArr[index];
    vc.model=model;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _dataArr.count;
}

//点击取消订单按钮
-(void)didClckCancelBtn:(UIButton*)sender{
//    long idx=index.section;
  
    

    CKAlertViewController *alertVC = [CKAlertViewController alertControllerWithTitle:@"提示" message:@"确定要取消订单？" ];
    
    CKAlertAction *cancel = [CKAlertAction actionWithTitle:@"不取消" handler:^(CKAlertAction *action) {
        NSLog(@"点击了 %@ 按钮",action.title);
    }];
    
    CKAlertAction *sure = [CKAlertAction actionWithTitle:@"狠心取消" handler:^(CKAlertAction *action) {
        NSLog(@"点击了 %@ 按钮",action.title);
       
        UIView *contentView = [sender superview];
        OrderTableViewCell *cell = (OrderTableViewCell *)[contentView superview];
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        long idx=indexPath.section;
        //删除订单归档
        NSString *path=[[BWWSingleUser sharedSingleUser] sandBoxArrPath];
        self.dataArr = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        [self.dataArr removeObjectAtIndex:idx];

        [NSKeyedArchiver archiveRootObject:self.dataArr toFile:path];
        [self.tableView reloadData];
        
    }];
    
    [alertVC addAction:cancel];
    [alertVC addAction:sure];
    
    [self presentViewController:alertVC animated:NO completion:nil];
    
}

@end
