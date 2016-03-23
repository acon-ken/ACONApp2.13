//
//  ForgetpasswordController.m
//  ACONApp
//
//  Created by fyf on 14/11/27.
//  Copyright (c) 2014年 zw. All rights reserved.
//

#import "ForgetpasswordController.h"
#import "ChangepasswordController.h"

@interface ForgetpasswordController ()<UIAlertViewDelegate>
{
    UITextField *phoneTF;
    UITextField *identifyingcodeTF;
     UIButton *identifyingcodeBtn;
    NSString *verCodestr;
}
@end

@implementation ForgetpasswordController

- (void)viewDidLoad {
    [super viewDidLoad];

    helper = [[WebServices alloc] initWithDelegate:self];
    
    self.title = @"忘记密码";
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
    phoneTF.tag = 00005;
    
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
    identifyingcodeTF.tag = 00006;
    
    [self.view addSubview:phoneTF];
    [self.view addSubview:identifyingcodeTF];
    
    //获取验证码按钮
    identifyingcodeBtn = [[UIButton alloc] initWithFrame:CGRectMake(20+identifyingcodeTF.frame.size.width+10, KBorderH+55, 100, 35)];
    [identifyingcodeBtn setBackgroundImage:[UIImage imageNamed:@"queding"] forState:UIControlStateNormal];
    [identifyingcodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [identifyingcodeBtn addTarget:self action:@selector(identifyingAction:) forControlEvents:UIControlEventTouchUpInside];
    identifyingcodeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [identifyingcodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    identifyingcodeBtn.tag =006;
    identifyingcodeBtn.selected = YES;
    [self.view addSubview:identifyingcodeBtn];
    
    //下一步按钮
    UIButton *nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, KBorderH+120, KScreenWidth-40, 35)];
    [nextBtn setBackgroundImage:[UIImage imageNamed:@"queding"] forState:UIControlStateNormal];
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(nextBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    nextBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    nextBtn.tag =007;
    nextBtn.selected = YES;
    [self.view addSubview:nextBtn];
    
}

#pragma mark - identifyingBtn Delegate
-(void)identifyingAction:(id)sender{
    
    if (phoneTF.text.length != 11) {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请输入11位手机号" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        return;
    }

    [self postAuthCode];
    
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
    

    NSString *soapMsg = [SoapHelper arrayToDefaultSoapMessage:arr methodName:GetSmsApartCodeMethodName];
    //执行异步步并取得结果
    [helper1 asyncServiceUrl:GetSmsApartCodeWebServiceUrl nameSpace:defaultWebServiceNameSpace methodName:GetSmsApartCodeMethodName soapMessage:soapMsg withBlock:^(NSString *json, NSError *error) {
          [AppHelper removeHUD];//移除动画
        if(![json isEqualToString:@""])
        {
            //返回的json字符串转换成NSDictionary
            NSData* jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
            NSMutableDictionary *resultsDictionary = [jsonData objectFromJSONData];
            
            UserModel *info = [[UserModel alloc] initWithDictionary:resultsDictionary];
            if (info.status == 0) {
            
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


/**
 * 根据手机号获取用户资料请求
 */
-(void)postGetUserInfoPhone{
    WebServices *helper2 = [[WebServices alloc] init];
    
    NSMutableArray *arr=[NSMutableArray array];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:phoneTF.text,@"phone", nil]];
    
    
    NSString *soapMsg = [SoapHelper arrayToDefaultSoapMessage:arr methodName:GetUserInfoPhoneMethodName];
    //执行异步步并取得结果
    [helper2 asyncServiceUrl:UserInfoWebServiceUrl nameSpace:defaultWebServiceNameSpace methodName:GetUserInfoPhoneMethodName soapMessage:soapMsg withBlock:^(NSString *json, NSError *error) {
        [AppHelper removeHUD];//移除动画
        if(![json isEqualToString:@""])
        {
            //返回的json字符串转换成NSDictionary
            NSData* jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
            NSMutableDictionary *resultsDictionary = [jsonData objectFromJSONData];
            
            UserModel *info = [[UserModel alloc] initWithDictionary:resultsDictionary];
            if (info.status == 0) {

                ChangepasswordController *changepassword = [[ChangepasswordController alloc]init];
                changepassword.phoneStr = phoneTF.text;
                [self.navigationController pushViewController:changepassword animated:YES];

            }
            else
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:info.msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                alertView.tag = 9991;
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

    if (alertView.tag == 9991) {
        if (buttonIndex == 0) {
            [self.navigationController popViewControllerAnimated:YES];
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


//键盘消失
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];// this will do the trick
}

#pragma mark - NavigationBack Delegate
-(void)backClick:(id)sender{

    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark - nextBtn Delegate
-(void)nextBtnAction:(id)sender{
  
    
    
    if ([phoneTF.text isEqualToString:@""])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"号码不能为空" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles: nil];
        [alert show];
        return;
    }
    else if([identifyingcodeTF.text isEqualToString:verCodestr]==NO)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"验证码有误" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles: nil];
        [alert show];
        return;
    }else if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"postyanzhengphone"] isEqualToString:phoneTF.text] == NO){
    
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"验证码有误" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles: nil];
        [alert show];
        return;
    }
    else{
//        
//
//        
        [self postGetUserInfoPhone];
    }
   
    

    
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
