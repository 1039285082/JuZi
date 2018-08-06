//
//  CYloginRegisterViewController.m
//  聪颖不聪颖
//
//  Created by 葛聪颖 on 15/9/27.
//  Copyright © 2015年 gecongying. All rights reserved.
//

#import "CYloginRegisterViewController.h"
#import "AppDelegate.h"
#import "CKAlertViewController.h"
#import "CYloginRegisterViewController.h"
//#import "Helper.h"

@interface CYloginRegisterViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingSpace;

@end

@implementation CYloginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    self.loginButton.layer.cornerRadius = 5;
    //    self.loginButton.layer.masksToBounds = YES;
    //    [self.loginButton setValue:@5 forKeyPath:@"layer.cornerRadius"];
    //    [self.loginButton setValue:@YES forKeyPath:@"layer.masksToBounds"];
    //    self.loginButton.clipsToBounds = YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (IBAction)close
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (IBAction)loginOrRegister:(UIButton *)button
{
    // 修改约束
    if (self.leadingSpace.constant == 0) {
        self.leadingSpace.constant = - self.view.width;
//        [button setTitle:@"已有账号？" forState:UIControlStateNormal];
        button.selected = YES;
    }else
    {
        self.leadingSpace.constant = 0;
//        [button setTitle:@"注册账号" forState:UIControlStateNormal];
        button.selected = NO;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}


- (IBAction)doLogin:(id)sender {
//    NSString* phoneNumber = self.fieldPhoneNumber.text;
//    NSString* pwd = self.fieldPwd.text;
//
//    NSString *savedUserName = [[NSUserDefaults standardUserDefaults]
//                            stringForKey:@"kivziv_user"];
//    NSString *savedPwd = [[NSUserDefaults standardUserDefaults]
//                               stringForKey:@"kivziv_pwd"];
//    if(([phoneNumber isEqualToString:@"15900115800"] && [pwd isEqualToString:@"456321"]) ||
//       ([phoneNumber isEqualToString:savedUserName] && [pwd isEqualToString:savedPwd])) {
//        AppDelegate* del = (AppDelegate*)([UIApplication sharedApplication].delegate);
//        if(del.userSession == nil) {
//            del.userSession = [[UserSession alloc] init];
//        }
//        del.userSession.IsLoggedIn = YES;
//        del.userSession.PhoneNumberText = phoneNumber;
//        del.userSession.UserNameText = phoneNumber;
//        del.userSession.PasswordText = pwd;
//        [Helper saveUserSession:del.userSession];
//        [self.view makeToast:@"登录成功！"];
//        [self dismissViewControllerAnimated:YES completion:nil];
//    }
//    if (([BWWSingleUser sharedSingleUser].user.user_account==nil)||([BWWSingleUser sharedSingleUser].user.user_password==nil)) {
//        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        hud.label.numberOfLines=0;
//        hud.label.text=@"您还没有注册，请先注册！";
//        [hud hideAnimated:YES afterDelay:0.5];
//    }else{
    
       
        if ( ([self.fieldPhoneNumber.text isEqualToString:[BWWSingleUser sharedSingleUser].user.user_account]&&[self.fieldPwd.text isEqualToString:[BWWSingleUser sharedSingleUser].user.user_password])||([self.fieldPhoneNumber.text isEqualToString:@"13161706800"]&&[self.fieldPwd.text isEqualToString:@"123456"])) {
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.label.numberOfLines=0;
            hud.label.text=@"登录成功";
            
            
            NSString *path=[[BWWSingleUser sharedSingleUser] sandBoxPath];
            BWWUserInformation *user=[[BWWUserInformation alloc]init];
            
            user=[NSKeyedUnarchiver unarchiveObjectWithFile:path];
            if (user==nil) {
                user = [BWWUserInformation new];
                
            }
            user.isLogin=YES;
            
            if (([self.fieldPhoneNumber.text isEqualToString:@"13161706800"]&&[self.fieldPwd.text isEqualToString:@"123456"])) {
                user.IDinfo_name=@"123";
                user.IDinfo_code=@"411523************";
                user.user_bankName=@"**银行";
                user.user_bankNumber=@"************1234";
                user.IDinfo_address=@"****";
            }
            
            [BWWSingleUser sharedSingleUser].user=user;
            [NSKeyedArchiver archiveRootObject:user toFile:path];
            
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self dismissViewControllerAnimated:YES completion:nil];
                
            });
            
        }else{
            
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.label.numberOfLines=0;
            hud.label.text=@"您输入的账号或密码错误!请重新输入";
            [hud hideAnimated:YES afterDelay:1.0];
        }
        
//    }
}

- (IBAction)doRegister:(id)sender {
//    NSString* phoneNumber = self.fieldRegisterPhone.text;
//    NSString* pwd = self.fieldRegisterPwd.text;
//
//    if(phoneNumber == nil || [phoneNumber isEqualToString:@""] || pwd == nil || [pwd isEqualToString:@""]) {
//        [self.view makeToast:@"用户名和密码不能为空！"];
//    } else {
//        [[NSUserDefaults standardUserDefaults] setObject:phoneNumber forKey:@"kivziv_user"];
//        [[NSUserDefaults standardUserDefaults] setObject:pwd forKey:@"kivziv_pwd"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"注册成功" message:@"注册成功，请登陆！" preferredStyle:  UIAlertControllerStyleAlert];
//
//        //[alert addAction: [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:nil]];
//        [alert addAction:[UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            self.leadingSpace.constant = 0;
//            [UIView animateWithDuration:0.25 animations:^{
//                [self.view layoutIfNeeded];
//            }];
//        }]];
//        [self presentViewController:alert animated:false completion:nil];
//    }
    
    if (self.fieldRegisterPhone.text.length<11) {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.label.numberOfLines=0;
        hud.label.text=@"您输入的手机号有误！";
        [hud hideAnimated:YES afterDelay:1.0];
    }else{
        
        NSString *path=[[BWWSingleUser sharedSingleUser] sandBoxPath];
        BWWUserInformation *user=[[BWWUserInformation alloc]init];
        
        user=[NSKeyedUnarchiver unarchiveObjectWithFile:path];
        if (user==nil) {
            user = [BWWUserInformation new];
            
        }
        user.user_account=self.fieldRegisterPhone.text;
        user.user_password=self.fieldRegisterPwd.text;
        [BWWSingleUser sharedSingleUser].user=user;
        [NSKeyedArchiver archiveRootObject:user toFile:path];
        
        [self.fieldRegisterPhone resignFirstResponder];
        [self.fieldRegisterPwd resignFirstResponder];
        
        CKAlertViewController *alertVC = [CKAlertViewController alertControllerWithTitle:@"提示" message:@"您已成功注册,请登录" ];
        
       
        CKAlertAction *sure = [CKAlertAction actionWithTitle:@"好" handler:^(CKAlertAction *action) {
            self.leadingSpace.constant=0;
            [UIView animateWithDuration:0.25 animations:^{
                [self.view layoutIfNeeded];
            }];
  
        }];
        
//        [alertVC addAction:sure];
        [alertVC addAction:sure];
        
        [self presentViewController:alertVC animated:NO completion:nil];
        
    }
    
}
@end
