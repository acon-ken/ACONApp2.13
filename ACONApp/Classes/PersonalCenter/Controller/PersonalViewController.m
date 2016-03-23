//
//  PersonalViewController.m
//  ACONApp
//
//  Created by suhe on 14/11/25.
//  Copyright (c) 2014年 zw. All rights reserved.
//

#import "PersonalViewController.h"
#import "ZJSwitch.h"

#import "PerfectPersonDataController.h"
#import "ChangepasswordVC.h"
#import "AboutAikangViewController.h"
#import "FeedBackViewController.h"
#import "SysteminformationViewController.h"


#import "GTMBase64.h"

#import "LoginViewController.h"

#import "LoginInfoModel.h"
#import "LoginInfoData.h"
#import "UserManageModel.h"
#import "UserManageData.h"
#import "BMPopView.h"
#import "UpdateVersionData.h"
#import "UpdateVersionModel.h"

#import <ShareSDK/ShareSDK.h>
#import "AppDelegate.h"

@interface PersonalViewController ()<UIActionSheetDelegate,BMPopViewDelegate>
{
    ZJSwitch *switch0;//滑动开关
    UILabel *subLb;
    UIButton *Midview3Btn;
    UIView *headview;
    
    UILabel *nameLB;
    UILabel *idLB;
    UILabel *PhoneLB;
    UIImageView *leftimage;


    NSString *namestr;
    NSString *loginnamestr;
    NSString *phonestr;
    NSString *portimaegstr;
    NSString *bloodstr;
    NSString *sexstr;
    NSString *heightstr;
    NSString *weightstr;
    NSString *birthdaystr;
    NSString *dataidentifystr;
    
    
    LoginInfoModel *userinfo;
    
    NSString *imageString;
    
    int allow;
    
    UIView *_updateView;
    
    UpdateVersionModel *versionModel;
    
    int shareStatus; //分享平台类型
    UITextView *inputTV;//分享视图的输入筐
    UILabel *subTitleLb; //分享界面的副标题
    UILabel *contentLb; //分享界面的内容label
    
    
    BOOL isshangchuangtouxiang; //YES:不走获取用户信息接口 NO:走获取用户信息接口
    
//    NSInteger isShow; //临时的参数-限制是否显示分享平台（ isShow＝1 只显示web分享，isShow ＝2 显示全部分享）//测试
}
@end

