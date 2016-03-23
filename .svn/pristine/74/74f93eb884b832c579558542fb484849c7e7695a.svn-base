//
//  LoginViewController.m
//  ACONApp
//
//  Created by 朱红轻飞溅 on 14/11/25.
//  Copyright (c) 2014年 zw. All rights reserved.
//

#import "LoginViewController.h"
#import "NSString+Helper.h"
#import "KeyboardTool.h"
#import "RegisterViewController.h"
#import "PersonalViewController.h"
#import "OtherLoginBtn.h"
#import "MBProgressHUD+MJ.h"
#import "QQViewController.h"
#import "SinaViewController.h"
#import "ForgetpasswordController.h"
#import "HomeViewController.h"
#import "BindingViewController.h"



#import "LoginInfoModel.h"
#import "LoginInfoData.h"

#import "QQLoginModel.h"
#import "QQLoginData.h"
#import "OtherLoginModel.h"
#import "OtherLoginData.h"

#import "checkQQModel.h"
#import "checkQQData.h"

#import "CheckWbModel.h"
#import "CheckWbData.h"

#import <Parse/Parse.h>

#import "APService.h"

#import "AppDelegate.h"


@interface LoginViewController ()<UITextFieldDelegate, KeyboardToolDelegate>
{
    NSMutableArray *_fields; // 所有的文本输入框
    KeyboardTool* keyboardTool;
    UITextField *_focusedField; // 聚焦的文本框
    
    UIButton *checkbox;//记住密码按钮
    
    MBProgressHUD *progressTest;
    
    NSString *SinaNicknamestr;//新浪微博的昵称
    NSString *SinaUidstr; //新浪微博的账号ID
    NSString *TencentQQNicknamestr;//腾讯QQ的昵称
    NSString *TencentQQUidstr;//腾讯QQ的账号ID
    
    NSString *zhucestatic;//注册状态
    
    NSString *ThirdLoginPhonestr;//第三方登录手机号
    
    NSMutableArray *_shareTypeArray;
}
@end

@implementation LoginViewController
/**
 *  从文件中解析一个对象的时候就会调用这个方法
 */

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super initWithCoder:decoder]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
    
    //监听用户信息变更
    [ShareSDK addNotificationWithName:SSN_USER_INFO_UPDATE
                               target:self
                               action:@selector(userInfoUpdateHandler:)];
    
    _shareTypeArray = [[NSMutableArray alloc] init];
    
    NSArray *shareTypes = [ShareSDK connectedPlatformTypes];

       // NSNumber *typeNum = [shareTypes objectAtIndex:i];
        ShareType type = (ShareType)6;
      //  id<ISSPlatformApp> app = [ShareSDK getClientWithType:type];
        
        
//        if ( type == ShareTypeQQSpace )
//        {
            [_shareTypeArray addObject:[NSMutableDictionary dictionaryWithObject:[shareTypes objectAtIndex:4]
                                                                          forKey:@"type"]];
        //}
  //  }
    
//    NSArray *authList = [NSArray arrayWithContentsOfFile:[NSString stringWithFormat:@"%@/authListCache.plist",NSTemporaryDirectory()]];
//    if (authList == nil)
//    {
//        [_shareTypeArray writeToFile:[NSString stringWithFormat:@"%@/authListCache.plist",NSTemporaryDirectory()] atomically:YES];
//    }
//    else
//    {
//        for (int i = 0; i < [authList count]; i++)
//        {
//            NSDictionary *item = [authList objectAtIndex:i];
//            for (int j = 0; j < [_shareTypeArray count]; j++)
//            {
//                if ([[[_shareTypeArray objectAtIndex:j] objectForKey:@"type"] integerValue] == [[item objectForKey:@"type"] integerValue])
//                {
//                    [_shareTypeArray replaceObjectAtIndex:j withObject:[NSMutableDictionary dictionaryWithDictionary:item]];
//                    break;
//                }
//            }
//        }
//    }





    self.title = @"登录";
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"beijin"]];
    self.edgesForExtendedLayout = NO;
    self.navigationItem.hidesBackButton = YES;
    
    helper = [[WebServices alloc] initWithDelegate:self];
  
    // 间距
    CGFloat padding = 20;
    CGFloat allHeight = 30;
    //输入手机号

    _userNameText = [[UITextField alloc] initWithFrame:CGRectMake(padding, padding, KScreenWidth - 40, allHeight)];
    _userNameText.placeholder = @" 手机号";

  
    
    _userNameText.borderStyle = UITextBorderStyleRoundedRect;
    _userNameText.keyboardType = UIKeyboardTypePhonePad;
    _userNameText.clearButtonMode = UITextFieldViewModeAlways;
    _userNameText.delegate = self;
    _userNameText.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [self.view addSubview:_userNameText];
    
    //输入密码
    CGFloat passwordTextY = CGRectGetMaxY(_userNameText.frame) + padding;
    _passwordText = [[UITextField alloc] initWithFrame:CGRectMake(padding, passwordTextY, KScreenWidth - 40, allHeight)];
    _passwordText.placeholder = @" 密码";
    _passwordText.borderStyle = UITextBorderStyleRoundedRect;
    _passwordText.clearButtonMode = UITextFieldViewModeAlways;
    _passwordText.secureTextEntry = YES;
    _passwordText.leftViewMode = UITextFieldViewModeAlways;
    _passwordText.delegate = self;
    [self.view addSubview:_passwordText];
    
