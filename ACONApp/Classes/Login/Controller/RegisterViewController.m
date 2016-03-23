//
//  RegisterViewController.m
//  ACONApp
//
//  Created by 朱红轻飞溅 on 14/11/25.
//  Copyright (c) 2014年 zw. All rights reserved.
//

#import "RegisterViewController.h"
#import "ServiceTermViewController.h"
#import "APService.h"
#import "HomeViewController.h"
#import "LoginViewController.h"
@interface RegisterViewController ()<UIAlertViewDelegate>
{
    UITextField *phoneTF;
    UITextField *identifyingcodeTF;
    UITextField *Password;
    UITextField *surePassword;
    UIButton *seleteBtn;
    UIButton *identifyingcodeBtn;
    UIButton *articleBtn;
    NSString *verCodestr;
}
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"beijin"]];
    self.title = @"注册";
    self.edgesForExtendedLayout = NO;
    helper = [[WebServices alloc] initWithDelegate:self];
    
    
    //给导航栏加一个返回按钮
    UIButton *leftbackBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [leftbackBtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
    [leftbackBtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateSelected];
    [leftbackBtn  addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    leftbackBtn.selected = YES;
    UIBarButtonItem *leftButton  = [[UIBarButtonItem alloc] initWithCustomView:leftbackBtn];
    self.navigationItem.leftBarButtonItem=leftButton;
    

    
    phoneTF = [[UITextField alloc]initWithFrame:CGRectMake(20, 20, KScreenWidth-40, 30)];
    phoneTF.borderStyle=UITextBorderStyleRoundedRect;
    //设置全部清除按钮，永远显示
    phoneTF.clearButtonMode=UITextFieldViewModeAlways;
    //设置文字内容垂直居中
    phoneTF.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    phoneTF.placeholder=@"手机号";
    phoneTF.delegate=self;
    phoneTF.returnKeyType=UIReturnKeyDone;
    phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    phoneTF.tag = 00001;
    [phoneTF addTarget:self action:@selector(filter1:)  forControlEvents:UIControlEventEditingChanged];
    
    identifyingcodeTF = [[UITextField alloc]initWithFrame:CGRectMake(20, KBorderH+60, KScreenWidth-150, 30)];
    identifyingcodeTF.borderStyle=UITextBorderStyleRoundedRect;
    //设置全部清除按钮，永远显示
    identifyingcodeTF.clearButtonMode=UITextFieldViewModeAlways;
    //设置文字内容垂直居中
    identifyingcodeTF.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    identifyingcodeTF.placeholder=@"输入验证码";
    identifyingcodeTF.delegate=self;
    identifyingcodeTF.returnKeyType=UIReturnKeyDone;
    identifyingcodeTF.keyboardType = UIKeyboardTypeNumberPad;
    identifyingcodeTF.tag = 00002;
    [identifyingcodeTF addTarget:self action:@selector(filter1:)  forControlEvents:UIControlEventEditingChanged];
    
    
    Password = [[UITextField alloc]initWithFrame:CGRectMake(20, KBorderH+110, KScreenWidth-40, 30)];
    Password.borderStyle=UITextBorderStyleRoundedRect;
    //设置全部清除按钮，永远显示
    Password.clearButtonMode=UITextFieldViewModeAlways;
    //设置文字内容垂直居中
    Password.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    Password.placeholder=@"输入密码";
    Password.delegate=self;
    Password.returnKeyType=UIReturnKeyDone;
    Password.keyboardType = UIKeyboardTypeNamePhonePad;
    Password.tag = 00003;
    Password.secureTextEntry = YES;
    [Password addTarget:self action:@selector(filter1:)  forControlEvents:UIControlEventEditingChanged];
    
    
    surePassword = [[UITextField alloc]initWithFrame:CGRectMake(20, KBorderH+160, KScreenWidth-40, 30)];
    surePassword.borderStyle=UITextBorderStyleRoundedRect;
    //设置全部清除按钮，永远显示
    surePassword.clearButtonMode=UITextFieldViewModeAlways;
    //设置文字内容垂直居中
    surePassword.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    surePassword.placeholder=@"确认密码";
    surePassword.delegate=self;
    surePassword.returnKeyType=UIReturnKeyDone;
    surePassword.keyboardType = UIKeyboardTypeNamePhonePad;
    surePassword.tag = 00004;
    surePassword.secureTextEntry = YES;
    [surePassword addTarget:self action:@selector(filter1:)  forControlEvents:UIControlEventEditingChanged];
    
    [self.view addSubview:phoneTF];
    [self.view addSubview:identifyingcodeTF];
    [self.view addSubview:Password];
    [self.view addSubview:surePassword];
    
    //获取验证码按钮
    identifyingcodeBtn = [[UIButton alloc] initWithFrame:CGRectMake(20+identifyingcodeTF.frame.size.width+10, KBorderH+55, 100, 35)];
    [identifyingcodeBtn setBackgroundImage:[UIImage imageNamed:@"queding"] forState:UIControlStateNormal];
    [identifyingcodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [identifyingcodeBtn addTarget:self action:@selector(identifyingAction:) forControlEvents:UIControlEventTouchUpInside];
    identifyingcodeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [identifyingcodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    identifyingcodeBtn.tag =001;
    identifyingcodeBtn.selected = YES;
    [self.view addSubview:identifyingcodeBtn];
    
    //选择协议按钮
    seleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(KScreenWidth/2-60, KBorderH+200, 20, 20)];
    [seleteBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [seleteBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [seleteBtn  addTarget:self action:@selector(seleteBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    seleteBtn.selected = YES;
    [self.view addSubview:seleteBtn];

    //服务条款按钮
    articleBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    articleBtn.frame=CGRectMake(KScreenWidth/2-35, KBorderH+190, 100, 40);
    articleBtn.selected=YES;
    [articleBtn setTitle:@"我同意使用条款" forState:UIControlStateNormal];
    articleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [articleBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [articleBtn addTarget:self action:@selector(articleBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:articleBtn];
    
    //注册按钮
    UIButton *RegisterBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, KBorderH+250, KScreenWidth-40, 35)];
    [RegisterBtn setBackgroundImage:[UIImage imageNamed:@"queding"] forState:UIControlStateNormal];
    [RegisterBtn setTitle:@"注册" forState:UIControlStateNormal];
    [RegisterBtn addTarget:self action:@selector(RegisterBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    RegisterBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [RegisterBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    RegisterBtn.tag =004;
    RegisterBtn.selected = YES;
    [self.view addSubview:RegisterBtn];
    
    //立即返回登录按钮
    UIButton *registerBtn = [[UIButton alloc] initWithFrame:CGRectMake(KScreenWidth - 150, KBorderH+290, 130, 23)];
    NSAttributedString *str3 = [[NSAttributedString alloc] initWithString:@"已有账号，立即登录" attributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:0/255 green:0/255 blue:255/255 alpha:0.6],NSFontAttributeName : [UIFont systemFontOfSize:13],NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle)}];
    [registerBtn setAttributedTitle:str3 forState:UIControlStateNormal];
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"已有账号，立即登录" attributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:0/255 green:0/255 blue:255/255 alpha:0.6],NSFontAttributeName : [UIFont systemFontOfSize:13],NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle)}];
    [registerBtn setAttributedTitle:str forState:UIControlStateHighlighted];
    registerBtn.tag = 005;
    [registerBtn addTarget:self action:@selector(registerBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];




}

#pragma mark - UITextField Delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([textField isFirstResponder]) {
        
        [textField resignFirstResponder];
    }
    return YES;
    
}

-(void)filter1:(UITextField *)textField{
    
}

#pragma mark - identifyingcodeBtn Delegate
-(void)identifyingAction:(id)sender{
    
    if (phoneTF.text.length != 11) {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请输入11位手机号" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        return;
    }

    [self postAuthCode];

    NSLog(@"获取验证码");
    __block int timeout=60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [identifyingcodeBtn setTitle:@"获取验证码" forState:UIControlStateSelected];
                [identifyingcodeBtn setBackgroundImage:[UIImage imageNamed:@"queding"] forState:UIControlStateNormal];
                identifyingcodeBtn.userInteractionEnabled = YES;
            });
        }else{
            //            int minutes = timeout / 60;
            int seconds = timeout;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                NSLog(@"____%@",strTime);
                [identifyingcodeBtn setTitle:[NSString stringWithFormat:@"%@秒后重新获取",strTime] forState:UIControlStateSelected];
                [identifyingcodeBtn setBackgroundImage:[UIImage imageNamed:@"queding"] forState:UIControlStateNormal];
                identifyingcodeBtn.userInteractionEnabled = NO;
                
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);

}

