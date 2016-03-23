//
//  OtherLoginBtn.m
//  ACONApp
//
//  Created by suhe on 14/11/26.
//  Copyright (c) 2014年 zw. All rights reserved.
//

#import "OtherLoginBtn.h"

@interface OtherLoginBtn ()
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UIImageView* iconView;
@property (nonatomic, strong) UIImageView* dividerView;

@end
@implementation OtherLoginBtn

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageNamed:@"baidi"];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)addOtherLoginBtnTitle:(NSString *)title IconImage:(NSString *)iconImage DividerImage:(NSString *)dividerImage
{
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    NSAttributedString *str4 = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName : [UIColor grayColor],NSFontAttributeName : [UIFont systemFontOfSize:13]}];
    [btn setAttributedTitle:str4 forState:UIControlStateNormal];
    str4 = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName : [[UIColor alloc] initWithWhite:0.7 alpha:0.8],NSFontAttributeName : [UIFont systemFontOfSize:13]}];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0);
    btn.userInteractionEnabled = NO;
    [self addSubview:btn];
    
    UIImageView* divider = [[UIImageView alloc] init];
    divider.image = [UIImage imageNamed:dividerImage];
    [self addSubview:divider];
    
    
    UIImageView* icon = [[UIImageView alloc] init];
    icon.image = [UIImage imageNamed:iconImage];
    [self addSubview:icon];
    
    self.loginBtn = btn;
    self.iconView = icon;
    self.dividerView = divider;
}


- (void)layoutSubviews
{
    //设置按钮的Frame
    CGFloat iconImageX = 3;
    CGFloat iconImagey = 3;
    CGFloat iconImageW = self.frame.size.height - 6;
    CGFloat iconImageH = self.frame.size.height - 6;
    self.iconView.frame = CGRectMake(iconImageX, iconImagey, iconImageW, iconImageH);
    
    CGFloat dividerViewX = iconImageW + 6;
    CGFloat dividerViewY = 2;
    CGFloat dividerViewW = 1;
    CGFloat dividerViewH = self.frame.size.height - 4;
    self.dividerView.frame = CGRectMake(dividerViewX, dividerViewY, dividerViewW, dividerViewH);
    
    CGFloat btnX = iconImageW + dividerViewW;
    CGFloat btnY = 0;
    CGFloat btnW = self.frame.size.width - btnX;
    CGFloat btnH = self.frame.size.height;
    self.loginBtn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    
}



@end
