//
//  LoginVIew.m
//  BigWhiteWallet
//
//  Created by mac on 2018/6/12.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "LoginVIew.h"

@interface LoginVIew()
@property (strong, nonatomic) IBOutlet UIView *loginVIew;



@end
@implementation LoginVIew

-(void)awakeFromNib{
    [super awakeFromNib];
    [[NSBundle mainBundle]loadNibNamed:@"LoginVIew" owner:self options:nil];
    [self addSubview:self.loginVIew];
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"LoginVIew" owner:self options:nil];
        [self addSubview:self.loginVIew];
    }
    return self;
}


@end
