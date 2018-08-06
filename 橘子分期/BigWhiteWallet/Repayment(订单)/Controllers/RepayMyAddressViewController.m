//
//  RepayMyAddressViewController.m
//  BigWhiteWallet
//
//  Created by mac on 2018/6/21.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RepayMyAddressViewController.h"

@interface RepayMyAddressViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic)UITableView * tableView;        //订单
@end

@implementation RepayMyAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    if ([BWWSingleUser sharedSingleUser].user.order_name==nil) {
//        UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(40, 100, 200, 30)];
//        lable.text=@"你还没有订单";
//        [self.view addSubview:lable];
//    }else{
//        
//        
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma - mark tableview代理

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    UITableViewCell *cell=[UITableViewCell new];
//    if (indexPath.section==0) {
//        RepayAddressTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"RepayAddressTableViewCell"];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
//        return cell;
//    }
    return  cell;
    
    
    
    
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

@end
