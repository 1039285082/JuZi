//
//  RegisterView.m
//  BigWhiteWallet
//
//  Created by mac on 2018/6/12.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RegisterView.h"

@implementation RegisterView

-(void)awakeFromNib{
    [super awakeFromNib];
    [[NSBundle mainBundle]loadNibNamed:@"RegisterView" owner:self options:nil];
    [self addSubview:self.registerView];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"RegisterView" owner:self options:nil];
        [self addSubview:self.registerView];
    }
    return self;
}

@end
