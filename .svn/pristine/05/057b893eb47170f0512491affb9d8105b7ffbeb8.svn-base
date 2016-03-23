 //
//  HomeViewController.m
//  ACONApp
//
//  Created by 朱红轻飞溅 on 14/12/2.
//  Copyright (c) 2014年 zw. All rights reserved.
//

#import "HomeViewController.h"
#import "BMPopView.h"

#import "DataListViewController.h"//数据列表
#import "UserManageController.h" //用户管理
#import "AiKangNewsViewController.h"//艾康资讯
#import "KnowledgeViewController.h"//艾康知道
#import "ConnectAikangController.h"//联系艾康
#import "PersonalViewController.h"//我的
#import "BloodGlucoseManageController.h"//血糖管理
#import "BloodGlucosemeasurementController.h"//手动输入
#import "ConnectDeviceViewController.h"//连接设备

#import "LoginInfoModel.h"
#import "LoginInfoData.h"

/**
 *  定义是否第一次访问的key
 */
#define KEY_HAS_LAUNCHED_ONCE_ZW   @"HasLaunchedOnceZW"

@interface HomeViewController ()<BMPopViewDelegate>
{
    UIImageView *footerImg;
    LoginInfoModel *userinfo;
    UIImageView *photoImgView;//头像
}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.view.backgroundColor = IWGlobalBg;

    [self creatMainView];
    [self createItemBtn];
    [self createFooterView];
    
    [self createPopView];
}


-(void)viewDidAppear:(BOOL)animated{
   
    [super viewDidAppear:animated];
    
    userinfo = [SaveUserInfo loadCustomObjectWithKey];
    
    [photoImgView sd_setImageWithURL:[NSURL URLWithString:userinfo.data.portraitURL] placeholderImage:[UIImage imageNamed:@"touxiang"]];

}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}

- (void)creatMainView
{
    //背景图
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:self.view.frame];
    bgImgView.image = [UIImage imageNamed:@"beijing_zw"];
    [self.view addSubview:bgImgView];
    
    UIImageView *headerImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 150)];
    headerImgView.image = [UIImage imageNamed:@"tou_zw"];
    [self.view addSubview:headerImgView];
    
    UILabel *headerLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, KScreenWidth, 30)];
    headerLB.text = @"艾检";
    headerLB.textColor = [UIColor whiteColor];
    headerLB.font = [UIFont systemFontOfSize:20];
    headerLB.textAlignment = NSTextAlignmentCenter;
    [headerImgView addSubview:headerLB];
    
    UIView *photoView = [[UIView alloc] initWithFrame:CGRectMake(KScreenWidth/2 - 100/2, 150 - 100/2, 100, 100)];
    photoView.backgroundColor = [UIColor colorWithRed:236/255.0 green:250/255.0 blue:251/255.0 alpha:1.0];
    photoView.layer.cornerRadius = 100/2;
    [self.view addSubview:photoView];
    
    photoImgView = [[UIImageView alloc] initWithFrame:CGRectMake(KScreenWidth/2 - 90/2, 150 - 90/2, 90, 90)];

    [photoImgView sd_setImageWithURL:[NSURL URLWithString:userinfo.data.portraitURL] placeholderImage:[UIImage imageNamed:@"touxiang"]];
    photoImgView.clipsToBounds = YES;
    photoImgView.layer.cornerRadius = 90/2;
    photoImgView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jump)];
    [photoImgView addGestureRecognizer:singleTap];
    
    [self.view addSubview:photoImgView];
    
}