/**
 *  验证码请求
 */
-(void)postAuthCode{
  
    WebServices *helper1 = [[WebServices alloc] init];
    NSMutableArray *arr=[NSMutableArray array];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:phoneTF.text,@"mobileNo", nil]];
    
    __weak RegisterViewController *wself = self;
    NSString *soapMsg = [SoapHelper arrayToDefaultSoapMessage:arr methodName:GetSmsApartCodeMethodName];
    //执行异步并取得结果
    [helper1 asyncServiceUrl:GetSmsApartCodeWebServiceUrl nameSpace:defaultWebServiceNameSpace methodName:GetSmsApartCodeMethodName soapMessage:soapMsg withBlock:^(NSString *json, NSError *error) {

        if(![json isEqualToString:@""])
        {
            //返回的json字符串转换成NSDictionary
            NSData* jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
            NSMutableDictionary *resultsDictionary = [jsonData objectFromJSONData];
            
            UserModel *info = [[UserModel alloc] initWithDictionary:resultsDictionary];
            if (info.status == 0) {
                ZWLog(@"注册成功");
                verCodestr=   [resultsDictionary objectForKey:@"verCode"];
                
                [[NSUserDefaults standardUserDefaults] setValue:phoneTF.text  forKey:@"postyanzhengphone"];
                [[NSUserDefaults standardUserDefaults] synchronize];

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

#pragma mark - seleteBtn Delegate
-(void)seleteBtnAction:(id)sender{
//    if (!_isChange)
//    {
//        [sender setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateNormal];
//        [sender setTag:003];
//    }else
//    {
//        [sender setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
//        [sender setTag:004];
//    }
//    _isChange=!_isChange;
    seleteBtn.selected = !seleteBtn.isSelected;
    if (seleteBtn.isSelected) {
        seleteBtn.tag = 002;
    }else
        seleteBtn.tag = 003;

    
   NSLog(@"点击选择按钮");
}



#pragma mark - articleBtn Delegate
-(void)articleBtnAction:(id)sender{
    
        ServiceTermViewController *serviceterm = [[ServiceTermViewController alloc]init];
        [self.navigationController pushViewController:serviceterm animated:YES];
    
    
    
    NSLog(@"点击服务条款");
}


#pragma mark - RegisterBtn Delegate
-(void)RegisterBtnAction:(id)sender{

    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    BOOL isPhone = [phoneTest evaluateWithObject:phoneTF.text];
    
    
    if (seleteBtn.tag==003)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请确认用户协议" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles: nil];
        [alert show];
        return;
    }else if ([phoneTF.text isEqualToString:@""])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"号码不能为空" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles: nil];
        [alert show];
        return;
    }
    else if (!isPhone)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请填写正确的手机号码！" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    else if([identifyingcodeTF.text isEqualToString:verCodestr]==NO)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"验证码有误" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles: nil];
        [alert show];
        return;
    }else if([Password.text isEqualToString:@""])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"密码不能为空" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles: nil];
        [alert show];
        return;
    }
    else if (Password.text.length <6 ){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"密码长度应为6到15位" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles: nil];
        [alert show];
        return;
        
    }
    else if([surePassword.text isEqualToString:@""])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"密码不能为空" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles: nil];
        [alert show];
        return;
    }
    else if([surePassword.text isEqualToString:Password.text]==NO)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"密码输入不一致" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles: nil];
        [alert show];
        return;
    }else if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"postyanzhengphone"] isEqualToString:phoneTF.text] == NO){
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"验证码有误" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles: nil];
        [alert show];
        return;
    }

    else{
        
        [self postRegister];
    }
       ZWLog(@"完成");
}