@implementation PersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //isShow = 2;

    
    helper = [[WebServices alloc] initWithDelegate:self];
    userinfo = [SaveUserInfo loadCustomObjectWithKey];
    
    self.title = @"我的";
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"beijin"]];
    self.edgesForExtendedLayout = NO;
    self.navigationController.navigationBarHidden = NO;
    
    allow=1;
    
    //给导航栏加一个返回按钮
    UIButton *leftbackBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [leftbackBtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
    [leftbackBtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateSelected];
    [leftbackBtn  addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    leftbackBtn.selected = YES;
    
    UIBarButtonItem *leftButtonitem  = [[UIBarButtonItem alloc] initWithCustomView:leftbackBtn];
    self.navigationItem.leftBarButtonItem=leftButtonitem;
    
    [self CreateHeadView];
    [self CreateMidView];
    [self CreateFootView];
    
}

-(void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    
    userinfo = [SaveUserInfo loadCustomObjectWithKey];
    
    BOOL isHiddenSwithch   =[[NSUserDefaults standardUserDefaults]boolForKey:KScreenPesonViewSwitchIsOnOrHidden];

    [switch0 setOn: isHiddenSwithch];

    if (isshangchuangtouxiang ==NO)
    {
           [self postUserinfomation];
    }
    
 

  //  [self postSetAllow];
}

-(void)CreateHeadView{

    headview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 80)];
    headview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"baise"]];
    
    UIButton *HeadBtn = [[UIButton alloc] init];
    HeadBtn.frame = CGRectMake(70, 0, headview.frame.size.width-70, 80);
    [HeadBtn  addTarget:self action:@selector(HeadBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    HeadBtn.selected = YES;
    
    leftimage = [[UIImageView alloc]initWithFrame:CGRectMake(15, 12, 65,65)];
    leftimage.highlighted = YES;// flag
    [leftimage sd_setImageWithURL:[NSURL URLWithString:userinfo.data.portraitURL] placeholderImage:[UIImage imageNamed:@"touxiang"]];
   
    UIButton *imageBtn = [[UIButton alloc] init];
    imageBtn.frame = leftimage.frame;
    [imageBtn  addTarget:self action:@selector(imageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    imageBtn.selected = YES;
    
    NSString *loginnamestr = [NSString stringWithFormat:@"%@",userinfo.data.loginName];
//     NSString *namefuhaostr = [NSString stringWithFormat:@"(%@)",userinfo.data.userName];
//    NSString *usenamestr = [loginnamestr stringByAppendingString:namefuhaostr];
    
    nameLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(leftimage.frame)+8, leftimage.frame.origin.y+3,KScreenWidth, 30)];
    nameLB.text = loginnamestr;
    nameLB.textColor = [UIColor blackColor];
    nameLB.font = [UIFont fontWithName:@"Helvetica" size:18];
    nameLB.textAlignment=NSTextAlignmentLeft;
   // [nameLB sizeToFit];
    
    PhoneLB = [[UILabel alloc]initWithFrame:CGRectMake(nameLB.frame.origin.x, leftimage.frame.origin.y+40, KScreenWidth, 30)];
    PhoneLB.text = userinfo.data.phone;
    PhoneLB.textColor = [UIColor darkGrayColor];
    PhoneLB.font = [UIFont fontWithName:@"Helvetica" size:14];
    PhoneLB.textAlignment=NSTextAlignmentLeft;
    [PhoneLB sizeToFit];
    
    
    
    UIImageView *rightimage = [[UIImageView alloc]initWithFrame:CGRectMake(KScreenWidth-23, 40, 8,11)];
    rightimage.highlighted = YES;// flag
    rightimage.image = [UIImage imageNamed:@"xiangyou"];
    
    [headview addSubview:leftimage];
    [headview addSubview:imageBtn];
    [headview addSubview:HeadBtn];
    [headview addSubview:nameLB];
    //[headview addSubview:idLB];
    [headview addSubview:PhoneLB];
    [headview addSubview:rightimage];
    [self.view addSubview:headview];


}

-(void)CreateMidView{
    
    UIButton *Midview1Btn = [[UIButton alloc] initWithFrame:CGRectMake(0, headview.frame.origin.y+95, KScreenWidth, 40)];
    Midview1Btn.backgroundColor = [UIColor whiteColor];
    [Midview1Btn  addTarget:self action:@selector(Midview1BtnAction:) forControlEvents:UIControlEventTouchUpInside];
    Midview1Btn.selected = YES;
    
    UILabel *systemInformationLB = [[UILabel alloc]initWithFrame:CGRectMake(15,10, 70, 30)];
    systemInformationLB.text=@"系统消息";
    systemInformationLB.textColor = [UIColor blackColor];
    systemInformationLB.font = [UIFont fontWithName:@"Helvetica" size:18];
    systemInformationLB.textAlignment=NSTextAlignmentCenter;
    [systemInformationLB sizeToFit];
    
    //添加向右箭头
    UIImageView *rightimage1 = [[UIImageView alloc]initWithFrame:CGRectMake(KScreenWidth-23, 16, 8,11)];
    rightimage1.highlighted = YES;// flag
    rightimage1.image = [UIImage imageNamed:@"xiangyou"];

    
    //添加分割线
    UIImageView *Line1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, Midview1Btn.frame.origin.y+40, KScreenWidth,1 )];
    Line1.highlighted = YES;// flag
    Line1.image = [UIImage imageNamed:@"xian"];

    
    UIButton *Midview2Btn = [[UIButton alloc] initWithFrame:CGRectMake(0, Line1.frame.origin.y+1, KScreenWidth, 40)];
    Midview2Btn.backgroundColor = [UIColor whiteColor];
    Midview2Btn.selected = YES;

    
    UILabel *hiddenSetLB = [[UILabel alloc]initWithFrame:CGRectMake(15,10, 70, 30)];
    hiddenSetLB.text=@"隐藏设置";
    hiddenSetLB.textColor = [UIColor blackColor];
    hiddenSetLB.font = [UIFont fontWithName:@"Helvetica" size:18];
    hiddenSetLB.textAlignment=NSTextAlignmentCenter;
    [hiddenSetLB sizeToFit];
    
    subLb = [[UILabel alloc]initWithFrame:CGRectMake(hiddenSetLB.frame.origin.x+100,13, 70, 30)];
    subLb.text=@"关闭后将不会被搜索到";
    subLb.textColor = [UIColor darkGrayColor];
    subLb.font = [UIFont fontWithName:@"Helvetica" size:14];
    subLb.textAlignment=NSTextAlignmentCenter;
    subLb.hidden = YES;
    [subLb sizeToFit];

    //初始化滑动开关
    switch0 = [[ZJSwitch alloc] initWithFrame:CGRectMake(KScreenWidth-63, 5,50,16)];
    switch0.backgroundColor = [UIColor clearColor];
    [switch0 addTarget:self action:@selector(handleSwitchEvent:) forControlEvents:UIControlEventValueChanged];
   
    

    //添加分割线
    UIImageView *Line2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, Midview2Btn.frame.origin.y+40, KScreenWidth,1 )];
    Line2.highlighted = YES;// flag
    Line2.image = [UIImage imageNamed:@"xian"];

    
    Midview3Btn = [[UIButton alloc] initWithFrame:CGRectMake(0, Line2.frame.origin.y+1, KScreenWidth, 40)];
    Midview3Btn.backgroundColor = [UIColor whiteColor];
    [Midview3Btn  addTarget:self action:@selector(Midview3BtnAction:) forControlEvents:UIControlEventTouchUpInside];
    Midview3Btn.selected = YES;
    
    
    UILabel *changePasswordLB = [[UILabel alloc]initWithFrame:CGRectMake(15,10, 70, 30)];
    changePasswordLB.text=@"修改密码";
    changePasswordLB.textColor = [UIColor blackColor];
    changePasswordLB.font = [UIFont fontWithName:@"Helvetica" size:18];
    changePasswordLB.textAlignment=NSTextAlignmentCenter;
    [changePasswordLB sizeToFit];
    
    //添加向右箭头
    UIImageView *rightimage3 = [[UIImageView alloc]initWithFrame:CGRectMake(KScreenWidth-23, 16, 8,11)];
    rightimage3.highlighted = YES;// flag
    rightimage3.image = [UIImage imageNamed:@"xiangyou"];


    [Midview1Btn addSubview:systemInformationLB];
    [Midview1Btn addSubview:rightimage1];
    [Midview2Btn addSubview:hiddenSetLB];
    [Midview2Btn addSubview:switch0];
    [Midview2Btn addSubview:subLb];
    [Midview3Btn addSubview:changePasswordLB];
    [Midview3Btn addSubview:rightimage3];

    [self.view addSubview:Midview1Btn];
    [self.view addSubview:Midview2Btn];
    [self.view addSubview:Midview3Btn];
    [self.view addSubview:Line1];
    [self.view addSubview:Line2];
   
}

-(void)CreateFootView{

    UIButton *FootView1Btn = [[UIButton alloc] initWithFrame:CGRectMake(0, Midview3Btn.frame.origin.y+55, KScreenWidth, 50)];
    FootView1Btn.backgroundColor = [UIColor whiteColor];
    [FootView1Btn  addTarget:self action:@selector(FootView1BtnAction:) forControlEvents:UIControlEventTouchUpInside];
    FootView1Btn.selected = YES;
    
    
    ////关于艾康按钮
    UILabel *AboutAikangLB = [[UILabel alloc]initWithFrame:CGRectMake(15,10, 70, 30)];
    AboutAikangLB.text=@"关于艾检";//@"关于艾康";
    AboutAikangLB.textColor = [UIColor blackColor];
    AboutAikangLB.font = [UIFont fontWithName:@"Helvetica" size:18];
    AboutAikangLB.textAlignment=NSTextAlignmentCenter;
    [AboutAikangLB sizeToFit];
    
    //添加向右箭头
    UIImageView *rightimage1 = [[UIImageView alloc]initWithFrame:CGRectMake(KScreenWidth-23, 16, 8,11)];
    rightimage1.highlighted = YES;// flag
    rightimage1.image = [UIImage imageNamed:@"xiangyou"];
    
    
    //添加分割线
    UIImageView *Line1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, FootView1Btn.frame.origin.y+40, KScreenWidth,1 )];
    Line1.highlighted = YES;// flag
    Line1.image = [UIImage imageNamed:@"xian"];
    
    ////意见反馈按钮
    UIButton *FootView2Btn = [[UIButton alloc] initWithFrame:CGRectMake(0, Line1.frame.origin.y+1, KScreenWidth, 40)];
    FootView2Btn.backgroundColor = [UIColor whiteColor];
    [FootView2Btn  addTarget:self action:@selector(FootView2BtnAction:) forControlEvents:UIControlEventTouchUpInside];
    FootView2Btn.selected = YES;
    
    UILabel *FeedbackLB = [[UILabel alloc]initWithFrame:CGRectMake(15,10, 70, 30)];
    FeedbackLB.text=@"意见反馈";
    FeedbackLB.textColor = [UIColor blackColor];
    FeedbackLB.font = [UIFont fontWithName:@"Helvetica" size:18];
    FeedbackLB.textAlignment=NSTextAlignmentCenter;
    [FeedbackLB sizeToFit];
    
    //添加向右箭头
    UIImageView *rightimage2 = [[UIImageView alloc]initWithFrame:CGRectMake(KScreenWidth-23, 16, 8,11)];
    rightimage2.highlighted = YES;// flag
    rightimage2.image = [UIImage imageNamed:@"xiangyou"];
    
    
    
    //添加分割线
    UIImageView *Line2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, FootView2Btn.frame.origin.y+40, KScreenWidth,1 )];
    Line2.highlighted = YES;// flag
    Line2.image = [UIImage imageNamed:@"xian"];
    
