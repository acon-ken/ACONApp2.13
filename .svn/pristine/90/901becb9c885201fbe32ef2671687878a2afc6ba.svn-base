//
//  BindingViewController.m
//  ACONApp
//
//  Created by fyf on 14/12/27.
//  Copyright (c) 2014年 zw. All rights reserved.
//

#import "BindingViewController.h"
#import "BindingModel.h"
#import "BindingData.h"

#import "LoginInfoModel.h"
#import "LoginInfoData.h"

//#import "HomeViewController.h"
#import "ServiceTermViewController.h"

@interface BindingViewController ()<UIAlertViewDelegate>
{

    UITextField *phoneTF;
    UITextField *passwordTF;
    UIButton *seleteBtn;//选择按钮
    UIButton *articleBtn;//服务条款按钮
    
    LoginInfoModel *userinfo;
}
@end

@implementation BindingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"beijin"]];
    self.title = @"绑定第三方账号";
    self.edgesForExtendedLayout = NO;
    helper = [[WebServices alloc] initWithDelegate:self];
    userinfo = [SaveUserInfo loadCustomObjectWithKey];
    
    //给导航栏加一个返回按钮
    UIButton *leftbackBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [leftbackBtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
    [leftbackBtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateSelected];
    [leftbackBtn  addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    leftbackBtn.selected = YES;
    UIBarButtonItem *leftButton  = [[UIBarButtonItem alloc] initWithCustomView:leftbackBtn];
    self.navigationItem.leftBarButtonItem=leftButton;
    
    //手机号输入框
    phoneTF = [[UITextField alloc]initWithFrame:CGRectMake(20, 20, KScreenWidth-40, 30)];
    phoneTF.borderStyle=UITextBorderStyleRoundedRect;
    //设置全部清除按钮，永远显示
    phoneTF.clearButtonMode=UITextFieldViewModeAlways;
    //设置文字内容垂直居中
    phoneTF.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    phoneTF.placeholder=@"请输入手机号";
    phoneTF.delegate=self;
    phoneTF.returnKeyType=UIReturnKeyDone;
    phoneTF.keyboardType = UIKeyboardTypeNumberPad;
   
    
    
    //密码输入框
    passwordTF = [[UITextField alloc]initWithFrame:CGRectMake(20, KBorderH+60, KScreenWidth-40, 30)];
    passwordTF.borderStyle=UITextBorderStyleRoundedRect;
    //设置全部清除按钮，永远显示
    passwordTF.clearButtonMode=UITextFieldViewModeAlways;
    //设置文字内容垂直居中
    passwordTF.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    passwordTF.placeholder=@"请输入密码";
    passwordTF.delegate=self;
    passwordTF.returnKeyType=UIReturnKeyDone;
    passwordTF.keyboardType = UIKeyboardTypeNamePhonePad;
    passwordTF.secureTextEntry = YES;
    
    
    //选择协议按钮
    seleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(KScreenWidth/2-60, CGRectGetMaxY(passwordTF.frame)+10, 20, 20)];
    [seleteBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [seleteBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [seleteBtn  addTarget:self action:@selector(seleteBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    seleteBtn.selected = YES;
    
    
//    //服务条款按钮
//    articleBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//    articleBtn.frame=CGRectMake(KScreenWidth/2-35, seleteBtn.frame.origin.y-10, 100, 40);
//    articleBtn.selected=YES;
//    [articleBtn setTitle:@"我同意使用条款" forState:UIControlStateNormal];
//    articleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
//    [articleBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
//    [articleBtn addTarget:self action:@selector(articleBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //服务条款按钮
    articleBtn = [[UIButton alloc] initWithFrame:CGRectMake(KScreenWidth/2-35, seleteBtn.frame.origin.y-10, 100, 40)];
    NSAttributedString *str2 = [[NSAttributedString alloc] initWithString:@"我同意使用条款" attributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:0/255 green:0/255 blue:255/255 alpha:0.6],NSFontAttributeName : [UIFont systemFontOfSize:13],NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle)}];
    [articleBtn setAttributedTitle:str2 forState:UIControlStateNormal];
    str2 = [[NSAttributedString alloc] initWithString:@"我同意使用条款" attributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:0/255 green:0/255 blue:255/255 alpha:0.6],NSFontAttributeName : [UIFont systemFontOfSize:13],NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle)}];
    [articleBtn setAttributedTitle:str2 forState:UIControlStateHighlighted];
    [articleBtn addTarget:self action:@selector(articleBtnAction:) forControlEvents:UIControlEventTouchUpInside];
   
    

    [self.view addSubview:phoneTF];
    [self.view addSubview:passwordTF];
    [self.view addSubview:seleteBtn];
    [self.view addSubview:articleBtn];
    
    //绑定按钮
    UIButton *BingdingBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(articleBtn.frame)+20, KScreenWidth-40, 35)];
    [BingdingBtn setBackgroundImage:[UIImage imageNamed:@"queding"] forState:UIControlStateNormal];
    [BingdingBtn setTitle:@"绑定" forState:UIControlStateNormal];
    [BingdingBtn addTarget:self action:@selector(BingdingBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    BingdingBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [BingdingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    BingdingBtn.selected = YES;
    [self.view addSubview:BingdingBtn];

}


#pragma mark - seleteBtn Delegate
-(void)seleteBtnAction:(id)sender{
   
    seleteBtn.selected = !seleteBtn.isSelected;
    if (seleteBtn.isSelected) {
        seleteBtn.tag = 0002;
    }else
        seleteBtn.tag = 0003;
    
    
    NSLog(@"点击选择按钮");
}


#pragma mark - articleBtn Delegate
-(void)articleBtnAction:(id)sender{
    
    ServiceTermViewController *serviceterm = [[ServiceTermViewController alloc]init];
    [self.navigationController pushViewController:serviceterm animated:YES];
    
    
    
    NSLog(@"点击服务条款");
}



#pragma mark - 导航栏返回按钮代理
-(void)backClick:(id)sender{

    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 绑定按钮代理
-(void)BingdingBtnAction:(id)sender{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    BOOL isPhone = [phoneTest evaluateWithObject:phoneTF.text];
    
    if (seleteBtn.tag==003)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请确认用户协议" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles: nil];
        [alert show];
        return;
    }
    else if ([phoneTF.text isEqualToString:@""]) {
        UIAlertView *warn = [[UIAlertView alloc]initWithTitle:@"" message:@"手机号不能为空" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles: nil];
        [warn show];
        return;
    }else if([passwordTF.text isEqualToString:@""]){
        UIAlertView *warn = [[UIAlertView alloc]initWithTitle:@"" message:@"密码不能为空" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles: nil];
        [warn show];
        return;
    }
    else if (passwordTF.text.length <6){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"密码长度应为6到15位" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles: nil];
        [alert show];
        return;
        
    }

    else if (!isPhone)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请填写正确的手机号码！" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles: nil];
        [alert show];
        return;
    }

    else
    {
        [self postBingding];
    }
    
    
    NSLog(@"点击绑定");


}


