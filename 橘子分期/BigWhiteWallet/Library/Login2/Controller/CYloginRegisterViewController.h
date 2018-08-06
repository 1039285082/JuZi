//
//  CYloginRegisterViewController.h
//  聪颖不聪颖
//
//  Created by 葛聪颖 on 15/9/27.
//  Copyright © 2015年 gecongying. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYLoginRegisterTextField.h"

@interface CYloginRegisterViewController : UIViewController

- (IBAction)doLogin:(id)sender;
- (IBAction)doRegister:(id)sender;
@property (weak, nonatomic) IBOutlet CYLoginRegisterTextField *fieldPhoneNumber;
@property (weak, nonatomic) IBOutlet CYLoginRegisterTextField *fieldPwd;
@property (weak, nonatomic) IBOutlet CYLoginRegisterTextField *fieldRegisterPhone;
@property (weak, nonatomic) IBOutlet CYLoginRegisterTextField *fieldRegisterPwd;


@end