//    ////检查更新按钮
//    UIButton *FootView3Btn = [[UIButton alloc] initWithFrame:CGRectMake(0, Line2.frame.origin.y+1, KScreenWidth, 40)];
//    FootView3Btn.backgroundColor = [UIColor whiteColor];
//    [FootView3Btn  addTarget:self action:@selector(FootView3BtnAction:) forControlEvents:UIControlEventTouchUpInside];
//    FootView3Btn.selected = YES;
//    
//    
//    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
//    NSString *locationVersion = [NSString stringWithFormat:@"V%@",version];
//    
//    UILabel *CheckupdatesLB = [[UILabel alloc]initWithFrame:CGRectMake(15,10, 70, 30)];
//    CheckupdatesLB.text= [NSString stringWithFormat:@"检查更新%@",locationVersion]; //@"检查更新V1.0.0";
//    CheckupdatesLB.textColor = [UIColor blackColor];
//    CheckupdatesLB.font = [UIFont fontWithName:@"Helvetica" size:18];
//    CheckupdatesLB.textAlignment=NSTextAlignmentCenter;
//    [CheckupdatesLB sizeToFit];
//    
//    //添加向右箭头
//    UIImageView *rightimage3 = [[UIImageView alloc]initWithFrame:CGRectMake(KScreenWidth-23, 16, 8,11)];
//    rightimage3.highlighted = YES;// flag
//    rightimage3.image = [UIImage imageNamed:@"xiangyou"];
    
    
    
    //添加分割线
    UIImageView *Line3 = [[UIImageView alloc]initWithFrame:CGRectMake(0, FootView2Btn.frame.origin.y+40, KScreenWidth,1 )];
    Line3.highlighted = YES;// flag
    Line3.image = [UIImage imageNamed:@"xian"];
    
    
    ////分享按钮
    UIButton *FootView4Btn = [[UIButton alloc] initWithFrame:CGRectMake(0, Line3.frame.origin.y+1, KScreenWidth, 40)];
    FootView4Btn.backgroundColor = [UIColor whiteColor];
    [FootView4Btn  addTarget:self action:@selector(FootView4BtnAction:) forControlEvents:UIControlEventTouchUpInside];
    FootView4Btn.selected = YES;
    
    
    UILabel *ShareLB = [[UILabel alloc]initWithFrame:CGRectMake(15,10, 70, 30)];
    ShareLB.text=@"软件分享";
    ShareLB.textColor = [UIColor blackColor];
    ShareLB.font = [UIFont fontWithName:@"Helvetica" size:18];
    ShareLB.textAlignment=NSTextAlignmentCenter;
    [ShareLB sizeToFit];
    
    //添加向右箭头
    UIImageView *rightimage4 = [[UIImageView alloc]initWithFrame:CGRectMake(KScreenWidth-23, 16, 8,11)];
    rightimage4.highlighted = YES;// flag
    rightimage4.image = [UIImage imageNamed:@"xiangyou"];
    
    
    //退出帐号按钮
    UIButton *OutaccountBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, FootView4Btn.frame.origin.y+80, KScreenWidth-40, 35)];
    [OutaccountBtn setBackgroundImage:[UIImage imageNamed:@"queding"] forState:UIControlStateNormal];
    [OutaccountBtn setTitle:@"退出帐号" forState:UIControlStateNormal];
    [OutaccountBtn addTarget:self action:@selector(OutaccountBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    OutaccountBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [OutaccountBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    OutaccountBtn.selected = YES;
    [self.view addSubview:OutaccountBtn];


    [FootView1Btn addSubview:AboutAikangLB];
    [FootView1Btn addSubview:rightimage1];
    [FootView2Btn addSubview:FeedbackLB];
    [FootView2Btn addSubview:rightimage2];
   // [FootView3Btn addSubview:CheckupdatesLB];
   // [FootView3Btn addSubview:rightimage3];
    [FootView4Btn addSubview:ShareLB];
    [FootView4Btn addSubview:rightimage4];
    
    [self.view addSubview:FootView1Btn];
    [self.view addSubview:FootView2Btn];
  //  [self.view addSubview:FootView3Btn];
    [self.view addSubview:FootView4Btn];
    [self.view addSubview:Line1];
    [self.view addSubview:Line2];
    [self.view addSubview:Line3];

}

//获取用户信息
-(void)postUserinfomation{
    
    [MBProgressHUD showMessage:@"加载中..." toView:self.view];//显示动画
    WebServices *helper1 = [[WebServices alloc] init];
    
    LoginInfoModel *model = [SaveUserInfo loadCustomObjectWithKey];
    LoginInfoData *data = model.data;
    
    __weak PersonalViewController *wself = self;
    NSMutableArray *arr=[NSMutableArray array];

    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:data.dataIdentifier,@"u_id", nil]];

    
    NSString *soapMsg = [SoapHelper arrayToDefaultSoapMessage:arr methodName:GetUserInfoMethodName];
    //执行同步并取得结果
   
     [helper1 asyncServiceUrl:UserInfoWebServiceUrl nameSpace:defaultWebServiceNameSpace methodName:GetUserInfoMethodName soapMessage:soapMsg withBlock:^(NSString *json, NSError *error) {
          [MBProgressHUD hideHUDForView:wself.view animated:YES];//移除动画
         if(![json isEqualToString:@""])
         {
             //返回的json字符串转换成NSDictionary
             NSData* jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
             NSMutableDictionary *resultsDictionary = [jsonData objectFromJSONData];
             
             UserManageModel *info = [[UserManageModel alloc] initWithDictionary:resultsDictionary];
             if (info.status == 0) {
                 
                 namestr = info.data.loginName;
                 loginnamestr = info.data.userName;
                 if ([info.data.phone isEqualToString:@""]) {
                     phonestr =  userinfo.data.phone;
                 }else{
                     phonestr =  info.data.phone;
                 }
                 portimaegstr = info.data.portraitURL; //注 获取用户信息接口没返回头像参数 ，只能通过登录去取
                 
                 if ([info.data.bloodType isEqualToString:@""]) {
                     bloodstr = userinfo.data.bloodType;
                 }else{
                     bloodstr = info.data.bloodType;
                 }
                 
                 
                 //将用户信息接口里的性别对象类型转换成字符串存起来
                 NSString *sexStr = [NSString stringWithFormat:@"%0.1f",info.data.sex];
                 if (sexStr==nil) {
                     sexStr=@"1";
                 }
                 sexstr = sexStr;
                 heightstr =info.data.height;
                 weightstr = info.data.weight;
                 birthdaystr = info.data.birthday;
                 dataidentifystr =  info.data.dataIdentifier;
                 
                 
                 [leftimage sd_setImageWithURL:[NSURL URLWithString:portimaegstr] placeholderImage:[UIImage imageNamed:@"touxiang"]];
                 
                 NSString *loginnamestr = [NSString stringWithFormat:@"%@",userinfo.data.loginName];
//                 NSString *namefuhaostr = [NSString stringWithFormat:@"(%@)",userinfo.data.userName];
//                 NSString *usenamestr = [loginnamestr stringByAppendingString:namefuhaostr];

                 nameLB.text = loginnamestr;
                PhoneLB.text = phonestr;
                 
             }
             else
             {
                 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:info.msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                 [alertView show];
             }
             
         }
         else
         {
             NSLog(@"网络异常！");
             UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"网络连接失败" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles: nil];
             [alertView show];
         }
         
        

     }];
    
    
    
}



