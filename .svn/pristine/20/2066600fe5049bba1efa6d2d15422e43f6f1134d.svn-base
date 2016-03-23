//
//  SinaViewController.m
//  ACONApp
//
//  Created by suhe on 14/11/26.
//  Copyright (c) 2014年 zw. All rights reserved.
//
#define Kpadding 10

#import <ShareSDK/ShareSDK.h>
#import <Parse/Parse.h>
#import "SinaViewController.h"
#import "PersonalViewController.h"
@interface SinaViewController ()
{
    UILabel* _name;
    UIImageView* _icon;
    BOOL _isLogin;
}
@end

@implementation SinaViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注销" style:UIBarButtonItemStyleBordered target:self action:@selector(logoutButtonClickHandler:)];
    }
    return self;
}
//注销登录
- (void)logoutButtonClickHandler:(id)sender
{
    [ShareSDK cancelAuthWithType:ShareTypeSinaWeibo];
    
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = KBackgroundColor;
    self.edgesForExtendedLayout = NO;
    self.title = @"新浪登录";
    [self addHeaderView];
    [self addBtn];
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
    _icon = iconImage;
    [backgroundView addSubview:iconImage];
    
    UILabel* nameLabel = [[UILabel alloc] init];
    CGFloat nameLabelX = CGRectGetMaxX(iconImage.frame) + Kpadding;
    CGFloat nameLabelY = iconImageY;
    CGFloat nameLabelW = 200;
    CGFloat nameLabelH = iconImageH;
    nameLabel.frame = CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    nameLabel.contentMode = UIViewContentModeCenter;
    nameLabel.text = @"未登录";
    _name = nameLabel;
    [backgroundView addSubview:nameLabel];
    
    UIButton* changeAccontBtn = [[UIButton alloc] init];
    CGFloat changeAccontBtnW = 80;
    CGFloat changeAccontBtnX = KScreenWidth - Kpadding - changeAccontBtnW + 7;
    CGFloat changeAccontBtnY = iconImageY;
    CGFloat changeAccontBtnH = iconImageH;
    changeAccontBtn.frame = CGRectMake(changeAccontBtnX, changeAccontBtnY, changeAccontBtnW, changeAccontBtnH);
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"切换账号" attributes:@{NSForegroundColorAttributeName : [UIColor grayColor],NSFontAttributeName : [UIFont systemFontOfSize:15]}];
    [changeAccontBtn setAttributedTitle:str forState:UIControlStateNormal];
    str = [[NSAttributedString alloc] initWithString:@"切换账号" attributes:@{NSForegroundColorAttributeName : [[UIColor alloc] initWithWhite:0.7 alpha:0.8],NSFontAttributeName : [UIFont systemFontOfSize:15]}];
    [changeAccontBtn setTitle:@"切换账号" forState:UIControlStateNormal];
    [changeAccontBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [changeAccontBtn addTarget:self action:@selector(changeAccontAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [backgroundView addSubview:changeAccontBtn];
}

//切换账号按钮
- (void)changeAccontAction:(UIButton *)btn
{
    [ShareSDK hideStatusbarMessage];
    [ShareSDK authWithType:ShareTypeSinaWeibo options:nil result:^(SSAuthState state, id<ICMErrorInfo> error) {
//        if (state == SSAuthStateSuccess) {
//            [self getUserInfoInBackGround];
//        }else if (state == 2){
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"服务器忙！！！" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
//            [alertView show];
//        }else {
//            [self.navigationController popViewControllerAnimated:YES];
//        }
    }];
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
    [confirmBtn addTarget:self action:@selector(confirmClick:) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)confirmClick:(UIButton *)btn
{
    if (_isLogin) {
        //登陆成功跳转到个人中心；
        PersonalViewController *personal = [[PersonalViewController alloc] init];
        [self.navigationController pushViewController:personal animated:YES];
    }else{
        [self getUserInfoInBackGround];
    }
}
- (void)getUserInfoInBackGround
{
    if ([ShareSDK hasAuthorizedWithType:ShareTypeSinaWeibo]) {
        //登陆成功跳转到个人中心；
        PersonalViewController *personal = [[PersonalViewController alloc] init];
        [self.navigationController pushViewController:personal animated:YES];
    }else{
    [ShareSDK getUserInfoWithType:ShareTypeSinaWeibo authOptions:nil result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
        if (result)
        {
            _isLogin = YES;
            NSURL *imageUrl = [NSURL URLWithString:[userInfo profileImage]];
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
            _icon.image = image;
            _name.text = [userInfo nickname];
            PFQuery *query = [PFQuery queryWithClassName:@"UserInfo"];
            [query whereKey:@"uid" equalTo:[userInfo uid]];
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if ([objects count] == 0)
                {
                    PFObject *newUser = [PFObject objectWithClassName:@"UserInfo"];
                    [newUser setObject:[userInfo uid] forKey:@"uid"];
                    [newUser setObject:[userInfo nickname] forKey:@"name"];
                    [newUser setObject:[userInfo profileImage] forKey:@"icon"];
                    [newUser saveInBackground];
#warning 在这里，按产品需要可将用户的信息发送至服务器，保存在数据库。或者让用户绑定注册
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Hello" message:@"欢迎注册" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
                    [alertView show];
                }else{
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Hello" message:@"欢迎回来" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
                    [alertView show];
                }
            }];
            //登陆成功跳转到个人中心；
            PersonalViewController *personal = [[PersonalViewController alloc] init];
            [self.navigationController pushViewController:personal animated:YES];
        }
        }];
    }
}


@end