//    NSUserDefaults *defaults133 = [NSUserDefaults standardUserDefaults];
//    _userNameText.text= [defaults133 objectForKey:@"_userNameText"];

    NSDictionary *dict = [ArchiveAccessFile UnarchivedSuccessFileName:KAcount];
    _userNameText.text = [dict objectForKey:@"KEY"];
    
    //记住账号
    checkbox = [[UIButton alloc] init];
    checkbox.selected = YES;
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"记住账号" attributes:@{NSForegroundColorAttributeName : [UIColor grayColor],NSFontAttributeName : [UIFont systemFontOfSize:13]}];
    [checkbox setAttributedTitle:str forState:UIControlStateNormal];
    str = [[NSAttributedString alloc] initWithString:@"记住账号" attributes:@{NSForegroundColorAttributeName : [[UIColor alloc] initWithWhite:0.7 alpha:0.8],NSFontAttributeName : [UIFont systemFontOfSize:13]}];
    [checkbox setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [checkbox setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    CGFloat checkboxH = checkbox.currentImage.size.height;
    CGFloat checkboxY = CGRectGetMaxY(_passwordText.frame) + padding/2;
    checkbox.frame = CGRectMake(16, checkboxY, 120, checkboxH);
    [checkbox setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    checkbox.titleLabel.font = [UIFont systemFontOfSize:12];
    [checkbox addTarget:self action:@selector(checkboxClick:) forControlEvents:UIControlEventTouchUpInside];
    checkbox.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 15);
    checkbox.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 25);
    checkbox.tag = 104;
    [self.view addSubview:checkbox];
    
    //忘记密码
    UIButton *forgetBtn = [[UIButton alloc] initWithFrame:CGRectMake(KScreenWidth - 90, checkboxY, 80, 23)];
    NSAttributedString *str2 = [[NSAttributedString alloc] initWithString:@"忘记密码" attributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:0/255 green:0/255 blue:255/255 alpha:0.6],NSFontAttributeName : [UIFont systemFontOfSize:13],NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle)}];
    [forgetBtn setAttributedTitle:str2 forState:UIControlStateNormal];
    str = [[NSAttributedString alloc] initWithString:@"忘记密码" attributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:0/255 green:0/255 blue:255/255 alpha:0.6],NSFontAttributeName : [UIFont systemFontOfSize:13],NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle)}];
    [forgetBtn setAttributedTitle:str forState:UIControlStateHighlighted];
    forgetBtn.tag = 103;
    [forgetBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetBtn];
    
    //登陆
    CGFloat loginBtnY = CGRectGetMaxY(checkbox.frame) + padding;
    UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(padding, loginBtnY, KScreenWidth - 40, allHeight)];
    [loginBtn setTitle:@"登 录" forState:UIControlStateNormal];
    [loginBtn setTintColor:[UIColor whiteColor]];
    UIImage *normal = [UIImage imageNamed:@"queding"];
    UIImage *high = [UIImage imageNamed:@"aa"];
    loginBtn.tag = 101;
    [loginBtn setBackgroundImage:normal forState:UIControlStateNormal];
    [loginBtn setBackgroundImage:high forState:UIControlStateHighlighted];
    [loginBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    //注册
    CGFloat registerBtnY = CGRectGetMaxY(loginBtn.frame) + padding/2;
    UIButton *registerBtn = [[UIButton alloc] initWithFrame:CGRectMake(KScreenWidth - 150, registerBtnY, 130, 23)];
    NSAttributedString *str3 = [[NSAttributedString alloc] initWithString:@"还没有账号，立即注册" attributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:0/255 green:0/255 blue:255/255 alpha:0.6],NSFontAttributeName : [UIFont systemFontOfSize:13],NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle)}];
    [registerBtn setAttributedTitle:str3 forState:UIControlStateNormal];
    str = [[NSAttributedString alloc] initWithString:@"还没有账号，立即注册" attributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:0/255 green:0/255 blue:255/255 alpha:0.6],NSFontAttributeName : [UIFont systemFontOfSize:13],NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle)}];
    [registerBtn setAttributedTitle:str forState:UIControlStateHighlighted];
    registerBtn.tag = 102;
    [registerBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];
    
    // 4.监听系统发出的键盘通知
    [self addKeyboardNote];
    if (IS_IPHONE_4) {
        [self addKeyboardTool];
    }
    
    //qq登陆按钮
    OtherLoginBtn* QQLogin = [[OtherLoginBtn alloc] init];
    CGFloat QQLoginX = padding;
    CGFloat QQLoginY = CGRectGetMaxY(registerBtn.frame) + padding;
    CGFloat QQLoginW = (KScreenWidth - padding*3)/2;
    CGFloat QQLoginH = allHeight;
    QQLogin.frame = CGRectMake(QQLoginX, QQLoginY, QQLoginW, QQLoginH);
    [QQLogin addOtherLoginBtnTitle:@"用QQ账号登录" IconImage:@"QQ_01" DividerImage:@"xian"];
    [QQLogin addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClickQQ:)]];
    [self.view addSubview:QQLogin];
    
    //新浪账号
    OtherLoginBtn* SinaLogin = [[OtherLoginBtn alloc] init];
    CGFloat SinaLoginX = QQLoginW + padding*2;
    CGFloat SinaLoginY = QQLoginY;
    CGFloat SinaLoginW = QQLoginW;
    CGFloat SinaLoginH = QQLoginH;
    SinaLogin.frame = CGRectMake(SinaLoginX, SinaLoginY, SinaLoginW, SinaLoginH);
    [SinaLogin addOtherLoginBtnTitle:@"用新浪账号登录" IconImage:@"xinlang" DividerImage:@"xian"];
    [SinaLogin addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClickSina:)]];
    [self.view addSubview:SinaLogin];
    
    //在整个View上面添加手势
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClickView:)]];

}
//点击除了文本框以外的任何地方，退出键盘（编辑）
- (void)tapClickView:(UITapGestureRecognizer *)recognizer
{
    for (UIView *child in self.view.subviews) {
        // 如果是文本输入框
        if (![child isKindOfClass:[UITextField class]])
            [self.view endEditing:YES];
    }
}
- (void)tapClickQQ:(UITapGestureRecognizer *)recognizer
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    
    NSMutableDictionary *item = [_shareTypeArray objectAtIndex:0];
    
            
            //用户用户信息
            ShareType type = (ShareType)[[item objectForKey:@"type"] integerValue];
            
            id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                                 allowCallback:YES
                                                                 authViewStyle:SSAuthViewStyleFullScreenPopup
                                                                  viewDelegate:nil
                                                       authManagerViewDelegate:appDelegate.viewDelegate];
            
