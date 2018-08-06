//
//  WYIDDownViewController.m
//  WYIDCardOCR
//
//  Created by 汪年成 on 17/7/7.
//  Copyright © 2017年 之静之初. All rights reserved.
//

#import "BWWIDDownViewController.h"

@interface BWWIDDownViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *idImage;

@property (weak, nonatomic) IBOutlet UILabel *address;

@property (weak, nonatomic) IBOutlet UILabel *date;

@end

@implementation BWWIDDownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.idImage.image = self.resultModel.idImage;
    self.address.text = self.resultModel.issue;
    self.date.text = self.resultModel.valid;
    
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
    BWWUserInformation *user=[NSKeyedUnarchiver unarchiveObjectWithFile:path];
    if (user==nil) {
          user = [BWWUserInformation new];
    }
    user.IDinfo_address=self.resultModel.issue;
    
    [BWWSingleUser sharedSingleUser].user=user;
    
    [NSKeyedArchiver archiveRootObject:user toFile:path];
    if (self.navigationController.viewControllers.count==5) {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:2] animated:YES];
    }else{
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:3] animated:YES];
    }
   
}




@end
