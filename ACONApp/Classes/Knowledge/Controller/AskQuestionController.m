//
//  AskQuestionController.m
//  ACONApp
//
//  Created by fyf on 14/12/3.
//  Copyright (c) 2014年 zw. All rights reserved.
//

#import "AskQuestionController.h"
#import "LoginInfoModel.h"
#import "LoginInfoData.h"
@interface AskQuestionController ()<UIAlertViewDelegate,UITextViewDelegate>
{
        UITextView *inputTV;
    UITextField *contactwayTF;
     LoginInfoModel *userinfo;
}
@end

@implementation AskQuestionController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.view.backgroundColor = KBackgroundColor;
    self.title = @"我要提问";
    self.edgesForExtendedLayout = NO;
    helper = [[WebServices alloc] initWithDelegate:self];
     userinfo = [SaveUserInfo loadCustomObjectWithKey];
    
    //给导航栏加一个返回按钮
    UIButton *leftbackBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [leftbackBtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
    [leftbackBtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateSelected];
    [leftbackBtn  addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    leftbackBtn.selected = YES;
    
    //给导航栏加右侧按钮
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame=CGRectMake(0, 0, 40, 40);
    rightBtn.selected=YES;
    [rightBtn setTitle:@"发送" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftButtonitem  = [[UIBarButtonItem alloc] initWithCustomView:leftbackBtn];
    self.navigationItem.leftBarButtonItem=leftButtonitem;
    UIBarButtonItem *righButtonitemt  = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem=righButtonitemt;

    
    
   UILabel *contactwayLB =  [[UILabel alloc]initWithFrame:CGRectMake(15,15, 70, 30)];
    contactwayLB.font = [UIFont fontWithName:@"Helvetica" size:14];
    contactwayLB.textColor = [UIColor blackColor];
    contactwayLB.text = @"联系方式:";

    
   contactwayTF = [[UITextField alloc]initWithFrame:CGRectMake(15, contactwayLB.frame.origin.y+35, KScreenWidth-30, 30)];
    contactwayTF.borderStyle=UITextBorderStyleRoundedRect;
    contactwayTF.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"kuang"]];
    //设置全部清除按钮，永远显示
    contactwayTF.clearButtonMode=UITextFieldViewModeAlways;
    //设置文字内容垂直居中
    contactwayTF.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    contactwayTF.text=userinfo.data.phone;
    contactwayTF.delegate=self;
    contactwayTF.enabled=YES;
    contactwayTF.returnKeyType=UIReturnKeyDone;
    contactwayTF.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    
    
    UILabel *contentLB =  [[UILabel alloc]initWithFrame:CGRectMake(15,contactwayTF.frame.origin.y+35, 70, 30)];
    contentLB.font = [UIFont fontWithName:@"Helvetica" size:14];
    contentLB.textColor = [UIColor blackColor];
    contentLB.text = @"提问内容:";
    
    
    //输入框
    inputTV = [[UITextView alloc]init];
    inputTV.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"dakuang"]];
    //inputTV.text = @"请在这里输入您宝贵的意见";
    inputTV.textColor = [UIColor darkGrayColor];
    inputTV.frame = CGRectMake(15, contentLB.frame.origin.y+30, KScreenWidth-30, 140);
    inputTV.layer.cornerRadius = 3.f;
    inputTV.delegate=self;
   // inputTV.returnKeyType=UIReturnKeyDone;

    
    [self.view addSubview:contactwayLB];
    [self.view addSubview:contactwayTF];
    [self.view addSubview:contentLB];
    [self.view addSubview:inputTV];
    
}


#pragma mark - NavigationBack Delegate
-(void)backClick:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - NavigationRightButton Delegate
-(void)rightBtnAction:(id)sender{
   
    
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    BOOL isPhone = [phoneTest evaluateWithObject:contactwayTF.text];
    
    if ([contactwayTF.text isEqualToString:@""])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入您的联系方式" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles: nil];
        [alert show];
        return;
    }else if([inputTV.text isEqualToString:@""] )
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"提问内容不能为空" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles: nil];
        [alert show];
        return;
    }else if (!isPhone)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请填写正确的手机号码！" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles: nil];
        [alert show];
        return;
    }else
    {
        [self postAskQuestion];
    }

    ZWLog(@"完成");
}