//            //在授权页面中添加关注官方微博
//            [authOptions setFollowAccounts:[NSDictionary dictionaryWithObjectsAndKeys:
//                                            [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"ShareSDK"],
//                                            SHARE_TYPE_NUMBER(ShareTypeSinaWeibo),
//                                            [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"ShareSDK"],
//                                            SHARE_TYPE_NUMBER(ShareTypeTencentWeibo),
//                                            nil]];
    
            [ShareSDK getUserInfoWithType:type
                              authOptions:authOptions
                                   result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
                                       if (result)
                                       {
                                           
                                           [self postcheckQQ];
                                           NSLog(@"userInfo%@",userInfo);
                                           
                                           [item setObject:[userInfo nickname] forKey:@"username"];
                                           [_shareTypeArray writeToFile:[NSString stringWithFormat:@"%@/authListCache.plist",NSTemporaryDirectory()] atomically:YES];
                                       }
                                     //  NSLog(@"%ld:%@",(long)[error errorCode], [error errorDescription]);
                                       
                                   }];
    
    

    
    
    
//    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
//                                                         allowCallback:YES
//                                                         authViewStyle:SSAuthViewStyleFullScreenPopup
//                                                          viewDelegate:nil
//                                               authManagerViewDelegate:appDelegate.viewDelegate];
//
//    //QQ登录
//    if ([TencentOAuth iphoneQQInstalled]){
//        [ShareSDK getUserInfoWithType:ShareTypeQQSpace
//                          authOptions:nil
//                               result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
//                                   [progressTest hide:YES];
//                                   if (result)
//                                   {
//                                    //   [self reloadStateWithType:ShareTypeQQSpace];
//                                       
//                                       NSLog(@"%@",userInfo);
//                                       PFQuery *query = [PFQuery queryWithClassName:@"UserInfo"];
//                                       [query whereKey:@"uid" equalTo:[userInfo uid]];
//                                       
//                                       NSLog(@"%@",[userInfo uid]);
//                                       NSLog(@"%@",[userInfo nickname]);
//                                       
//                                       TencentQQNicknamestr= [NSString stringWithFormat:@"%@",[userInfo nickname]];
//                                       TencentQQUidstr = [NSString stringWithFormat:@"%@",[userInfo uid]];
//                                       
//                                        [self postcheckQQ];
//                                     
//                                       
//                                   }else{
//                                       NSLog(@"失败,错误码:%ld,错误描述:%@", (long)[error errorCode], [error errorDescription]);
//                                       
//                                       [AppDelegate shareAppDelegate].progressTest = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//                                       [AppDelegate shareAppDelegate].progressTest.labelText = @"QQ没有登录成功";
//                                       [AppDelegate shareAppDelegate].progressTest.mode = MBProgressHUDModeText;
//                                       [[AppDelegate shareAppDelegate].progressTest showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
//                                   }
//                               }];
//    }else{
//        [progressTest hide:YES];
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您的手机没有安装手机QQ客户端，无法授权登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
//        [alert show];
//    }
    
}

- (void)tapClickSina:(UITapGestureRecognizer *)recognizer
{
    progressTest = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    progressTest.mode = MBProgressHUDModeIndeterminate;//可以显示不同风格的进度；
    
    
    //新浪微博登录
    [ShareSDK getUserInfoWithType:ShareTypeSinaWeibo authOptions:nil result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
        [progressTest hide:YES];
        NSLog(@"————%d",result);
        if (result) {
            //成功登录后，判断该用户的ID是否在自己的数据库中。
            //如果有直接登录，没有就将该用户的ID和相关资料在数据库中创建新用户。
          //  [self reloadStateWithType:ShareTypeSinaWeibo];
            
            
            
            PFQuery *query = [PFQuery queryWithClassName:@"UserInfo"];
            [query whereKey:@"uid" equalTo:[userInfo uid]];
            
            NSLog(@"%@",[userInfo uid]);
            NSLog(@"%@",[userInfo nickname]);
            SinaNicknamestr= [NSString stringWithFormat:@"%@",[userInfo nickname]];
            SinaUidstr = [NSString stringWithFormat:@"%@",[userInfo uid]];
            
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                
                    [self postcheckWb];
            
            }];
        }else{
            [AppDelegate shareAppDelegate].progressTest = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            [AppDelegate shareAppDelegate].progressTest.labelText = @"微博没有登录成功";
            [AppDelegate shareAppDelegate].progressTest.mode = MBProgressHUDModeText;
            [[AppDelegate shareAppDelegate].progressTest showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
        }
    }];
}