//设置用户是否允许被关注
-(void)postSetAllow{
    WebServices *helper2 = [[WebServices alloc] init];
    
    LoginInfoModel *model = [SaveUserInfo loadCustomObjectWithKey];
    LoginInfoData *data = model.data;
    
    NSString *allowstatus = [NSString stringWithFormat:@"%d",allow];
    
    NSMutableArray *arr=[NSMutableArray array];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:data.dataIdentifier,@"u_id", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:allowstatus,@"userAllow", nil]];
    
    
    __weak PersonalViewController *wself = self;
    NSString *soapMsg = [SoapHelper arrayToDefaultSoapMessage:arr methodName:SetUserAllowFollowMethodName];
    //执行同步并取得结果
    [helper2 asyncServiceUrl:UserInfoWebServiceUrl nameSpace:defaultWebServiceNameSpace methodName:SetUserAllowFollowMethodName soapMessage:soapMsg withBlock:^(NSString *json, NSError *error) {
        
        if(![json isEqualToString:@""])
        {
            //返回的json字符串转换成NSDictionary
            NSData* jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
            NSMutableDictionary *resultsDictionary = [jsonData objectFromJSONData];
            
            UserModel *info = [[UserModel alloc] initWithDictionary:resultsDictionary];
            if (info.status == 0) {
                
                
            }
            else
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:info.msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alertView show];
            }
            
        }
        else
        {
            NSLog(@"网络异常！");
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"网络连接失败" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles: nil];
            [alertView show];
        }
        
    

    }];
    
    
}




-(void)imageBtnClick:(id)sender{
    NSLog(@"上传头像");
    
    UIAlertView *getHeadImage = [[UIAlertView alloc]initWithTitle:@"选取头像" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拍摄照片",@"从相册中选", nil];
    getHeadImage.tag = 2001;
    [getHeadImage show];
}

/// 用户头像来源/是否退出登录状态
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (2000 == alertView.tag) {//**< 判断是哪个提示框 2000退出提示 2001头像选择提示  */
        if(1 == buttonIndex)
        {
            return;
        }
    }
    switch (buttonIndex) {
        case 2://**< 从相册中选 */
        {
            NSLog(@"从相册中选");
            UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                //pickerImage.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
                //                pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
                pickerImage.mediaTypes = [[NSArray alloc] initWithObjects:(NSString*)kUTTypeImage, nil];
            }
            pickerImage.delegate = self;
            pickerImage.allowsEditing = YES;
            [self presentViewController:pickerImage animated:YES completion:^{
                
            }];
            
        }
            break;
        case 1://**< 拍照 */
        {
            NSLog(@"拍照");
            UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                pickerImage.sourceType = UIImagePickerControllerSourceTypeCamera;
                //pickerImage.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
                pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
                
            }
            pickerImage.delegate = self;
            pickerImage.allowsEditing = YES;
            [self presentViewController:pickerImage animated:YES completion:^{
                
            }];
            
        }
            break;
        case 0://**< 取消 */
        {
            NSLog(@"取消");
        }
            break;
        default:
            break;
    }
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    
    //获取媒体类型
    NSString* mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    //判断是静态图像还是视频
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        //获取用户编辑之后的图像
        UIImage* editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
        //将该图像保存到媒体库中
        if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
            //            UIImageWriteToSavedPhotosAlbum(editedImage, self, @selector(nilSymbol), NULL);
        }
        leftimage.image=editedImage;
        imageString = [GTMBase64 stringByEncodingData:UIImageJPEGRepresentation(leftimage.image, 0.5)];
         isshangchuangtouxiang = YES;
    }
    [picker dismissViewControllerAnimated:YES completion:^{
        isshangchuangtouxiang = NO;
        [self postUserImage];
    }];
    
}

#pragma mark - 上传头像
-(void)postUserImage{
   [MBProgressHUD showMessage:@"加载中..." toView:self.view];//显示动画
    WebServices *helper3 = [[WebServices alloc] init];

    
    LoginInfoModel *model = [SaveUserInfo loadCustomObjectWithKey];
    LoginInfoData *data = model.data;
    
    NSMutableArray *arr=[NSMutableArray array];

    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:data.dataIdentifier,@"u_id", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:imageString,@"fileStream", nil]];
    
    
     __weak PersonalViewController *wself = self;
    NSString *soapMsg = [SoapHelper arrayToDefaultSoapMessage:arr methodName:UploadingImgMethodName];
    
    //执行同步并取得结果
    [helper3 asyncServiceUrl:UserInfoWebServiceUrl nameSpace:defaultWebServiceNameSpace methodName:UploadingImgMethodName soapMessage:soapMsg withBlock:^(NSString *json, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:wself.view animated:YES];//移除动画
        if(![json isEqualToString:@""])
        {
            //返回的json字符串转换成NSDictionary
            NSData* jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
            NSMutableDictionary *resultsDictionary = [jsonData objectFromJSONData];
            
            UserModel *info = [[UserModel alloc] initWithDictionary:resultsDictionary];
            if (info.status == 0) {
                
                NSString *photostr  =  [resultsDictionary objectForKey:@"photo"];
                
                LoginInfoData *userinfodata = userinfo.data;

                userinfodata.portraitURL = photostr;
                userinfo.data = userinfodata;
                [SaveUserInfo saveCustomObject:userinfo];
                
                [leftimage sd_setImageWithURL:[NSURL URLWithString:userinfo.data.portraitURL] placeholderImage:[UIImage imageNamed:@"touxiang"]];
                
                
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:info.msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alertView show];
                
                
                
            }
            else
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:info.msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alertView show];
            }
            
        }
        else
        {
            NSLog(@"网络异常！");
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"网络连接失败" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles: nil];
            [alertView show];
        }
        
        

    }];
    


}


