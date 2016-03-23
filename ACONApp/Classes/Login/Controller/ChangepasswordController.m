//
//  ChangepasswordController.m
//  ACONApp
//
//  Created by fyf on 14/11/27.
//  Copyright (c) 2014年 zw. All rights reserved.
//

#import "ChangepasswordController.h"
//#import "LoginInfoData.h"
//#import "LoginInfoModel.h"

#import "LoginViewController.h"


@interface ChangepasswordController ()<UIAlertViewDelegate>
{
    UITextField *NewPassword;
    UITextField *sureNewPassword;
}
@end

@implementation ChangepasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    helper = [[WebServices alloc] initWithDelegate:self];
    
    self.title = @"修改密码";
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"beijin"]];
    self.edgesForExtendedLayout = NO;
    //给导航栏加一个返回按钮
    UIButton *leftbackBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [leftbackBtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
    [leftbackBtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateSelected];
    [leftbackBtn  addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    leftbackBtn.selected = YES;
    UIBarButtonItem *leftButton  = [[UIBarButtonItem alloc] initWithCustomView:leftbackBtn];
    self.navigationItem.leftBarButtonItem=leftButton;
    
    //新密码输入框
    NewPassword = [[UITextField alloc]initWithFrame:CGRectMake(20, 20, KScreenWidth-40, 30)];
    NewPassword.borderStyle=UITextBorderStyleRoundedRect;
    //设置全部清除按钮，永远显示
    NewPassword.clearButtonMode=UITextFieldViewModeAlways;
    //设置文字内容垂直居中
    NewPassword.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    NewPassword.placeholder=@"输入新密码";
    NewPassword.delegate=self;
    NewPassword.returnKeyType=UIReturnKeyDone;
    NewPassword.keyboardType = UIKeyboardTypeNamePhonePad;
    NewPassword.secureTextEntry = YES;
    NewPassword.tag = 00007;
   
    //新密码确认输入框
    sureNewPassword = [[UITextField alloc]initWithFrame:CGRectMake(20, KBorderH+60, KScreenWidth-40, 30)];
    sureNewPassword.borderStyle=UITextBorderStyleRoundedRect;
    //设置全部清除按钮，永远显示
    sureNewPassword.clearButtonMode=UITextFieldViewModeAlways;
    //设置文字内容垂直居中
    sureNewPassword.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    sureNewPassword.placeholder=@"确认新密码";
    sureNewPassword.delegate=self;
    sureNewPassword.returnKeyType=UIReturnKeyDone;
    sureNewPassword.keyboardType = UIKeyboardTypeNamePhonePad;
    sureNewPassword.secureTextEntry = YES;
    sureNewPassword.tag = 000010;
    
    [self.view addSubview:NewPassword];
    [self.view addSubview:sureNewPassword];
    
    //下一步按钮
    UIButton *SureBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, KBorderH+120, KScreenWidth-40, 35)];
    [SureBtn setBackgroundImage:[UIImage imageNamed:@"queding"] forState:UIControlStateNormal];
    [SureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [SureBtn addTarget:self action:@selector(SureBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    SureBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [SureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    SureBtn.tag =007;
    SureBtn.selected = YES;
    [self.view addSubview:SureBtn];

    
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
    else if (NewPassword.text.length <6){
        
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
        [self postresetPassword];
    }
    NSLog(@"重置密码操作完成");
    
   
    NSLog(@"点击确定");
}

//修改密码请求
-(void)postresetPassword{
    [MBProgressHUD showMessage:@"加载中..." toView:self.view];//显示动画
    WebServices *helper1 = [[WebServices alloc] init];
    
//    LoginInfoModel *model = [SaveUserInfo loadCustomObjectWithKey];
//    LoginInfoData *data = model.data;
    
    
    NSMutableArray *arr=[NSMutableArray array];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:_phoneStr,@"phone", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:[ToolView md5:NewPassword.text],@"passWord", nil]];
    
    
    NSString *soapMsg = [SoapHelper arrayToDefaultSoapMessage:arr methodName:UpdatePassByVerCodeMethodName];
    //执行异步并取得结果
     [helper1 asyncServiceUrl:UserInfoWebServiceUrl nameSpace:defaultWebServiceNameSpace methodName:UpdatePassByVerCodeMethodName soapMessage:soapMsg withBlock:^(NSString *json, NSError *error) {
          [MBProgressHUD hideAllHUDsForView:self.view animated:YES];//移除动画
         if(![json isEqualToString:@""])
         {
             //返回的json字符串转换成NSDictionary
             NSData* jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
             NSMutableDictionary *resultsDictionary = [jsonData objectFromJSONData];
             
             UserModel *info = [[UserModel alloc] initWithDictionary:resultsDictionary];
             if (info.status == 0) {
                 ZWLog(@"修改密码成功");
                 
                 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:info.msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                 alertView.tag=10000;
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
    if (alertView.tag==10000) {
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

#pragma mark - NavigationBack Delegate
-(void)backClick:(id)sender{

   // [self.navigationController popViewControllerAnimated:YES];
    LoginViewController *login = [[LoginViewController alloc]init];
    [self.navigationController pushViewController:login animated:YES];
}


//键盘消失
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];// this will do the trick
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