-(void)postAskQuestion{
    [MBProgressHUD showMessage:@"加载中..." toView:self.view];//显示动画
    WebServices *helper1 = [[WebServices alloc] init];
    
    LoginInfoModel *model = [SaveUserInfo loadCustomObjectWithKey];
    LoginInfoData *data = model.data;
    
    NSMutableArray *arr=[NSMutableArray array];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:data.dataIdentifier,@"u_Id", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:contactwayTF.text,@"phone", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:inputTV.text,@"content", nil]];
    
    
      __weak AskQuestionController *wself = self;
    NSString *soapMsg = [SoapHelper arrayToDefaultSoapMessage:arr methodName:InsertAskQuestionMethodName];
    //执行异步并取得结果
    [helper1 asyncServiceUrl:GetQAWebServiceUrl nameSpace:defaultWebServiceNameSpace methodName:InsertAskQuestionMethodName soapMessage:soapMsg withBlock:^(NSString *json, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:wself.view animated:YES];//移除动画
        if(![json isEqualToString:@""])
        {
            //返回的json字符串转换成NSDictionary
            NSData* jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
            NSMutableDictionary *resultsDictionary = [jsonData objectFromJSONData];
            
            UserModel *info = [[UserModel alloc] initWithDictionary:resultsDictionary];
            if (info.status == 0) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:info.msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                alertView.tag = 222222;
                
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

 - (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag ==222222) {
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



- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;{ //string就是此时输入的那个字符textField就是此时正在输入的那个输入框返回YES就是可以改变输入框的值NO相反
    if ([string isEqualToString:@"\n"]) //按会车可以改变
    {
        return YES;
        
    }
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    if (contactwayTF == textField) //判断是否时我们想要限定的那个输入框
    {
        if ([toBeString length] > 11) { //如果输入框内容大于20则弹出警告
            textField.text = [toBeString substringToIndex:11];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请输入11位手机号或昵称" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] ;
            [alert show];
            return NO;
        }
    } return YES;
}



//-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
//{
    //    if ([text isEqualToString:@"\n" ]) {
    //        [textView resignFirstResponder];
    //        return NO;
    //    }
    //    return YES;
    
    //    if (range.location >=10){
    //        return NO;
    //    }
    //    return YES;
    
    
//    //判断是否为删除字符，如果为删除则让执行
//    
//    if ([[textView text] length]>10)
//    {
//       UIAlertView *alertVirew  = [[UIAlertView alloc]initWithTitle:nil message:@"输入内容不得大于10" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
//        [self performSelector:@selector(dismissAlertView:) withObject:alertVirew afterDelay:0.2f];
//        [alertVirew show];
//        
//        return   NO;
//    }
//    else
//    {
//        textView.editable = YES;
//        return YES;
//    }
    /*
//    char c=[text UTF8String][0];
    if (c=='\000') {
        // inputTV.text=[NSString stringWithFormat:@"%d",30];
        return YES;
    }
    
    
    
    if([[textView text] length]>10){
        textView.text = [textView.text substringToIndex:10];
        return NO;
    }
    
    
    if([[textView text] length]==10) {
        if(![text isEqualToString:@"\b"])
            return NO;
    }
//    
    //inputTV.text=[NSString stringWithFormat:@"%d",30];
     
     */
    
    
//}

-(void)dismissAlertView:(UIAlertView *)alertView
{
    [alertView dismissWithClickedButtonIndex:[alertView cancelButtonIndex] animated:NO];
}

/*
- (void)textViewDidChange:(UITextView *)textView{
    
    NSLog(@"1213");
    
    
    if([[textView text] length]>10){
        textView.text = [textView.text substringToIndex:10];
    }
    
    
    
}
 
 */


//-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
//{
//    if ([text isEqualToString:@"\n"]) {
//        [textView resignFirstResponder];
//        return NO;
//    }
//    return YES;
//}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [inputTV resignFirstResponder];
    [contactwayTF resignFirstResponder];
}


@end