- (void)userInfoUpdateHandler:(NSNotification *)notif
{
    NSInteger plat = [[[notif userInfo] objectForKey:SSK_PLAT] integerValue];
    id<ISSPlatformUser> userInfo = [[notif userInfo] objectForKey:SSK_USER_INFO];
    
    for (int i = 0; i < [_shareTypeArray count]; i++)
    {
        NSMutableDictionary *item = [_shareTypeArray objectAtIndex:i];
        ShareType type = (ShareType)[[item objectForKey:@"type"] integerValue];
        if (type == plat)
        {
            [item setObject:[userInfo nickname] forKey:@"username"];
            [item setObject:[userInfo uid] forKey:@"uid"];
            
            TencentQQNicknamestr= [NSString stringWithFormat:@"%@",[userInfo nickname]];
            TencentQQUidstr = [NSString stringWithFormat:@"%@",[userInfo uid]];

       
        }
    }
    
    
    
}







-(void)getUserInfoResponse:(APIResponse *)response{
    
    
}
-(void)addKeyboardNote
{
    NSNotificationCenter* center = [NSNotificationCenter defaultCenter];
    //显示键盘
    [center addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //隐藏键盘
    [center addObserver:self selector:@selector(keyboardWillHiden:) name:UIKeyboardWillHideNotification object:nil];
}
//显示新键盘就会调用
-(void)keyboardWillShow:(NSNotification *)note
{
    // 1.取得当前聚焦文本框最下面的Y值
    CGFloat filedMaxY = CGRectGetMaxY(_focusedField.frame);
    //2.取出键盘的高度
    CGFloat keyboardH = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    //3.控制器view的高度 － 键盘的高度
    CGFloat keyboardY = self.view.frame.size.height - keyboardH;
    //4.比较文本框最大y 和 键盘的y
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    if (duration <= 0.0) {
        duration = 0.25;
    }
    [UIView animateWithDuration:duration animations:^{
        if (filedMaxY > keyboardY) {
            self.view.transform = CGAffineTransformMakeTranslation(0, keyboardY - filedMaxY - 10);
        }else {
            self.view.transform = CGAffineTransformIdentity;
        }
    }];
    
}
//隐藏键盘时调用
-(void)keyboardWillHiden:(NSNotification *)note
{
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.view.transform = CGAffineTransformIdentity;
     }];
}
//取消通知
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [ShareSDK removeNotificationWithName:SSN_USER_INFO_UPDATE target:self];
}



-(void)addKeyboardTool
{
    // 1.加载xib创建工具条
    keyboardTool = [[NSBundle mainBundle] loadNibNamed:@"KeyboardTool" owner:nil options:nil][0];
    keyboardTool.delegate = self;
    // 设置键盘顶部显示的工具条
    _userNameText.inputAccessoryView = keyboardTool;
    _passwordText.inputAccessoryView = keyboardTool;
    
    // 3.遍历控制器view所有的子控件，找出文本框控件
    for (UIView *child in self.view.subviews) {
        // 如果是文本输入框
        if ([child isKindOfClass:[UITextField class]]) {
            UITextField *field = (UITextField *)child;
            
            field.inputAccessoryView = keyboardTool; // 设置工具条
            field.delegate = self; // 设置代理
            
            // 增加文本框
            [_fields addObject:field];
        }
    }
    
    // 4.对所有的文本框控件进行排序
    [_fields sortUsingComparator:^NSComparisonResult(UITextField *obj1, UITextField *obj2) {
        /*
         NSOrderedAscending = -1L, // 右边的对象排后面
         NSOrderedSame, // 一样
         NSOrderedDescending // 左边的对象排后面
         */
        
        CGFloat obj1Y = obj1.frame.origin.y;
        CGFloat obj2Y = obj2.frame.origin.y;
        
        if (obj1Y > obj2Y) { // obj1排后面
            return NSOrderedDescending;
        } else { // obj1排前面
            return NSOrderedAscending;
        }
    }];

}
#pragma mark 点击了工具条上面的按钮就会调用
- (void)keyboardTool:(KeyboardTool *)keyboardTool itemClick:(KeyboardToolItemType)itemType
{
    if (itemType == KeyboardToolItemTypeDone) {// 完成
        [self.view endEditing:YES];
    } else { // 上一个\下一个
        // 拿到前面\后面的一个文本框，让它成为第一响应者
        NSInteger index = [_fields indexOfObject:_focusedField];
        
        if (itemType == KeyboardToolItemTypeNext) {
            index++;
        } else {
            index--;
        }
        
        [_fields[index] becomeFirstResponder];
    }
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    // 判断当前聚焦的文本框是否为最前面或者最后面的文本框
    NSInteger index = [_fields indexOfObject:textField];
    // 如果不是第0个文本框，“上一个”可以被点击
    keyboardTool.previousItem.enabled = index != 0;
    // 如果不是最后一个文本框，“下一个”可以被点击
    keyboardTool.nextItem.enabled = index != (_fields.count - 1);
}