/**
 *  注册请求
 */
- (void)postRegister{
     [MBProgressHUD showMessage:@"注册中..." toView:self.view];//显示动画
     WebServices *helper2 = [[WebServices alloc] init];
    
    NSMutableArray *arr=[NSMutableArray array];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:phoneTF.text,@"phone", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:[ToolView md5:Password.text],@"passWord", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:[APService registrationID],@"regPushId", nil]];

    
     __weak RegisterViewController *wself = self;
    NSString *soapMsg = [SoapHelper arrayToDefaultSoapMessage:arr methodName:UserInfoMethodName];
    //执行异步并取得结果
    [helper2 asyncServiceUrl:UserInfoWebServiceUrl nameSpace:defaultWebServiceNameSpace methodName:UserInfoMethodName soapMessage:soapMsg withBlock:^(NSString *json, NSError *error) {
         [MBProgressHUD hideAllHUDsForView:wself.view animated:YES];//移除动画
        if(![json isEqualToString:@""])
        {
            NSLog(@"%@",arr);
            
            //返回的json字符串转换成NSDictionary
            NSData* jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
            NSMutableDictionary *resultsDictionary = [jsonData objectFromJSONData];
            
            UserModel *info = [[UserModel alloc] initWithDictionary:resultsDictionary];
            if (info.status == 0) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"注册成功，请返回登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                alertView.tag =8989898;
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

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==8989898) {
        if (buttonIndex==0) {
//            [self postLogin];
            [self.navigationController popViewControllerAnimated:YES];

        }
    }

}
/**
 *  登陆请求
 */
- (void)postLogin{
    [MBProgressHUD showMessage:@"登录中..." toView:self.view];//显示动画
    WebServices *helper3 = [[WebServices alloc] init];
    [APService registrationID];
    NSMutableArray *arr=[NSMutableArray array];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:phoneTF.text,@"phone", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:[ToolView md5:Password.text],@"passWord", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:[APService registrationID],@"regPushId", nil]];
    
     __weak RegisterViewController *wself = self;
    NSString *soapMsg = [SoapHelper arrayToDefaultSoapMessage:arr methodName:OnLoginMethodName];
    //执行异步并取得结果
     [helper3 asyncServiceUrl:UserInfoWebServiceUrl nameSpace:defaultWebServiceNameSpace methodName:OnLoginMethodName soapMessage:soapMsg withBlock:^(NSString *json, NSError *error) {
         [MBProgressHUD hideAllHUDsForView:wself.view animated:YES];//移除动画
         if(![json isEqualToString:@""])
         {
             //返回的json字符串转换成NSDictionary
             NSData* jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
             NSMutableDictionary *resultsDictionary = [jsonData objectFromJSONData];
             
             LoginInfoModel *info=[[LoginInfoModel alloc]initWithDictionary:resultsDictionary];
             if (info.status==0)
             {
                 [SaveUserInfo saveCustomObject:info];
                 
                 NSLog(@"%@",[SaveUserInfo loadCustomObjectWithKey]);
                 
                 HomeViewController *root = [[HomeViewController alloc] init];
                 AKNavigationController *nav = [[AKNavigationController alloc]initWithRootViewController:root];

                 wself.view.window.rootViewController = nav;
             }
             else
             {
                 UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:info.msg delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles: nil];
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



//限制联系方式输入框输入的长度
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;{ //string就是此时输入的那个字符textField就是此时正在输入的那个输入框返回YES就是可以改变输入框的值NO相反
    if ([string isEqualToString:@"\n"]) //按会车可以改变
    {
        return YES;
        
    }
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    if (Password == textField ||surePassword ==textField) //判断是否时我们想要限定的那个输入框
    {
        if ([toBeString length] > 15) { //如果输入框内容大于20则弹出警告
            textField.text = [toBeString substringToIndex:15];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您的密码不得超过15位" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] ;
            [alert show];
            return NO;
        }
    }
    return YES;
}



#pragma mark - registerBtn Delegate
-(void)registerBtnAction:(id)sender{

    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"点击已有账号，立即登陆");
}

#pragma mark - NavigationBack Delegate
-(void)backClick:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}


//键盘消失
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];// this will do the trick
}



@end
