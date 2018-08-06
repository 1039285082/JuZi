//
//  AddPayBankViewController.m
//  BigWhiteWallet
//
//  Created by mac on 2018/6/19.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "AddPayBankViewController.h"
#import "GYBankCardFormatTextField.h"
#import "WYIDScanViewController.h"
#import "BWWBankViewController.h"

@interface AddPayBankViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UILabel *kaHaoLabel;
@property (strong,nonatomic)GYBankCardFormatTextField * bankCardNumber;        //
@property (weak, nonatomic) IBOutlet UIButton *cameraButton;
@property (weak, nonatomic) IBOutlet UIButton *alertButton;
@property (weak, nonatomic) IBOutlet UIButton *completeBtn;

      //
@end

@implementation AddPayBankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    [self.navigationController.navigationBar setBarTintColor: [UIColor blackColor]];
    self.title=@"修改银行卡";
    self.nameText.text=[BWWSingleUser sharedSingleUser].user.IDinfo_name;
    self.nameText.enabled=NO;
    
    _bankCardNumber = [[GYBankCardFormatTextField alloc]initWithFrame:CGRectMake(87,89, 230, 30)];
    _bankCardNumber.borderStyle = UITextBorderStyleNone;
    [self.view addSubview:_bankCardNumber];
    [_bankCardNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameText.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(89);
        make.center.equalTo(self.kaHaoLabel);
        make.width.equalTo(@230);
        make.height.equalTo(@30);
    }];
    [_cameraButton addTarget:self action:@selector(didClickCameraButton) forControlEvents:UIControlEventTouchUpInside];
    [_completeBtn addTarget:self action:@selector(didClickCompleteBtn) forControlEvents:UIControlEventTouchUpInside];
}

-(void)didClickCompleteBtn{
    if (_bankCardNumber.text.length<=15) {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.label.numberOfLines=0;
        hud.label.text=@"您输入的银行卡号有误，请重新输入";
        [hud hideAnimated:YES afterDelay:0.5];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
}

//点击照相按钮
-(void)didClickCameraButton{
    WYIDScanViewController *VC = [[WYIDScanViewController alloc] initWithCarInfo:CardIDBank];
    
    [VC scanDidFinishCarInfo:^(CardType status, WYScanResultModel *scanModel) {
        
        
        BWWBankViewController *VC = [BWWBankViewController new];
        VC.resultModel = scanModel;
        [self.navigationController pushViewController:VC animated:YES];
        
    }];
    
    [self.navigationController pushViewController:VC animated:YES];
    
    
}
-(void)viewWillAppear:(BOOL)animated{
   
    [_bankCardNumber becomeFirstResponder];
    if (self.bankNumber==nil) {
        _bankCardNumber.text=self.bankNumber;
    }else{
         _bankCardNumber.text=[BWWSingleUser sharedSingleUser].user.user_bankNumber;
    }
  

}
-(void)viewWillDisappear:(BOOL)animated{
    self.bankNumber=@"1";
     
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