- (void)checkboxClick:(UIButton *)checkboxxx
{
    checkboxxx.selected = !checkboxxx.isSelected;
    if (checkboxxx.isSelected)
    {
//        NSString *str=_userNameText.text;
//        NSDictionary *dict1 = @{@"KEY" :str};
//        [ArchiveAccessFile ArchiveSuccessData:dict1 fileName:KAcount];

//        [self btnAction:checkbox];
    }else
    {
  
         [ArchiveAccessFile DeleteArchiveFileName:KAcount];
    }
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _userNameText) {
        [_passwordText becomeFirstResponder];
        
    } else {
        [self userLoginAndRegister];
    }
    return YES;
}

-(void)btnAction:(UIButton *)sender{
    switch (sender.tag) {
        case 101:{
            [self userLoginAndRegister];

        }
            break;
        case 102:{
            RegisterViewController *reg = [[RegisterViewController alloc] init];
            [self.navigationController pushViewController:reg animated:YES];
        }
            break;
        case 103:{
            NSLog(@"忘记密码！！！！");
           ForgetpasswordController *forgetpassword = [[ForgetpasswordController alloc]init];
           [self.navigationController pushViewController:forgetpassword animated:YES];
        }
        case 104:{
            NSLog(@"记住账号");
          
//            NSUserDefaults *defaults133 = [NSUserDefaults standardUserDefaults];
//            _userNameText.text= [defaults133 objectForKey:@"_userNameText"];
            
//            NSDictionary *dict = [ArchiveAccessFile UnarchivedSuccessFileName:KAcount];
//            _userNameText.text = [dict objectForKey:@"KEY"];
            
        }
            break;
        default:
            break;
    }
}


/**
 *  登陆请求
 */
