//
//  DetailsViewController.m
//  BigWhiteWallet
//
//  Created by mac on 2018/6/11.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "DetailsViewController.h"
#import "BuyViewController.h"
#import "BWWCertificateGuideViewController.h"
#import <MBProgressHUD.h>
@interface DetailsViewController ()<WKNavigationDelegate,WKUIDelegate>
@property (strong,nonatomic)WKWebView * detailsWebview;        //
@end

@implementation DetailsViewController
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
    
    self.title=@"商品详情";
    
    NSURL *url=[NSURL URLWithString:self.model.image];
    [self.imageView sd_setImageWithURL:url];
    self.nameLabel.text=self.model.title;
    
    self.topPrice.text=[NSString stringWithFormat:@"总价:%@元",self.model.price_text];
    self.mouthPrice.text=[NSString stringWithFormat:@"共%d个月/月供：%d元",6,[self.model.price_text intValue]/6];
    

//    self.detailsWebview=[[WKWebView alloc]initWithFrame:CGRectMake(0, 350, KScreenWidth, KScreenHeight-490)];
    self.detailsWebview=[[WKWebView alloc]init];
    self.detailsWebview.frame=CGRectMake(0, 350, KScreenWidth, KScreenHeight-490);
    
    self.detailsWebview.UIDelegate=self;
    self.detailsWebview.navigationDelegate=self;
    NSString *path=[[NSBundle mainBundle] pathForResource:_model.link ofType:nil];
    if (path) {
        [self.detailsWebview loadFileURL:[NSURL fileURLWithPath:path] allowingReadAccessToURL:[NSBundle mainBundle].resourceURL];
    }

    [self.view addSubview:self.detailsWebview];
    
    [self.detailsWebview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topPrice.mas_bottom).offset(0);
        make.width.equalTo(@KScreenWidth);
        make.bottom.equalTo(self.buyBtn.mas_top).offset(0);
    }];
    
}
-(void)viewWillAppear:(BOOL)animated{
    
    [self.buyBtn setTitle:@"点击租赁" forState:UIControlStateNormal];
    [self.buyBtn setTintColor:[UIColor whiteColor]];
    [self.buyBtn setBackgroundColor:kBackGroundColor];
    [self.buyBtn addTarget:self action:@selector(buy) forControlEvents:UIControlEventTouchUpInside];
    
    
}

-(void)buy{
    if (([BWWSingleUser sharedSingleUser].user.IDinfo_name==nil)||([BWWSingleUser sharedSingleUser].user.IDinfo_address==nil)||([BWWSingleUser sharedSingleUser].user.user_bankName==nil)) {
    
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.label.numberOfLines=0;
        hud.label.text=@"您还没有认证，请先认证！";
        [hud hideAnimated:YES afterDelay:0.5];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            BWWCertificateGuideViewController *vc=[[BWWCertificateGuideViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        });
        

    }else{
        BuyViewController *VC=[[BuyViewController alloc]init];
        
        VC.Price= [NSString stringWithFormat:@"%.2f",[[self.model.price_text substringFromIndex:1] floatValue]];
        VC.model=self.model;
        [self.navigationController pushViewController:VC animated:YES];
    }
 
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