#pragma mark - Navigation BackButton Delegate
-(void)backClick:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - HeadView Button Delegate
-(void)HeadBtnClick:(id)sender{
    NSLog(@"点击HeadBtn");
    
    PerfectPersonDataController *perfectdata = [[PerfectPersonDataController alloc]init];
    perfectdata.userLoginname = namestr;
    perfectdata.username = loginnamestr;
    perfectdata.usersex = sexstr;
    perfectdata.useBloodTypestr = bloodstr;
    perfectdata.userPhonestr = phonestr;
    perfectdata.userheightstr =heightstr;
    perfectdata.userweightstr = weightstr;
    perfectdata.userbirthdaystr = birthdaystr;
    [self.navigationController pushViewController: perfectdata animated:YES];
    
    
}

#pragma mark - 系统消息按钮 Delegate
-(void)Midview1BtnAction:(id)sender{
    NSLog(@"点击系统消息");
    
    SysteminformationViewController *systeminformation = [[SysteminformationViewController alloc]init];
    [self.navigationController pushViewController:systeminformation animated:YES];
}

#pragma mark - 修改密码按钮 Delegate
-(void)Midview3BtnAction:(id)sender{
    NSLog(@"点击修改密码");
   
    ChangepasswordVC *changepassword = [[ChangepasswordVC alloc]init];
    [self.navigationController pushViewController:changepassword animated:YES];
}


#pragma mark - 关于艾康按钮 Delegate
-(void)FootView1BtnAction:(id)sender{
    NSLog(@"点击关于艾康");
    
    AboutAikangViewController *aboutaikang = [[AboutAikangViewController alloc]init];
    [self.navigationController pushViewController:aboutaikang animated:YES];
}


#pragma mark - 意见反馈按钮 Delegate
-(void)FootView2BtnAction:(id)sender{
    NSLog(@"点击意见反馈");
    
    FeedBackViewController *feedback = [[FeedBackViewController alloc]init];
    [self.navigationController pushViewController:feedback animated:YES];
}


#pragma mark - 检查更新按钮 Delegate
-(void)FootView3BtnAction:(id)sender{
    
    NSLog(@"点击检查更新");
    //[self updateVersionView];
    [self getUpdateVersion];
}