- (void)postLogin{
    
    [MBProgressHUD showMessage:@"加载中..." toView:self.view];//显示动画
    WebServices *helper1 = [[WebServices alloc] init];
    [APService registrationID];
    NSMutableArray *arr=[NSMutableArray array];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:_userNameText.text,@"phone", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:[ToolView md5:_passwordText.text],@"passWord", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:[APService registrationID],@"regPushId", nil]];
   
    
    __weak LoginViewController *wself = self;
    NSString *soapMsg = [SoapHelper arrayToDefaultSoapMessage:arr methodName:OnLoginMethodName];
      //执行异步并取得结果
        [helper1 asyncServiceUrl:UserInfoWebServiceUrl nameSpace:defaultWebServiceNameSpace methodName:OnLoginMethodName soapMessage:soapMsg withBlock:^(NSString *json, NSError *error) {
            [MBProgressHUD hideHUDForView:wself.view animated:YES];//移除动画
        if(![json isEqualToString:@""])
        {
            //返回的json字符串转换成NSDictionary
            NSData* jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
            NSMutableDictionary *resultsDictionary = [jsonData objectFromJSONData];
            
            LoginInfoModel *info=[[LoginInfoModel alloc]initWithDictionary:resultsDictionary];
            if (info.status==0)
            {
                
                
                
//                NSUserDefaults *defaults11 = [NSUserDefaults standardUserDefaults];
//                [defaults11 setObject:str forKey:@"_userNameText"];
//                [defaults11 synchronize];
           
                if (checkbox.selected ==YES)
                {
                    NSString *str=_userNameText.text;
                    NSDictionary *dict1 = @{@"KEY" :str};
                    [ArchiveAccessFile ArchiveSuccessData:dict1 fileName:KAcount];
                }else
                {
                    [ArchiveAccessFile DeleteArchiveFileName:KAcount];
                }

                
                
                [SaveUserInfo saveCustomObject:info];
            
            
                
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



- (void)userLoginAndRegister{

    [self.view endEditing:YES];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *myEncodedObject = [defaults objectForKey:@"111"];
    myEncodedObject=nil;
    
    
    [defaults setObject:myEncodedObject forKey:@"111"];
    [defaults synchronize];

    
    
    //删除数据列表页面本地的currenttimerstr、secondSwitchStatusstr、timerString数据
    NSString *bloodData1 =  [[NSUserDefaults standardUserDefaults] objectForKey:@"currenttimerstr"];
    bloodData1 = nil;
    NSUserDefaults *bloodDatadefaults1 = [NSUserDefaults standardUserDefaults];
    [bloodDatadefaults1 setObject:bloodData1 forKey:@"currenttimerstr"];
    [bloodDatadefaults1 synchronize];
    
    NSString *bloodData2 =  [[NSUserDefaults standardUserDefaults] objectForKey:@"secondSwitchStatusstr"];
    bloodData2 = nil;
    NSUserDefaults *bloodDatadefaults2 = [NSUserDefaults standardUserDefaults];
    [bloodDatadefaults2 setObject:bloodData2 forKey:@"secondSwitchStatusstr"];
    [bloodDatadefaults2 synchronize];
    
    
    NSString *bloodData3 =  [[NSUserDefaults standardUserDefaults] objectForKey:@"timerString"];
    bloodData3 = nil;
    NSUserDefaults *bloodDatadefaults3 = [NSUserDefaults standardUserDefaults];
    [bloodDatadefaults3 setObject:bloodData3 forKey:@"timerString"];
    [bloodDatadefaults3 synchronize];
    
    //删除饼状图页面本地的currenttimerstr、secondSwitchStatusstr、timerString数据
    NSString *bloodData4 =  [[NSUserDefaults standardUserDefaults] objectForKey:@"Piecurrenttimerstr"];
    bloodData4 = nil;
    NSUserDefaults *bloodDatadefaults4 = [NSUserDefaults standardUserDefaults];
    [bloodDatadefaults4 setObject:bloodData4 forKey:@"Piecurrenttimerstr"];
    [bloodDatadefaults4 synchronize];
    
    NSString *bloodData5 =  [[NSUserDefaults standardUserDefaults] objectForKey:@"PiesecondSwitchStatusstr"];
    bloodData5 = nil;
    NSUserDefaults *bloodDatadefaults5 = [NSUserDefaults standardUserDefaults];
    [bloodDatadefaults5 setObject:bloodData5 forKey:@"PiesecondSwitchStatusstr"];
    [bloodDatadefaults5 synchronize];
    
    
    NSString *bloodData6 =  [[NSUserDefaults standardUserDefaults] objectForKey:@"PietimerString"];
    bloodData6 = nil;
    NSUserDefaults *bloodDatadefaults6 = [NSUserDefaults standardUserDefaults];
    [bloodDatadefaults6 setObject:bloodData6 forKey:@"PietimerString"];
    [bloodDatadefaults6 synchronize];

    

//    //清空空白的字符串
//    self.userNameText.text = [self.userNameText.text trimString];
//    self.passwordText.text = [self.passwordText.text trimString];
    
    if ([self.userNameText.text isEqualToString:@""]) {
        // 帐号不存在
        [MBProgressHUD showError:@"帐号不存在"];
        return;
    }
    
    if ([self.passwordText.text isEqualToString:@""]) {
        // 密码错误
        [MBProgressHUD showError:@"密码错误"];
        return;
    }
    
//    // 显示一个蒙版(遮盖)
//    [MBProgressHUD showMessage:@"哥正在帮你加载中...."];
    
    // 发送网络请求
    [self postLogin];
    
//    // 模拟(1秒后执行跳转)
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        // 移除遮盖
//        [MBProgressHUD hideHUD];
//        
//        // 跳转 -- 执行login2contacts这个segue
//        PersonalViewController* personal = [[PersonalViewController alloc] init];
//        [self.navigationController pushViewController:personal animated:YES];
//    });
}

- (void)myTask {
    sleep(1);
}


//查询QQ用户是否注册
-(void)postcheckQQ{
    [MBProgressHUD showMessage:@"登录中..." toView:self.view];//显示动画
    WebServices *helper2 = [[WebServices alloc] init];

    NSMutableArray *arr=[NSMutableArray array];
    
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:TencentQQUidstr,@"qqNo", nil]];

    __weak LoginViewController *wself = self;
    NSString *soapMsg = [SoapHelper arrayToDefaultSoapMessage:arr methodName:GetUserInfoForQqMethodName];
    //执行异步并取得结果
   
    [helper2 asyncServiceUrl:UserInfoWebServiceUrl nameSpace:defaultWebServiceNameSpace methodName:GetUserInfoForQqMethodName soapMessage:soapMsg withBlock:^(NSString *json, NSError *error) {
        [MBProgressHUD hideHUDForView:wself.view animated:YES];//移除动画
        if(![json isEqualToString:@""])
        {
            //返回的json字符串转换成NSDictionary
            NSData* jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
            NSMutableDictionary *resultsDictionary = [jsonData objectFromJSONData];
            
            checkQQModel *info=[[checkQQModel alloc]initWithDictionary:resultsDictionary];
            if (info.status==0)
            {
                zhucestatic = @"没有注册";
                [wself OtherQQLogin];
            }
            else
            {
                if ([info.data.phone isEqualToString:@""]) {
                    
                    zhucestatic = @"没有注册";
                    BindingViewController *bingdingview = [[BindingViewController alloc]init];
                    bingdingview.userid = info.data.dataIdentifier;
                    [wself.navigationController pushViewController:bingdingview animated:YES];
                }
                else
                {
                    zhucestatic = @"已经注册";
                    LoginInfoModel *userinfo = [SaveUserInfo loadCustomObjectWithKey];
                    if (userinfo == nil) {
                        userinfo = [[LoginInfoModel alloc] init];
                    }
                    LoginInfoData *userinfodata = userinfo.data;
                    if (userinfodata == nil) {
                        userinfodata = [[LoginInfoData alloc] init];
                    }
                    
                    userinfo.status = 0;
                    userinfo.msg =info.msg;
                    userinfodata.qQ = info.data.qQ;
                    userinfodata.userName =info.data.userName;
                    userinfodata.loginName = info.data.loginName;
                    userinfodata.passWord = info.data.passWord;
                    userinfodata.dataIdentifier = info.data.dataIdentifier;
                    userinfodata.regPushId = info.data.regPushId;
                    userinfodata.portraitURL = info.data.portraitURL;
                    userinfodata.phone = info.data.phone;
                    userinfodata.isVisible = info.data.isVisible;
                    userinfodata.addDate = info.data.addDate;
                    userinfodata.remark = info.data.remark;
                    //userinfodata.isAllowFllow =(BOOL)info.data.isAllowFllow;
                    userinfodata.loginNameGrap = info.data.loginNameGrap;
                    userinfodata.imageUrl = info.data.imageUrl;
                    userinfodata.birthday=info.data.birthday;
                    userinfodata.bloodType=info.data.bloodType;
                    userinfodata.sex=info.data.sex;
                    userinfodata.height = info.data.height;
                    userinfodata.weight=info.data.weight;
                    userinfodata.weiBoNo=info.data.weiBoNo;
                    userinfodata.userInfoIp = info.data.userInfoIp;
                    
                    
                    
                    userinfo.data = userinfodata;
                    [SaveUserInfo saveCustomObject:userinfo];
                    
//                    NSLog(@"%@",[SaveUserInfo loadCustomObjectWithKey]);
                    
//                    HomeViewController *home = [[HomeViewController alloc]init];
//                    [wself.navigationController pushViewController:home animated:YES];
                    
                    HomeViewController *root = [[HomeViewController alloc] init];
                    AKNavigationController *nav = [[AKNavigationController alloc]initWithRootViewController:root];
                    
                    
//                    wself.view.window.rootViewController = nav;
                    [UIApplication sharedApplication].keyWindow.rootViewController = nav;

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

//查询微博用户是否注册
-(void)postcheckWb{
    [MBProgressHUD showMessage:@"登录中..." toView:self.view];//显示动画
    WebServices *helper3 = [[WebServices alloc] init];

    NSMutableArray *arr=[NSMutableArray array];
   [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:SinaUidstr,@"wbNo", nil]];
    
     __weak LoginViewController *wself = self;
    
    NSString *soapMsg = [SoapHelper arrayToDefaultSoapMessage:arr methodName:GetUserInfoForWbMethodName];
    //执行异步步并取得结果
    [helper3 asyncServiceUrl:UserInfoWebServiceUrl nameSpace:defaultWebServiceNameSpace methodName:GetUserInfoForWbMethodName soapMessage:soapMsg withBlock:^(NSString *json, NSError *error) {
        [MBProgressHUD  hideHUDForView:wself.view animated:YES];//移除动画

        if(![json isEqualToString:@""])
        {
            //返回的json字符串转换成NSDictionary
            NSData* jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
            NSMutableDictionary *resultsDictionary = [jsonData objectFromJSONData];
            
            CheckWbModel *info=[[CheckWbModel alloc]initWithDictionary:resultsDictionary];
            
            if (info.status==0)
            {
                
                // 没有注册去注册第三方账号
                [wself OtherWeiboLogin];
                
            }
            else
            {
                if ([info.data.phone isEqualToString:@""] ) {
                    zhucestatic = @"没有注册";
                    
                    BindingViewController *bingdingview = [[BindingViewController alloc]init];
                    bingdingview.userid = info.data.dataIdentifier;
                    [wself.navigationController pushViewController:bingdingview animated:YES];
                    
                }
                else
                {
                    zhucestatic = @"已经注册";
                    LoginInfoModel *userinfo = [SaveUserInfo loadCustomObjectWithKey];
                    if (userinfo == nil) {
                        userinfo = [[LoginInfoModel alloc] init];
                    }
                    LoginInfoData *userinfodata = userinfo.data;
                    if (userinfodata == nil) {
                        userinfodata = [[LoginInfoData alloc] init];
                    }
                    
                    userinfo.status = 0;
                    userinfo.msg =info.msg;
                    userinfodata.qQ = info.data.qQ;
                    userinfodata.userName =info.data.userName;
                    userinfodata.loginName = info.data.loginName;
                    userinfodata.passWord = info.data.passWord;
                    userinfodata.dataIdentifier = info.data.dataIdentifier;
                    userinfodata.regPushId = info.data.regPushId;
                    userinfodata.portraitURL = info.data.portraitURL;
                    userinfodata.phone = info.data.phone;
                    userinfodata.isVisible = info.data.isVisible;
                    userinfodata.addDate = info.data.addDate;
                    userinfodata.remark = info.data.remark;
                    //userinfodata.isAllowFllow = info.data.isAllowFllow;
                    userinfodata.loginNameGrap = info.data.loginNameGrap;
                    userinfodata.imageUrl = info.data.imageUrl;
                    userinfodata.birthday=info.data.birthday;
                    userinfodata.bloodType=info.data.bloodType;
                    userinfodata.sex=info.data.sex;
                    userinfodata.height = info.data.height;
                    userinfodata.weight=info.data.weight;
                    userinfodata.weiBoNo=info.data.weiBoNo;
                    userinfodata.userInfoIp =info.data.userInfoIp;
                    
                    
                    
                    userinfo.data = userinfodata;
                    [SaveUserInfo saveCustomObject:userinfo];
                    
                 
                    HomeViewController *home = [[HomeViewController alloc]init];
                    [wself.navigationController pushViewController:home animated:YES];
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


#pragma mark 第三方QQ登录注册请求
- (void)OtherQQLogin{
    [MBProgressHUD showMessage:@"第三方QQ注册中..." toView:self.view];//显示动画
    WebServices *helper4 = [[WebServices alloc] init];
    
    [APService registrationID];
    NSMutableArray *arr=[NSMutableArray array];
    
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:TencentQQNicknamestr,@"qqNc", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:TencentQQUidstr,@"qqNo", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:[APService registrationID],@"regPushId", nil]];
    
    __weak LoginViewController *wself = self;
    
    NSString *soapMsg = [SoapHelper arrayToDefaultSoapMessage:arr methodName:OnRegistQqMethodName];
    //执行异步并取得结果
    [helper4 asyncServiceUrl:UserInfoWebServiceUrl nameSpace:defaultWebServiceNameSpace methodName:OnRegistQqMethodName soapMessage:soapMsg withBlock:^(NSString *json, NSError *error) {
       [MBProgressHUD hideAllHUDsForView:wself.view animated:YES];//移除动画
        if(![json isEqualToString:@""])
        {
            //返回的json字符串转换成NSDictionary
            NSData* jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
            NSMutableDictionary *resultsDictionary = [jsonData objectFromJSONData];
            
            QQLoginModel *info=[[QQLoginModel alloc]initWithDictionary:resultsDictionary];
            if (info.status==0)
            {
                LoginInfoModel *userinfo = [SaveUserInfo loadCustomObjectWithKey];
                if (userinfo == nil) {
                    userinfo = [[LoginInfoModel alloc] init];
                }
                LoginInfoData *userinfodata = userinfo.data;
                if (userinfodata == nil) {
                    userinfodata = [[LoginInfoData alloc] init];
                }
                
                userinfo.status = 0;
                userinfo.msg =info.msg;
                userinfodata.qQ = info.data.qQ;
                userinfodata.userName =info.data.userName;
                userinfodata.loginName = info.data.loginName;
                userinfodata.passWord = info.data.passWord;
                userinfodata.dataIdentifier = info.data.dataIdentifier;
                userinfodata.regPushId = info.data.regAppId;
                userinfodata.portraitURL = info.data.portraitURL;
                userinfodata.phone = info.data.phone;
                userinfodata.isVisible = info.data.isVisible;
                userinfodata.addDate = info.data.addDate;
                userinfodata.remark = info.data.remark;
                userinfodata.isAllowFllow = @"";
                userinfodata.loginNameGrap = @"";
                userinfodata.imageUrl = @"";
                userinfodata.birthday=@"";
                userinfodata.bloodType=@"A";
                userinfodata.sex=1;
                userinfodata.height = @"";
                userinfodata.weight=@"";
                userinfodata.weiBoNo=@"";
                
                
                userinfo.data = userinfodata;
                [SaveUserInfo saveCustomObject:userinfo];
                
                
                BindingViewController *bingdingview = [[BindingViewController alloc]init];
                bingdingview.userid = info.data.dataIdentifier;
                [wself.navigationController pushViewController:bingdingview animated:YES];
                
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


#pragma mark 第三方微博登录注册请求
- (void)OtherWeiboLogin{
     [MBProgressHUD showMessage:@"第三方微博注册中..." toView:self.view];//显示动画
    WebServices *helper5 = [[WebServices alloc] init];
    
    [APService registrationID];
    NSMutableArray *arr=[NSMutableArray array];
    
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:SinaNicknamestr,@"wbNc", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:SinaUidstr,@"weiBoNo", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:[APService registrationID],@"regPushId", nil]];
    
     __weak LoginViewController *wself = self;
    NSString *soapMsg = [SoapHelper arrayToDefaultSoapMessage:arr methodName:OnRegistWeiBoMethodName];
    //执行异步并取得结果
     [helper5 asyncServiceUrl:UserInfoWebServiceUrl nameSpace:defaultWebServiceNameSpace methodName:OnRegistWeiBoMethodName soapMessage:soapMsg withBlock:^(NSString *json, NSError *error) {
          [MBProgressHUD hideAllHUDsForView:wself.view animated:YES];//移除动画
         if(![json isEqualToString:@""])
         {
             //返回的json字符串转换成NSDictionary
             NSData* jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
             NSMutableDictionary *resultsDictionary = [jsonData objectFromJSONData];
             
             OtherLoginModel *info=[[OtherLoginModel alloc]initWithDictionary:resultsDictionary];
             if (info.status==0)
             {
                 LoginInfoModel *userinfo = [SaveUserInfo loadCustomObjectWithKey];
                 if (userinfo == nil) {
                     userinfo = [[LoginInfoModel alloc] init];
                 }
                 LoginInfoData *userinfodata = userinfo.data;
                 if (userinfodata == nil) {
                     userinfodata = [[LoginInfoData alloc] init];
                 }
                 
                 userinfo.status = 0;
                 userinfo.msg =info.msg;
                 userinfodata.qQ = info.data.qQ;
                 userinfodata.userName =info.data.userName;
                 userinfodata.loginName = info.data.loginName;
                 userinfodata.passWord = info.data.passWord;
                 userinfodata.dataIdentifier = info.data.dataIdentifier;
                 userinfodata.regPushId = info.data.regAppId;
                 userinfodata.portraitURL = info.data.portraitURL;
                 userinfodata.phone = info.data.phone;
                 userinfodata.isVisible = info.data.isVisible;
                 userinfodata.addDate = info.data.addDate;
                 userinfodata.remark = info.data.remark;
                 userinfodata.isAllowFllow = @"";
                 userinfodata.loginNameGrap = @"";
                 userinfodata.imageUrl = @"";
                 userinfodata.birthday=@"";
                 userinfodata.bloodType=@"A";
                 userinfodata.sex=1;
                 userinfodata.height = @"";
                 userinfodata.weight=@"";
                 userinfodata.weiBoNo=@"";
                 
                 
                 userinfo.data = userinfodata;
                 [SaveUserInfo saveCustomObject:userinfo];
                 
                 
                 BindingViewController *bingdingview = [[BindingViewController alloc]init];
                 bingdingview.userid = info.data.dataIdentifier;
                 [wself.navigationController pushViewController:bingdingview animated:YES];
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


@end
