//
//  QQViewController.m
//  ACONApp
//
//  Created by suhe on 14/11/26.
//  Copyright (c) 2014年 zw. All rights reserved.
//
#define Kpadding 10

#import "QQViewController.h"
#import "OtherQQViewController.h"
@interface QQViewController ()

@end

@implementation QQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = KBackgroundColor;
    self.title = @"QQ登录";
    self.edgesForExtendedLayout = NO;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"切换账号" style:UIBarButtonItemStylePlain target:self action:@selector(btnClick)];
    [self addHeaderView];
    [self addBtn];
    
}
//切换账号
- (void) btnClick
{
    OtherQQViewController* other = [[OtherQQViewController alloc] init];
    [self.navigationController pushViewController:other animated:YES];

}
//添加上面的View
- (void)addHeaderView
{
    
    UIView* backgroundView = [[UIView alloc] init];
    backgroundView.frame = CGRectMake(0, 0, KScreenWidth, 250);
    backgroundView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backgroundView];
    
    UIImageView* bigView = [[UIImageView alloc] init];
    bigView.image = [UIImage imageNamed:@"login_background_image"];
    bigView.frame = CGRectMake(0, 0, backgroundView.frame.size.width, backgroundView.frame.size.height - 70);
    [backgroundView addSubview:bigView];

    UIImageView* iconImage = [[UIImageView alloc] init];
    CGFloat iconImageX = Kpadding;
    CGFloat iconImageY = bigView.frame.size.height + Kpadding;
    CGFloat iconImageW = 50;
    CGFloat iconImageH = 50;
    iconImage.frame = CGRectMake(iconImageX, iconImageY, iconImageW, iconImageH);
    iconImage.image = [UIImage imageNamed:@"touxiang"];
    [backgroundView addSubview:iconImage];
    
    UILabel* name = [[UILabel alloc] init];
    CGFloat nameX = CGRectGetMaxX(iconImage.frame) + Kpadding;
    CGFloat nameY = iconImageY;
    CGFloat nameW = 100;
    CGFloat nameH = iconImageH;
    name.frame = CGRectMake(nameX, nameY, nameW, nameH);
    name.text = @"秋天的落叶";
    name.contentMode = UIViewContentModeCenter;
    [backgroundView addSubview:name];
}
//添加确定按钮
- (void)addBtn
{
    UIButton* confirmBtn = [[UIButton alloc] init];
    CGFloat confirmBtnX = Kpadding*2;
    CGFloat confirmBtnY = 250 + Kpadding*2;
    CGFloat confirmBtnW = KScreenWidth - Kpadding*4;
    CGFloat confirmBtnH = 40;
    confirmBtn.frame = CGRectMake(confirmBtnX, confirmBtnY, confirmBtnW, confirmBtnH);
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [confirmBtn setBackgroundImage:[UIImage imageNamed:@"queding"] forState:UIControlStateNormal];
    [self.view addSubview:confirmBtn];


}
@end
