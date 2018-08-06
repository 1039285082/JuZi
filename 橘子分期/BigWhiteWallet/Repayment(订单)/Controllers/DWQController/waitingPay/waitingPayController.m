//
//  allOrderViewController.m
//  DWQListOfDifferentOrderStatus
//
//  Created by 杜文全 on 15/11/1.
//  Copyright © 2015年 com.iOSDeveloper.duwenquan. All rights reserved.
//

#import "waitingPayController.h"
#import "CKAlertViewController.h"
#import "RealBuyViewController.h"
#import "OrderTableViewCell.h"
#import "OrderModel.h"
@interface waitingPayController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic)UITableView * tableView;        //
@property (strong,nonatomic)NSMutableArray  * dataArr;        //

@end

@implementation waitingPayController
-(NSMutableArray *)dataArr{
    if (_dataArr==nil) {
        _dataArr=[NSMutableArray array];
    }
    
    
    
    return _dataArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    UINib *nib1=[UINib nibWithNibName:@"OrderTableViewCell" bundle:nil];
    [self.tableView registerNib:nib1 forCellReuseIdentifier:@"OrderTableViewCell"];
    _tableView.sectionHeaderHeight = 1;
    _tableView.sectionFooterHeight = 1;
    _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0.0f,0.0f,_tableView.bounds.size.width,0.01f)];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    
    NSString *path=[[BWWSingleUser sharedSingleUser] sandBoxNotArrPath];
    _dataArr = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    if (_dataArr != nil && ![_dataArr isKindOfClass:[NSNull class]] && _dataArr.count != 0) {
        //        UIImageView* imgView = [UIImageView new];
        //        imgView.image = [UIImage imageNamed:@""];
        [self.tableView setBackgroundView:nil];
        
        
    }else{
        UIImageView *image=[[UIImageView alloc]init];
        image.image=[UIImage imageNamed:@"no_order.jpg"];
        [self.tableView setBackgroundView:image];
        //        [self.tableView addSubview:label];
    }
    
    
    [self.tableView reloadData];
}

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
    [cell.cancelBtn setTitle:@"去付款" forState:UIControlStateNormal];
    
    cell.cancelBtn.titleLabel.font=[UIFont boldSystemFontOfSize:14];
    
    [cell.cancelBtn.layer setMasksToBounds:YES];
    cell.cancelBtn.layer.borderWidth = 0.5;
    [cell.cancelBtn.layer setCornerRadius:1];
    [cell.cancelBtn.layer setBorderColor:[RGBA(253, 109, 12, 1)CGColor]];

    
 
//    346 171; 100 30
    [cell.deletBtn setTitleColor:RGBA(253, 109, 12, 1) forState:UIControlStateNormal];
    [cell.deletBtn setTitle:@"取消订单" forState:UIControlStateNormal];
    
    cell.deletBtn.titleLabel.font=[UIFont boldSystemFontOfSize:14];
    
    [cell.deletBtn.layer setMasksToBounds:YES];
    cell.deletBtn.layer.borderWidth = 0.5;
    [cell.deletBtn.layer setCornerRadius:1];
    [cell.deletBtn.layer setBorderColor:[RGBA(253, 109, 12, 1)CGColor]];
    cell.deletBtn.hidden=NO;

    
    [cell.cancelBtn addTarget:self action:@selector(didClckCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
   [cell.deletBtn addTarget:self action:@selector(didClickDeletBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    return  cell;
    
    
    
    
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _dataArr.count;
}
-(void)didClckCancelBtn:(UIButton*)sender{
    
    UIView *contentView = [sender superview];
    OrderTableViewCell *cell = (OrderTableViewCell *)[contentView superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    long idx=indexPath.section;
    OrderModel *model=[OrderModel new];
    
    model=_dataArr[idx];
    
    RealBuyViewController *vc=[[RealBuyViewController alloc]init];
    vc._isOrder=YES;
    vc.model=[CommodityModel new];
    vc.model.title=model.order_title;
    vc.model.image=model.order_image;
    vc.model.price_text=model.order_price;
    vc.orderTime=model.order_orderTime;
    vc.orderNumber=model.order_orderNumber;
    vc.orderMouthPrice=model.order_mouthPrice;
    vc.orderMouth=model.order_mouthNumber;

    vc.index=idx;




    [self.navigationController pushViewController:vc animated:YES];

    
}
-(void)didClickDeletBtn:(UIButton*)sender{

    
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
        NSString *path=[[BWWSingleUser sharedSingleUser] sandBoxNotArrPath];
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