- (void)createItemBtn
{
    CGFloat btnWH = 80;
    CGFloat lbWH = 30;
    CGFloat Kboder = (KScreenWidth-btnWH*3)/4;
    
    UIButton *btnItem1 = [[UIButton alloc] initWithFrame:CGRectMake(Kboder, 150 + 50 +20, btnWH, btnWH)];
    [btnItem1 setBackgroundImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
    [btnItem1 addTarget:self action:@selector(btnItem1Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnItem1];
    
    UILabel *LBItme1 = [[UILabel alloc] initWithFrame:CGRectMake(Kboder, CGRectGetMaxY(btnItem1.frame), btnWH, lbWH)];
    LBItme1.text = @"数据列表";
    LBItme1.font = [UIFont systemFontOfSize:14];
    LBItme1.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:LBItme1];
    
    
    UIButton *btnItem2 = [[UIButton alloc] initWithFrame:CGRectMake(Kboder + CGRectGetMaxX(btnItem1.frame), 150 + 50 +20, btnWH, btnWH)];
    [btnItem2 setBackgroundImage:[UIImage imageNamed:@"2"] forState:UIControlStateNormal];
    [btnItem2 addTarget:self action:@selector(btnItem2Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnItem2];
    
    UILabel *LBItme2 = [[UILabel alloc] initWithFrame:CGRectMake(Kboder + CGRectGetMaxX(btnItem1.frame), CGRectGetMaxY(btnItem1.frame), btnWH, lbWH)];
    LBItme2.text = @"血糖管理";
    LBItme2.font = [UIFont systemFontOfSize:14];
    LBItme2.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:LBItme2];
    
    UIButton *btnItem3 = [[UIButton alloc] initWithFrame:CGRectMake(Kboder + CGRectGetMaxX(btnItem2.frame), 150 + 50 +20, btnWH, btnWH)];
    [btnItem3 setBackgroundImage:[UIImage imageNamed:@"3"] forState:UIControlStateNormal];
    [btnItem3 addTarget:self action:@selector(btnItem3Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnItem1];
    [self.view addSubview:btnItem3];
    
    UILabel *LBItme3 = [[UILabel alloc] initWithFrame:CGRectMake(Kboder + CGRectGetMaxX(btnItem2.frame), CGRectGetMaxY(btnItem1.frame), btnWH, lbWH)];
    LBItme3.text = @"用户管理";
    LBItme3.font = [UIFont systemFontOfSize:14];
    LBItme3.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:LBItme3];
    
    
    UIButton *btnItem4 = [[UIButton alloc] initWithFrame:CGRectMake(Kboder, CGRectGetMaxY(btnItem1.frame)+40, btnWH, btnWH)];
    [btnItem4 setBackgroundImage:[UIImage imageNamed:@"4"] forState:UIControlStateNormal];
    [btnItem4 addTarget:self action:@selector(btnItem4Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnItem4];
    
    UILabel *LBItme4 = [[UILabel alloc] initWithFrame:CGRectMake(Kboder, CGRectGetMaxY(btnItem4.frame), btnWH, lbWH)];
    LBItme4.text = @"艾检资讯";//@"艾康咨询";
    LBItme4.font = [UIFont systemFontOfSize:14];
    LBItme4.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:LBItme4];
    
    UIButton *btnItem5 = [[UIButton alloc] initWithFrame:CGRectMake(Kboder + CGRectGetMaxX(btnItem4.frame) , CGRectGetMaxY(btnItem1.frame)+40, btnWH, btnWH)];
    [btnItem5 setBackgroundImage:[UIImage imageNamed:@"5"] forState:UIControlStateNormal];
    [btnItem5 addTarget:self action:@selector(btnItem5Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnItem5];
    
    UILabel *LBItme5 = [[UILabel alloc] initWithFrame:CGRectMake(Kboder + CGRectGetMaxX(btnItem4.frame), CGRectGetMaxY(btnItem4.frame), btnWH, lbWH)];
    LBItme5.text = @"艾检知道";//@"艾康知道";
    LBItme5.font = [UIFont systemFontOfSize:14];
    LBItme5.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:LBItme5];
    
    
    UIButton *btnItem6 = [[UIButton alloc] initWithFrame:CGRectMake(Kboder + CGRectGetMaxX(btnItem5.frame), CGRectGetMaxY(btnItem1.frame)+40, btnWH, btnWH)];
    [btnItem6 setBackgroundImage:[UIImage imageNamed:@"6"] forState:UIControlStateNormal];
    [btnItem6 addTarget:self action:@selector(btnItem6Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnItem6];
    
    UILabel *LBItme6 = [[UILabel alloc] initWithFrame:CGRectMake(Kboder + CGRectGetMaxX(btnItem5.frame), CGRectGetMaxY(btnItem4.frame), btnWH, lbWH)];
    LBItme6.text = @"联系艾检";//@"联系艾康";
    LBItme6.font = [UIFont systemFontOfSize:14];
    LBItme6.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:LBItme6];
    
}

- (void)createFooterView
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, KScreenHeight - 100, KScreenWidth, 100)];
    [self.view addSubview:footerView];
    
    footerImg = [[UIImageView alloc] initWithFrame:CGRectMake(40, 20, KScreenWidth - 40*2, 80)];
    footerImg.image = [UIImage imageNamed:@"quan"];
    footerImg.userInteractionEnabled = YES;
    [footerView addSubview:footerImg];
    
    UIImageView *bluetoohImg = [[UIImageView alloc] initWithFrame:CGRectMake((KScreenWidth - 40*2)/2 -15, 5, 30, footerImg.frame.size.height -5)];
    bluetoohImg.image = [UIImage imageNamed:@"xueyaji"];
    bluetoohImg.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(popView)];
    [bluetoohImg addGestureRecognizer:singleTap];
    
    [footerImg addSubview:bluetoohImg];
}

