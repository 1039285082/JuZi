//
//  RegisterView.h
//  BigWhiteWallet
//
//  Created by mac on 2018/6/12.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterView : UIView
@property (strong, nonatomic) IBOutlet UIView *registerView;
@property (weak, nonatomic) IBOutlet UIButton *registBtn;


@property (weak, nonatomic) IBOutlet UITextField *registTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *registTextFiledPassword;
@property (weak, nonatomic) IBOutlet UIButton *backBtn1;

@end