#pragma mark - 分享软件按钮 Delegate
-(void)FootView4BtnAction:(id)sender{
    
    
   UIView *shareview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth - 20, 250)];
    shareview.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    shareview.layer.cornerRadius = 5;
    shareview.layer.masksToBounds = YES;
    [BMPopView shareInstance].customFrame = NO ;
    
    //添加分割线
    UIImageView *headLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 30, KScreenWidth,1 )];
    headLine.highlighted = YES;// flag
    headLine.image = [UIImage imageNamed:@"xian"];

    
    UILabel *headshareLb = [[UILabel alloc]initWithFrame:CGRectMake(0,0, shareview.frame.size.width, 30)];
    headshareLb.text=@"分享到";
    headshareLb.textColor = [UIColor blackColor];
    headshareLb.font = [UIFont fontWithName:@"Helvetica" size:18];
    headshareLb.textAlignment=NSTextAlignmentCenter;
    

    //新浪微博按钮
    UIButton *sinaBtn = [[UIButton alloc] initWithFrame:CGRectMake((shareview.frame.size.width-20)/3-65, CGRectGetMaxY(headLine.frame)+15, 60, 60)];
    [sinaBtn setBackgroundImage:[UIImage imageNamed:@"xl"] forState:UIControlStateNormal];
    [sinaBtn addTarget:self action:@selector(shareListBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    sinaBtn.tag = 01111;
   
    UILabel *sinaLb = [[UILabel alloc] initWithFrame:CGRectMake(sinaBtn.frame.origin.x, CGRectGetMaxY(sinaBtn.frame), sinaBtn.frame.size.width, 20)];
    sinaLb.text = @"新浪微博";
    sinaLb.font = [UIFont systemFontOfSize:14];
    sinaLb.textAlignment = NSTextAlignmentCenter;

    
    //微信好友按钮
    UIButton *weixinFriendsBtn = [[UIButton alloc] initWithFrame:CGRectMake(30 + CGRectGetMaxX(sinaBtn.frame), sinaBtn.frame.origin.y, sinaBtn.frame.size.width, sinaBtn.frame.size.height)];
    [weixinFriendsBtn setBackgroundImage:[UIImage imageNamed:@"wx"] forState:UIControlStateNormal];
    [weixinFriendsBtn addTarget:self action:@selector(shareListBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    weixinFriendsBtn.tag = 01112;

    UILabel *weixinFriendsLb = [[UILabel alloc] initWithFrame:CGRectMake(weixinFriendsBtn.frame.origin.x, CGRectGetMaxY(weixinFriendsBtn.frame), weixinFriendsBtn.frame.size.width, sinaLb.frame.size.height)];
    weixinFriendsLb.text = @"微信好友";
    weixinFriendsLb.font = [UIFont systemFontOfSize:14];
    weixinFriendsLb.textAlignment = NSTextAlignmentCenter;


    //微信朋友圈按钮
    UIButton *weixinPeopleBtn = [[UIButton alloc] initWithFrame:CGRectMake(30 + CGRectGetMaxX(weixinFriendsBtn.frame), sinaBtn.frame.origin.y, sinaBtn.frame.size.width, sinaBtn.frame.size.height)];
    [weixinPeopleBtn setBackgroundImage:[UIImage imageNamed:@"pyq"] forState:UIControlStateNormal];
    [weixinPeopleBtn addTarget:self action:@selector(shareListBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    weixinPeopleBtn.tag = 01113;
    
    UILabel *weixinPeopleLb = [[UILabel alloc] initWithFrame:CGRectMake(weixinPeopleBtn.frame.origin.x-4, CGRectGetMaxY(weixinPeopleBtn.frame), sinaBtn.frame.size.width+10, sinaLb.frame.size.height)];
    weixinPeopleLb.text = @"微信朋友圈";
    weixinPeopleLb.font = [UIFont systemFontOfSize:14];
    weixinPeopleLb.textAlignment = NSTextAlignmentCenter;

    
    //QQ空间按钮
    UIButton *qqSpaceBtn = [[UIButton alloc] initWithFrame:CGRectMake(sinaBtn.frame.origin.x, CGRectGetMaxY(sinaBtn.frame)+40, sinaBtn.frame.size.width, sinaBtn.frame.size.height)];
    [qqSpaceBtn setBackgroundImage:[UIImage imageNamed:@"kongjian"] forState:UIControlStateNormal];
    [qqSpaceBtn addTarget:self action:@selector(shareListBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    qqSpaceBtn.tag = 01114;

    UILabel *qqSpaceLb = [[UILabel alloc] initWithFrame:CGRectMake(qqSpaceBtn.frame.origin.x, CGRectGetMaxY(qqSpaceBtn.frame), sinaBtn.frame.size.width, sinaLb.frame.size.height)];
    qqSpaceLb.text = @"QQ空间";
    qqSpaceLb.font = [UIFont systemFontOfSize:14];
    qqSpaceLb.textAlignment = NSTextAlignmentCenter;

    
    //QQ好友按钮
    UIButton *qqFriendsBtn = [[UIButton alloc] initWithFrame:CGRectMake(weixinFriendsBtn.frame.origin.x , qqSpaceBtn.frame.origin.y, sinaBtn.frame.size.width, sinaBtn.frame.size.height)];
    [qqFriendsBtn setBackgroundImage:[UIImage imageNamed:@"qq"] forState:UIControlStateNormal];
    [qqFriendsBtn addTarget:self action:@selector(shareListBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    qqFriendsBtn.tag = 01115;

    UILabel *qqFriendsLb = [[UILabel alloc] initWithFrame:CGRectMake(qqFriendsBtn.frame.origin.x, CGRectGetMaxY(qqFriendsBtn.frame), sinaBtn.frame.size.width, sinaLb.frame.size.height)];
    qqFriendsLb.text = @"QQ好友";
    qqFriendsLb.font = [UIFont systemFontOfSize:14];
    qqFriendsLb.textAlignment = NSTextAlignmentCenter;

    
    //腾讯微博按钮
    UIButton *tencentWeiboBtn = [[UIButton alloc] initWithFrame:CGRectMake(weixinPeopleBtn.frame.origin.x, qqSpaceBtn.frame.origin.y, sinaBtn.frame.size.width, sinaBtn.frame.size.height)];
    [tencentWeiboBtn setBackgroundImage:[UIImage imageNamed:@"wb"] forState:UIControlStateNormal];
    [tencentWeiboBtn addTarget:self action:@selector(shareListBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    tencentWeiboBtn.tag = 01116;

    UILabel *tencentWeiboLb = [[UILabel alloc] initWithFrame:CGRectMake(tencentWeiboBtn.frame.origin.x, CGRectGetMaxY(tencentWeiboBtn.frame), sinaBtn.frame.size.width, sinaLb.frame.size.height)];
    tencentWeiboLb.text = @"腾讯微博";
    tencentWeiboLb.font = [UIFont systemFontOfSize:14];
    tencentWeiboLb.textAlignment = NSTextAlignmentCenter;


    
    [shareview addSubview:headshareLb];
    [shareview addSubview:headLine];
    
    if ([userinfo.data.userInfoIp isEqualToString:@"test"])
    {
        userinfo.data.userInfoIp = @"";
    }
    //isShow＝1 只显示web分享，isShow ＝2 显示全部分享
    if(![userinfo.data.userInfoIp isEqualToString:@""]){
    
    
        tencentWeiboBtn.frame = CGRectMake(30 + CGRectGetMaxX(sinaBtn.frame), sinaBtn.frame.origin.y, sinaBtn.frame.size.width, sinaBtn.frame.size.height);
        tencentWeiboLb.frame  = CGRectMake(tencentWeiboBtn.frame.origin.x, CGRectGetMaxY(tencentWeiboBtn.frame), tencentWeiboBtn.frame.size.width, sinaLb.frame.size.height);
        
        [shareview addSubview:sinaBtn];
        [shareview addSubview:sinaLb];
        [shareview addSubview:tencentWeiboBtn];
        [shareview addSubview:tencentWeiboLb];

        
    }else{
        
        tencentWeiboBtn.frame = CGRectMake(weixinPeopleBtn.frame.origin.x, qqSpaceBtn.frame.origin.y, sinaBtn.frame.size.width, sinaBtn.frame.size.height);
        tencentWeiboLb.frame = CGRectMake(tencentWeiboBtn.frame.origin.x, CGRectGetMaxY(tencentWeiboBtn.frame), sinaBtn.frame.size.width, sinaLb.frame.size.height);
        
        [shareview addSubview:sinaBtn];
        [shareview addSubview:sinaLb];
        [shareview addSubview:tencentWeiboBtn];
        [shareview addSubview:tencentWeiboLb];
        [shareview addSubview:weixinFriendsBtn];
        [shareview addSubview:weixinFriendsLb];
        [shareview addSubview:weixinPeopleBtn];
        [shareview addSubview:weixinPeopleLb];
        [shareview addSubview:qqSpaceBtn];
        [shareview addSubview:qqSpaceLb];
        [shareview addSubview:qqFriendsBtn];
        [shareview addSubview:qqFriendsLb];

    }

    
        [[BMPopView shareInstance] showWithContentView:shareview delegate:self];
    
}

-(void)shareListBtnClick:(UIButton *)sender{
   
    [[BMPopView shareInstance] dismiss];
    
    UIView *postView = [[UIView alloc]initWithFrame:CGRectMake(10, 64+10, KScreenWidth - 20, 250)];
    postView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    postView.layer.cornerRadius = 5;
    postView.layer.masksToBounds = YES;
    [BMPopView shareInstance].customFrame = YES ;
    
    
    //UIButton *cancerBtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 60,30)];
//    [cancerBtn setTitle:@"取消" forState:UIControlStateNormal];
//    [cancerBtn addTarget:self action:@selector(cancerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIButton *cancerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancerBtn.frame=CGRectMake(5, 5, 60,30);
    [cancerBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancerBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [cancerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancerBtn addTarget:self action:@selector(cancerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
   
//    UIButton *sharePostBtn = [[UIButton alloc] initWithFrame:CGRectMake(postView.frame.size.width-70, cancerBtn.frame.origin.y, cancerBtn.frame.size.width,cancerBtn.frame.size.height)];
//     [sharePostBtn setTitle:@"发布" forState:UIControlStateNormal];
//    [sharePostBtn addTarget:self action:@selector(PostshareContent:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *sharePostBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sharePostBtn.frame=CGRectMake(postView.frame.size.width-70, cancerBtn.frame.origin.y, cancerBtn.frame.size.width,cancerBtn.frame.size.height);
    [sharePostBtn setTitle:@"发布" forState:UIControlStateNormal];
    sharePostBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [sharePostBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [sharePostBtn addTarget:self action:@selector(PostshareContent:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *TitleLb = [[UILabel alloc]initWithFrame:CGRectMake(0,5, postView.frame.size.width, 30)];
    TitleLb.text=@"分享内容";
    TitleLb.textColor = [UIColor blackColor];
    TitleLb.font = [UIFont fontWithName:@"Helvetica" size:18];
    TitleLb.textAlignment=NSTextAlignmentCenter;
    
    //添加分割线
    UIImageView *headLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 40, KScreenWidth,1 )];
    headLine.highlighted = YES;// flag
    headLine.image = [UIImage imageNamed:@"xian"];
    
    UILabel *SoftnameLb = [[UILabel alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(headLine.frame)+10, postView.frame.size.width/3, 30)];
    SoftnameLb.text=@"艾检";
    SoftnameLb.textColor = [UIColor blackColor];
    SoftnameLb.font = [UIFont fontWithName:@"Helvetica" size:18];
    SoftnameLb.textAlignment=NSTextAlignmentCenter;
  
    
   UIImageView *softimage = [[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(SoftnameLb.frame), 70,70)];
    softimage.highlighted = YES;// flag
    softimage.image = [UIImage imageNamed:@"icon_zw"];
    
    subTitleLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(SoftnameLb.frame),SoftnameLb.frame.origin.y, postView.frame.size.width-SoftnameLb.frame.size.width+10, 20)];
    subTitleLb.text=@"您身边的糖尿病护理专家！";
    subTitleLb.textColor = [UIColor blackColor];
    subTitleLb.font = [UIFont fontWithName:@"Helvetica" size:17];
    subTitleLb.textAlignment=NSTextAlignmentLeft;

    
    contentLb = [[UILabel alloc]initWithFrame:CGRectMake(subTitleLb.frame.origin.x,CGRectGetMaxY(subTitleLb.frame), subTitleLb.frame.size.width-30, 140)];
    contentLb.text=@"仅需简单一步即可实现血糖数据的无线传输;\n您可以和家人一起管理您的血糖;\n还可以得到专业医师的远程医疗建议;\n除此之外,您还可以得到更多惊喜!";
    contentLb.textColor = [UIColor darkGrayColor];
    contentLb.font = [UIFont boldSystemFontOfSize:14.0f];
    contentLb.numberOfLines = 0;
    
    contentLb.lineBreakMode = 0;
    contentLb.textAlignment=NSTextAlignmentLeft;
    
   
    //拜访内容文本框
    inputTV = [[UITextView alloc]init];
    inputTV.frame = CGRectMake(10, CGRectGetMaxY(contentLb.frame),postView.frame.size.width-20,30);
    inputTV.layer.cornerRadius = 4.0f;
    inputTV.layer.masksToBounds = YES;
    inputTV.textColor = [UIColor darkGrayColor];
    inputTV.delegate=self;
    inputTV.layer.cornerRadius = 3.f;
    inputTV.layer.borderColor = [IWColor(228, 228, 228) CGColor];
    inputTV.layer.borderWidth = 1;

    
    

    
    [postView addSubview:cancerBtn];
    [postView addSubview:sharePostBtn];
    [postView addSubview:TitleLb];
    [postView addSubview:headLine];
    [postView addSubview:SoftnameLb];
    [postView addSubview:softimage];
    [postView addSubview:subTitleLb];
    [postView addSubview:contentLb];
    [postView addSubview:inputTV];
    
    
    if (sender.tag == 01111) {
        
        sharePostBtn.tag = sender.tag;
        shareStatus = 1; //新浪微博
        
        [[BMPopView shareInstance] showWithContentView:postView delegate:self];
        
    }else if (sender.tag == 01112){
        
         sharePostBtn.tag = sender.tag;
         shareStatus = 22; //微信好友
        [self PostshareContent:sender];
        
    }else if (sender.tag == 01113){
        
         sharePostBtn.tag = sender.tag;
         shareStatus = 23; //微信朋友圈
        [self PostshareContent:sender];
        
    }else if (sender.tag == 01114){

         sharePostBtn.tag = sender.tag;
         shareStatus = 6; //QQ空间
        [self PostshareContent:sender];
        
    }else if (sender.tag == 01115){
        
         sharePostBtn.tag = sender.tag;
         shareStatus = 24; //QQ好友
        [self PostshareContent:sender];
        
    }else if (sender.tag == 01116){
      
         sharePostBtn.tag = sender.tag;
         shareStatus = 2;  //腾讯微博
        
        [[BMPopView shareInstance] showWithContentView:postView delegate:self];
    }

}

-(void)cancerBtnClick{
 [[BMPopView shareInstance] dismiss];
}

//分享内容事件
-(void)PostshareContent:(UIButton *)sender{
 [[BMPopView shareInstance] dismiss];
    
    NSLog(@"%ld",(long)sender.tag);

    //  [ShareSDK removeNotificationWithName:SSN_USER_INFO_UPDATE target:self];
    
    //要分享的图片Logo
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"icon_zw" ofType:@"png"];
    NSString *shareContentstr = [NSString stringWithFormat:@"%@\n%@\n%@",subTitleLb.text,contentLb.text,inputTV.text];
    
    id<ISSContainer> container = [ShareSDK container];
    [container setIPhoneContainerWithViewController:self];
    
    
        //构造分享内容
        id<ISSContent> publishContent = [ShareSDK content:shareContentstr                                      defaultContent:@"测试一下"
                                                    image:[ShareSDK imageWithPath:imagePath]
                                                    title:(23 == shareStatus)?shareContentstr:@"        艾检"
                                                      url:@"http://www.aconlabs.com.cn/"
                                              description:shareContentstr
                                                mediaType:SSPublishContentMediaTypeNews];

    [ShareSDK shareContent:publishContent
                      type:shareStatus
               authOptions:nil
              shareOptions:nil
             statusBarTips:YES
                    result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                        if (state == SSPublishContentStateSuccess)
                        {
                            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"分享成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                            [alertView show];
                            
                        }
                        else if (state == SSPublishContentStateFail)
                        {
                            
                            NSLog(@"错误描述:%@",[error errorDescription]);
                            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"分享失败，请查看您是否安装客户端" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                            [alertView show];
                            
                            
                            
                            
                        }
                        
                    }];

}

#pragma mark - 退出程序按钮
-(void)OutaccountBtnAction:(id)sender{
    NSLog(@"点击退出");
    
    [ShareSDK cancelAuthWithType:ShareTypeSinaWeibo];
    [ShareSDK cancelAuthWithType:ShareTypeQQSpace];
    [ShareSDK cancelAuthWithType:ShareTypeTencentWeibo];
   
    

    
    [ArchiveAccessFile DeleteArchiveFileName:Klog];

    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    delegate.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:[[LoginViewController alloc]init]];
    
//    LoginViewController *login = [[LoginViewController alloc]init];
//    [self.navigationController pushViewController:login animated:YES];
}



#pragma mark - 隐私设置 Delegate
- (void)handleSwitchEvent:(id)sender
{
    if (switch0.isOn) {
        allow=0;
        subLb.hidden = NO;
        
    }
    else{
        allow = 1;
    
        subLb.hidden = YES;
    NSLog(@"111");
    }
    [self postSetAllow];

    [[NSUserDefaults standardUserDefaults]setBool:switch0.isOn forKey:KScreenPesonViewSwitchIsOnOrHidden];
    
}

- (void)updateVersionView
{
    ZWLog(@"软件更新");
    _updateView = [[UIView alloc] initWithFrame:CGRectMake(10, 100, KScreenWidth - 20, 200)];
    _updateView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    
    _updateView.layer.cornerRadius = 5;
    _updateView.layer.masksToBounds = YES;
    
    //发现新版本
    UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(0, KBorderH , KScreenWidth - 20, 40)];
    titleLB.text = @"发现新版本";
    titleLB.textAlignment = NSTextAlignmentCenter;
    titleLB.font = [UIFont systemFontOfSize:18];
    titleLB.textColor = [UIColor colorWithRed:34/255.0 green:177/255.0 blue:215/255.0 alpha:1];
    
    //内容
    UILabel *contentLB1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, KScreenWidth, 40)];
    contentLB1.text = versionModel.data.content; //@"以后新版本,使用更便捷,功能更强大.小伙伴们快快更新吧!";
    contentLB1.numberOfLines = 0;
    contentLB1.font = [UIFont systemFontOfSize:16];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:contentLB1.font,NSFontAttributeName, nil];
    CGRect rect = [contentLB1.text boundingRectWithSize:CGSizeMake(_updateView.frame.size.width - 20*2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    contentLB1.frame = CGRectMake(20, 60, rect.size.width, rect.size.height);
    
    
    [_updateView addSubview:titleLB];
    [_updateView addSubview:contentLB1];
    
    
    //两个按钮
    UIButton *latterBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 120, (_updateView.frame.size.width - 30) *0.5, 40)];
    [latterBtn setBackgroundImage:[UIImage imageNamed:@"green"] forState:UIControlStateNormal];
    [latterBtn setTitle:@"稍后再说" forState:UIControlStateNormal];
    [latterBtn addTarget:self action:@selector(latterBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat updateBtnW = CGRectGetMaxX(latterBtn.frame) +10;
    UIButton *updateBtn = [[UIButton alloc] initWithFrame:CGRectMake(updateBtnW, 120, (_updateView.frame.size.width - 30) *0.5, 40)];
    [updateBtn setBackgroundImage:[UIImage imageNamed:@"blue"] forState:UIControlStateNormal];
    [updateBtn setTitle:@"立即更新" forState:UIControlStateNormal];
    [updateBtn addTarget:self action:@selector(updateClick) forControlEvents:UIControlEventTouchUpInside];
    
    [_updateView addSubview:updateBtn];
    [_updateView addSubview:latterBtn];
    
    [[BMPopView shareInstance] showWithContentView:_updateView delegate:self];
}

- (void)crateNoNewVersion
{
    _updateView = [[UIView alloc] initWithFrame:CGRectMake(10, 100, KScreenWidth - 20, 150)];
    _updateView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    
    _updateView.layer.cornerRadius = 5;
    _updateView.layer.masksToBounds = YES;
    
    //发现新版本
    UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 150/2 - 20 , KScreenWidth, 40)];
    titleLB.text = @"当前版本已是最新版本！";
    titleLB.textAlignment = NSTextAlignmentCenter;
    titleLB.font = [UIFont systemFontOfSize:16];
    titleLB.textColor = [UIColor colorWithRed:34/255.0 green:177/255.0 blue:215/255.0 alpha:1];
    
    [_updateView addSubview:titleLB];
    [[BMPopView shareInstance] showWithContentView:_updateView delegate:self];
}

- (void)latterBtnClick
{
    ZWLog(@"稍后再说");
    
    [[BMPopView shareInstance] dismiss];
}

- (void)updateClick
{
    ZWLog(@"立即更新");
    
    [[BMPopView shareInstance] dismiss];
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:versionModel.data.versionsURL]];
}

//检查更新
-(void)getUpdateVersion{
    WebServices *helper4 = [[WebServices alloc] init];
    
    NSMutableArray *arr=[NSMutableArray array];
    
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"",@"versionNo", nil]];

     __weak PersonalViewController *wself = self;
    NSString *soapMsg = [SoapHelper arrayToDefaultSoapMessage:arr methodName:IsNewVersionsMethodName];
    //执行异步并取得结果
     [helper4 asyncServiceUrl:VersionsWebServiceUrl nameSpace:defaultWebServiceNameSpace methodName:IsNewVersionsMethodName soapMessage:soapMsg withBlock:^(NSString *json, NSError *error) {
         if(![json isEqualToString:@""])
         {
             //返回的json字符串转换成NSDictionary
             NSData* jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
             NSMutableDictionary *resultsDictionary = [jsonData objectFromJSONData];
             
             if ([[resultsDictionary objectForKey:@"status"] integerValue] == 1) {
                 versionModel = [[UpdateVersionModel alloc]initWithDictionary:resultsDictionary];
                 
                 NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
                 NSString *locationVersion = [NSString stringWithFormat:@"V1%@",version];
                 if ([locationVersion compare:versionModel.data.versionsNo] == -1) {
                     [wself updateVersionView];
                 }
                 else
                 {
                     [wself crateNoNewVersion];
                 }
             }
             
         }
         else
         {
             NSLog(@"网络异常！");
             UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"网络连接失败" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles: nil];
             [alertView show];
         }

     }];
    
}


#pragma mark - UITextView Delegate Methods
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [inputTV resignFirstResponder];
}


@end