- (void)createPopView
{
    CGFloat Kborder = (KScreenWidth - 80*2)/4;
    
    UIView *popView = [[UIView alloc] initWithFrame:CGRectMake(0, KScreenHeight -300, KScreenWidth, 300)];
    
    UITapGestureRecognizer * popViewSingleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(footerbluetoothClick)];
    [popView addGestureRecognizer:popViewSingleTap];
    
    NSDictionary *dict = [ArchiveAccessFile UnarchivedSuccessFileName:Klog];
    if (dict == nil) {
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        
        UIImageView *tipImg = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, KScreenWidth - 40, 30)];
        tipImg.image = [UIImage imageNamed:@"2048_03"];
        tipImg.tintColor = [UIColor whiteColor];
        [popView addSubview:tipImg];
        
        UIImageView *jiantouImg = [[UIImageView alloc] initWithFrame:CGRectMake((KScreenWidth - 60)/2, 100, 60, 80)];
        jiantouImg.image = [UIImage imageNamed:@"2048_07"];
        [popView addSubview:jiantouImg];

        NSDictionary *dict = @{@"KEY" :@"0"};
        [ArchiveAccessFile ArchiveSuccessData:dict fileName:Klog];
        
    }
    else
    {
        
    }

    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake((KScreenWidth - 80*2)/4, 200, 80, 40)];
    [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setImage:[UIImage imageNamed:@"icon2"] forState:UIControlStateNormal];
    leftBtn.imageEdgeInsets = UIEdgeInsetsMake(6, 0, 6, 50);
    
    [leftBtn setTitle:@"连接设备" forState:UIControlStateNormal];
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    leftBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -25, 0, 0);
    leftBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [popView addSubview:leftBtn];
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(leftBtn.frame) + Kborder *2, 200, 80, 40)];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setImage:[UIImage imageNamed:@"icon1"] forState:UIControlStateNormal];
    rightBtn.imageEdgeInsets = UIEdgeInsetsMake(5, 0, 5, 50);
    [rightBtn setTitle:@"手动输入" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    rightBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
    [popView addSubview:rightBtn];
    
    UIImageView *footerbluetoothImg = [[UIImageView alloc] initWithFrame:CGRectMake(KScreenWidth/2 -15, 225, 30, 80-5)];
    footerbluetoothImg.image = [UIImage imageNamed:@"xueyaji"];
    footerbluetoothImg.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(footerbluetoothClick)];
    [footerbluetoothImg addGestureRecognizer:singleTap];
    [popView addSubview:footerbluetoothImg];
    
    [BMPopView shareInstance].canDisMiss = YES;
    [[BMPopView shareInstance] showWithContentView:popView withAnimation:BMPopViewAnimationShowFromBottom delegate:self ];
}

- (void)btnItem1Click
{
    ZWLog(@"数据列表");
    DataListViewController *datalistVC = [[DataListViewController alloc] init];
    [self.navigationController pushViewController:datalistVC animated:YES];
}

- (void)btnItem2Click
{
    ZWLog(@"血糖管理");
    BloodGlucoseManageController *bloodVC = [[BloodGlucoseManageController alloc] init];
    [self.navigationController pushViewController:bloodVC animated:YES];
}

- (void)btnItem3Click
{
    ZWLog(@"用户管理");
    
    UserManageController *usr = [[UserManageController alloc]init];
    [self.navigationController pushViewController:usr animated:YES];

}

- (void)btnItem4Click
{
    ZWLog(@"艾康资讯");
    
    AiKangNewsViewController *aikangnews = [[AiKangNewsViewController alloc]init];
    [self.navigationController pushViewController:aikangnews animated:YES];
}

- (void)btnItem5Click
{
    ZWLog(@"艾康知道");
    
    KnowledgeViewController *knowledge = [[KnowledgeViewController alloc]init];
    [self.navigationController pushViewController:knowledge animated:YES];
}

- (void)btnItem6Click
{
    ZWLog(@"联系艾康");
    
    ConnectAikangController *connectAikang = [[ConnectAikangController alloc]init];
    [self.navigationController pushViewController:connectAikang animated:YES];
}

- (void)jump
{
    ZWLog(@"图像");
    
    PersonalViewController *personnal = [[PersonalViewController alloc]init];
    [self.navigationController pushViewController:personnal animated:YES];
}

- (void)popView
{
    ZWLog(@"弹出视图");
    [self createPopView];
}

- (void)leftBtnClick
{
    [[BMPopView shareInstance] dismiss];
    ConnectDeviceViewController *connetVC = [[ConnectDeviceViewController alloc] init];
    [self.navigationController pushViewController:connetVC animated:YES];
}

- (void)rightBtnClick
{
    [[BMPopView shareInstance] dismiss];
    BloodGlucosemeasurementController *dataChangeVC = [[BloodGlucosemeasurementController alloc] init];
    [self.navigationController pushViewController:dataChangeVC animated:YES];
}

- (void)footerbluetoothClick
{
    [[BMPopView shareInstance] dismiss];
}


@end