//限制联系方式输入框输入的长度
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;{ //string就是此时输入的那个字符textField就是此时正在输入的那个输入框返回YES就是可以改变输入框的值NO相反
    if ([string isEqualToString:@"\n"]) //按会车可以改变
    {
        return YES;
        
    }
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    if (phoneTF == textField) //判断是否时我们想要限定的那个输入框
    {
        if ([toBeString length] > 11) { //如果输入框内容大于20则弹出警告
            textField.text = [toBeString substringToIndex:11];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请输入11位手机号或昵称" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] ;
            [alert show];
            return NO;
        }
    } //return YES;

    if (passwordTF== textField) {
        if ([toBeString length] > 15) { //如果输入框内容大于20则弹出警告
            textField.text = [toBeString substringToIndex:11];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您的密码不得超过15位" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] ;
            [alert show];
            return NO;
        }
    } return YES;

}


//绑定请求
-(void)postBingding{
    [MBProgressHUD showMessage:@"绑定中..." toView:self.view];//显示动画
    WebServices *helper1 = [[WebServices alloc] init];
    
    NSMutableArray *arr=[NSMutableArray array];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:self.userid,@"uid", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:phoneTF.text,@"phone", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:[ToolView md5:passwordTF.text],@"passWord", nil]];
    
      __weak BindingViewController *wself = self;
    NSString *soapMsg = [SoapHelper arrayToDefaultSoapMessage:arr methodName:OnRegistWeiBinMethodName];
    //执行异步并取得结果
  
      [helper1 asyncServiceUrl:UserInfoWebServiceUrl nameSpace:defaultWebServiceNameSpace methodName:OnRegistWeiBinMethodName soapMessage:soapMsg withBlock:^(NSString *json, NSError *error) {
           [MBProgressHUD hideHUDForView:wself.view animated:YES];//移除动画
          if(![json isEqualToString:@""])
          {
              //返回的json字符串转换成NSDictionary
              NSData* jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
              NSMutableDictionary *resultsDictionary = [jsonData objectFromJSONData];
              
              BindingModel *info = [[BindingModel alloc] initWithDictionary:resultsDictionary];
              if (info.status == 0) {
                  
                  userinfo = [SaveUserInfo loadCustomObjectWithKey];
                  LoginInfoData *userinfodata = userinfo.data;
                  
                  userinfodata.dataIdentifier = self.userid;
                  userinfodata.phone = phoneTF.text;
                  userinfodata.qQ = info.data.qQ;
                  userinfodata.passWord =info.data.passWord;
                  userinfodata.isVisible = info.data.isVisible;
                  userinfodata.addDate = info.data.addDate;
                  userinfodata.userName = info.data.userName;
                  userinfodata.portraitURL =info.data.portraitURL;
                  userinfodata.loginName = info.data.loginName;
                  userinfodata.imageUrl = info.data.portraitURL;
//                  userinfodata.bloodType = info.data.bl
                  userinfo.data = userinfodata;
                  
                  [SaveUserInfo saveCustomObject:userinfo];
                
                  UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"绑定成功，请返回登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                  alertView.tag =442200;
                  [alertView show];

                  
//                  HomeViewController *home = [[HomeViewController alloc]init];
//                  [wself.navigationController pushViewController:home animated:YES];
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

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==442200) {
        if (buttonIndex==0) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }
    
}

#pragma mark - UITextField Delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([textField isFirstResponder]) {
        
        [textField resignFirstResponder];
    }
    return YES;
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [phoneTF resignFirstResponder];
    [passwordTF resignFirstResponder];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
