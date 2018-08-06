//
//  WYBankViewController.m
//  WYIDCardOCR
//
//  Created by 汪年成 on 17/7/7.
//  Copyright © 2017年 之静之初. All rights reserved.
//

#import "BWWBankViewController.h"
@class CertificationViewController;

@interface BWWBankViewController ()

       //
@property (weak, nonatomic) IBOutlet UIImageView *icomimage;

@property (weak, nonatomic) IBOutlet UILabel *bank;

@property (weak, nonatomic) IBOutlet UILabel *name;

@end

@implementation BWWBankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    self.icomimage.image = self.resultModel.bankImage;
    self.bank.text = self.resultModel.bankNumber;
    self.name.text = self.resultModel.bankName;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/** 错误，重新拍 */
- (IBAction)wrong:(id)sender {
     [self.navigationController popViewControllerAnimated:YES];
}

/** 正确，下一步 */
- (IBAction)exactness:(id)sender {
    NSString *path=[[BWWSingleUser sharedSingleUser] sandBoxPath];
    BWWUserInformation *user=[[BWWUserInformation alloc]init];
    
    user=[NSKeyedUnarchiver unarchiveObjectWithFile:path];
    if (user==nil) {
        user = [BWWUserInformation new];
        
    }
    user.user_bankName=self.resultModel.bankName;
    user.user_bankNumber=self.resultModel.bankNumber;
    [BWWSingleUser sharedSingleUser].user=user;
    [NSKeyedArchiver archiveRootObject:user toFile:path];
    if (self.navigationController.viewControllers.count==5) {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:2] animated:YES];
    }else if(self.navigationController.viewControllers.count==7){
     
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:4] animated:YES];
    } else{
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:3] animated:YES];
    }
   
    
    
}



@end
