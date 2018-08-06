//
//  PopView.m
//  弹出动画_demo2
//
//  Created by liman on 11/26/15.
//  Copyright © 2015 apple. All rights reserved.
//

#import "PopView.h"
#import "UIViewExt.h"

@implementation PopView
{
    UIView *shadowView;
}

#pragma mark - tool
// 设置参数默认值
- (void)setDefaults
{
    //动画时间默认值
    if (!_animateDuration) {
        _animateDuration = 0.2;
    }
    //阴影颜色默认值
    if (!_shadowColor) {
        _shadowColor = [UIColor grayColor];
    }
    //阴影透明度默认值
    if (!_shadowAlpha) {
        _shadowAlpha = 0.5;
    }
    //圆角弧度默认值
    if (!_radius) {
        _radius = 10;
    }
}

#pragma mark - setter
//动画弹出类型
- (void)setPopType:(PopType)popType
{
    _popType = popType;
    
    if (_popType == PopTypeScale) {
        self.transform = CGAffineTransformMakeScale(0.01, 0.01);
    }
}

// 仅针对 动画弹出类型:Move
- (void)setMoveAppearDirection:(MoveAppearDirection)moveAppearDirection
{
    _moveAppearDirection = moveAppearDirection;
    
    switch (_moveAppearDirection) {
        case 0:
        {
            self.bottom = 0;
        }
            break;
        case 1:
        {
            self.right = 0;
        }
            break;
        case 2:
        {
            self.top = [UIScreen mainScreen].bounds.size.height;
        }
            break;
        case 3:
        {
            self.left = [UIScreen mainScreen].bounds.size.width;
        }
            break;
        default:
            break;
    }
}

//圆角弧度
- (void)setRadius:(CGFloat)radius
{
    _radius = radius;
    
    self.layer.cornerRadius = _radius;
}

#pragma mark - public
/**
 *  在父视图显示
 */
- (void)showIn:(UIView *)superView
{
    // 1.半透明阴影
    shadowView = [[UIView alloc] initWithFrame:superView.bounds];
    shadowView.backgroundColor = _shadowColor;
    shadowView.alpha = 0;
    [shadowView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(PopViewShadowTapped:)]];
    [superView addSubview:shadowView];
    
    // 2.添加到父视图上面去
    [superView addSubview:self];
    
    // 3.动画
    if (_popType == PopTypeMove)
    {
        shadowView.alpha = _shadowAlpha;
        self.alpha = 1;
        
        [UIView animateWithDuration:_animateDuration animations:^{
            if (_moveAppearCenterX)
            {
                self.centerX = _moveAppearCenterX;
            }
            if (_moveAppearCenterY)
            {
                self.centerY = _moveAppearCenterY;
            }
        }];
    }
    else
    {
        [UIView animateWithDuration:_animateDuration animations:^{
            shadowView.alpha = _shadowAlpha;
            self.alpha = 1;
            
            if (_popType == PopTypeScale) {
                self.transform = CGAffineTransformIdentity;
            }
        }];
    }
}

/**
 *  隐藏
 */
- (void)hide
{
    if (_popType == PopTypeMove)
    {
        switch (_moveDisappearDirection) {
            case 0:
            {
                [UIView animateWithDuration:_animateDuration animations:^{
                    self.bottom = 0;
                } completion:^(BOOL finished) {
                    shadowView.alpha = 0;
                    self.alpha = 0;
                    
                    [shadowView removeFromSuperview];
                    [self removeFromSuperview];
                }];
            }
                break;
            case 1:
            {
                [UIView animateWithDuration:_animateDuration animations:^{
                    self.right = 0;
                } completion:^(BOOL finished) {
                    shadowView.alpha = 0;
                    self.alpha = 0;
                    
                    [shadowView removeFromSuperview];
                    [self removeFromSuperview];
                }];
            }
                break;
            case 2:
            {
                [UIView animateWithDuration:_animateDuration animations:^{
                    self.top = [UIScreen mainScreen].bounds.size.height;
                } completion:^(BOOL finished) {
                    shadowView.alpha = 0;
                    self.alpha = 0;
                    
                    [shadowView removeFromSuperview];
                    [self removeFromSuperview];
                }];
            }
                break;
            case 3:
            {
                [UIView animateWithDuration:_animateDuration animations:^{
                    self.left = [UIScreen mainScreen].bounds.size.width;
                } completion:^(BOOL finished) {
                    shadowView.alpha = 0;
                    self.alpha = 0;
                    
                    [shadowView removeFromSuperview];
                    [self removeFromSuperview];
                }];
            }
                break;
            default:
                break;
        }
    }
    else
    {
        [UIView animateWithDuration:_animateDuration animations:^{
            shadowView.alpha = 0;
            self.alpha = 0;
            
            if (_popType == PopTypeScale) {
                self.transform = CGAffineTransformMakeScale(0.01, 0.01);
            }
            
        } completion:^(BOOL finished) {
            [shadowView removeFromSuperview];
            [self removeFromSuperview];
        }];
    }
}

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 设置参数默认值
        [self setDefaults];
        
        self.alpha = 0;
        self.backgroundColor = [UIColor whiteColor];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = _radius;
    }
    
    return self;
}

#pragma mark - target action
- (void)PopViewShadowTapped:(UITapGestureRecognizer *)tap
{
    
}

@end
