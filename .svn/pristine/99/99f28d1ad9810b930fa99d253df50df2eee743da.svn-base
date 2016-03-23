//
//  ChangepasswordVC.m
//  ACONApp
//
//  Created by fyf on 14/12/5.
//  Copyright (c) 2014年 zw. All rights reserved.
//

#import "ChangepasswordVC.h"
#import "LoginInfoModel.h"
#import "LoginInfoData.h"

#import "LoginViewController.h"
@interface ChangepasswordVC ()<UIAlertViewDelegate>
{
    UITextField *OldPassword;
    UITextField *NewPassword;
    UITextField *sureNewPassword;
}
@end

@implementation ChangepasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"修改密码";
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"beijin"]];
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
    
    
    //旧密码输入框
    OldPassword = [[UITextField alloc]initWithFrame:CGRectMake(20, 20, KScreenWidth-40, 30)];
    OldPassword.borderStyle=UITextBorderStyleRoundedRect;
    //设置全部清除按钮，永远显示
    OldPassword.clearButtonMode=UITextFieldViewModeAlways;
    //设置文字内容垂直居中
    OldPassword.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    OldPassword.placeholder=@"旧密码";
    OldPassword.delegate=self;
    OldPassword.returnKeyType=UIReturnKeyDone;
    OldPassword.secureTextEntry = YES;
    OldPassword.keyboardType = UIKeyboardTypeNamePhonePad;


    
    //新密码输入框
    NewPassword = [[UITextField alloc]initWithFrame:CGRectMake(20, OldPassword.frame.origin.y+50, KScreenWidth-40, 30)];
    NewPassword.borderStyle=UITextBorderStyleRoundedRect;
    //设置全部清除按钮，永远显示
    NewPassword.clearButtonMode=UITextFieldViewModeAlways;
    //设置文字内容垂直居中
    NewPassword.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    NewPassword.placeholder=@"新密码";
    NewPassword.delegate=self;
    NewPassword.returnKeyType=UIReturnKeyDone;
    NewPassword.secureTextEntry = YES;
    NewPassword.keyboardType = UIKeyboardTypeNamePhonePad;
    
    
    //新密码确认输入框
    sureNewPassword = [[UITextField alloc]initWithFrame:CGRectMake(20, NewPassword.frame.origin.y+50, KScreenWidth-40, 30)];
    sureNewPassword.borderStyle=UITextBorderStyleRoundedRect;
    //设置全部清除按钮，永远显示
    sureNewPassword.clearButtonMode=UITextFieldViewModeAlways;
    //设置文字内容垂直居中
    sureNewPassword.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    sureNewPassword.placeholder=@"确认新密码";
    sureNewPassword.delegate=self;
    sureNewPassword.returnKeyType=UIReturnKeyDone;
    sureNewPassword.secureTextEntry = YES;
    sureNewPassword.keyboardType = UIKeyboardTypeNamePhonePad;

    [self.view addSubview:OldPassword];
    [self.view addSubview:NewPassword];
    [self.view addSubview:sureNewPassword];
    
    //下一步按钮
    UIButton *SureBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, sureNewPassword.frame.origin.y+50, KScreenWidth-40, 35)];
    [SureBtn setBackgroundImage:[UIImage imageNamed:@"queding"] forState:UIControlStateNormal];
    [SureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [SureBtn addTarget:self action:@selector(SureBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    SureBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [SureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    SureBtn.selected = YES;
    [self.view addSubview:SureBtn];

}


#pragma mark - UITextField Delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([textField isFirstResponder]) {
        
        [textField resignFirstResponder];
    }
    return YES;
    
}


//限制联系方式输入框输入的长度
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;{ //string就是此时输入的那个字符textField就是此时正在输入的那个输入框返回YES就是可以改变输入框的值NO相反
    if ([string isEqualToString:@"\n"]) //按会车可以改变
    {
        return YES;
        
    }
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    if (NewPassword == textField ||sureNewPassword ==textField) //判断是否时我们想要限定的那个输入框
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



#pragma mark - SureBtn Delegate
-(void)SureBtnAction:(id)sender{
    
    if ([NewPassword.text isEqualToString:@""]) {
        UIAlertView *warn = [[UIAlertView alloc]initWithTitle:@"" message:@"新密码不能为空" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles: nil];
        [warn show];
        return;
    }
    else if (NewPassword.text.length <6)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"密码长度应为6到15位" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles: nil];
        [alert show];
        return;
    }

    else if([sureNewPassword.text isEqualToString:@""]){
        UIAlertView *warn = [[UIAlertView alloc]initWithTitle:@"" message:@"新密码不能为空" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles: nil];
        [warn show];
        return;
    }
    else if (sureNewPassword.text &&NewPassword.text&& (![NewPassword.text isEqualToString:sureNewPassword.text])) {
        UIAlertView *warn = [[UIAlertView alloc]initWithTitle:@"" message:@"两次输入密码不一致" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles: nil];
        [warn show];
        return;
    }else
    {
         [self postresetPassword1];
    }
    NSLog(@"重置密码操作完成");
    
   }


-(void)postresetPassword1{
   [MBProgressHUD showMessage:@"加载中..." toView:self.view];
    WebServices *helper1 = [[WebServices alloc] init];
    
    LoginInfoModel *model = [SaveUserInfo loadCustomObjectWithKey];
    LoginInfoData *data = model.data;
    
    
    NSMutableArray *arr=[NSMutableArray array];

    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:data.dataIdentifier,@"u_id", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:[ToolView md5:OldPassword.text],@"oldPass", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:[ToolView md5:NewPassword.text],@"passWord", nil]];
    
    __weak ChangepasswordVC *wself = self;
    NSString *soapMsg = [SoapHelper arrayToDefaultSoapMessage:arr methodName:UpdatePwdByUserIdMethodName];
    //执行同步并取得结果
     [helper1 asyncServiceUrl:UserInfoWebServiceUrl nameSpace:defaultWebServiceNameSpace methodName:UpdatePwdByUserIdMethodName soapMessage:soapMsg withBlock:^(NSString *json, NSError *error) {
          [MBProgressHUD hideAllHUDsForView:wself.view animated:YES];//移除动画
         if(![json isEqualToString:@""])
         {
             //返回的json字符串转换成NSDictionary
             NSData* jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
             NSMutableDictionary *resultsDictionary = [jsonData objectFromJSONData];
             
             UserModel *info = [[UserModel alloc] initWithDictionary:resultsDictionary];
             if (info.status == 0) {
                 ZWLog(@"修改密码成功");
                 
                 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"修改密码成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                 alertView.tag=6000;
                 [alertView show];
                 
                 
                 NSLog(@"点击确定");
                 
                 
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
    if (alertView.tag==6000) {
        if (buttonIndex==0) {
            LoginViewController *login = [[LoginViewController alloc]init];
            [self.navigationController pushViewController:login animated:YES];
        }
    }

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
