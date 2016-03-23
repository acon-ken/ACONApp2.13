//
//  PerfectPersonDataController.m
//  ACONApp
//
//  Created by fyf on 14/12/4.
//  Copyright (c) 2014年 zw. All rights reserved.
//

#import "PerfectPersonDataController.h"
#import "myBarButtonItem.h"

#import "LoginInfoModel.h"
#import "LoginInfoData.h"

#import "QRCodeGenerator.h"
#import "XHImageViewer.h"
#define DEF_SEX(sex)  (0==(sex))?@"男":@"女"


@interface myPicker4 ()

@end

@implementation myPicker4


@end

@interface PerfectPersonDataController ()<UIAlertViewDelegate,XHImageViewerDelegate>
{
    UIScrollView *scrollview;//在self.view上加了个滑动
    UITextField *useridTF;
    UITextField *usernameTF;
    //UITextField *sexTF;
    UIButton *sexbutton;
     UIButton *BirthdayBtn; //生日按钮
    UITextField *BirthdayTF;
    UITextField *ConnectphoneTF;
    UITextField *HeightTF;
    UITextField *WeightTF;
    //UITextField *BloodtypeTF;
    UIImageView *erweimaImage;
    UILabel *BloodtypeLB;
    UIButton *BloodtypeBtn;
    
    myBarButtonItem *cBtn; //pikerview上工具栏按钮
    
    NSMutableArray*typeArray;
    myPicker4 *pickerViewTest;
    UIToolbar *_tb;
 
    LoginInfoModel *userinfo;
    
    NSString *Clicksexstr;//点击按钮选择性别的字符串
    
    
    UILabel *yearLB; //ToolBar上的年LB
    UILabel *monthLB; //ToolBar上的月LB
    UILabel *dayLB;//ToolBar上的日LB
    
    NSMutableArray *logimageArr;
    
    int bloodBtnselectstate; //血型按钮选中状态
    
}
@end

@implementation PerfectPersonDataController

+(id)shareIndence{
    PerfectPersonDataController *detailViewContrl;
    @synchronized(self){
        detailViewContrl = [[PerfectPersonDataController alloc]init];
    }
    return detailViewContrl;
}


- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.title = @"完善个人资料";
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"beijin"]];
    self.edgesForExtendedLayout = NO;
    self.view.userInteractionEnabled = YES;
   
    bloodBtnselectstate = 0; //0为bloodBtn未选中,1为bloodBtn选中
    
    typeArray  = [NSMutableArray arrayWithObjects:@"0",@"1", nil];
    
    helper = [[WebServices alloc] initWithDelegate:self];
    
    userinfo= [SaveUserInfo loadCustomObjectWithKey];
    
    pickerViewTest  = [[myPicker4 alloc]init];
    _datePicker4= [[UIDatePicker alloc] init];
    
    _tb = [[UIToolbar alloc] init];
    
    //PickerView上面ToolBar的年份LB
    yearLB = [[UILabel alloc]initWithFrame:CGRectMake(70, 10, 40, 30)];
    yearLB.font = [UIFont boldSystemFontOfSize:17.0f];
    yearLB.textColor = [UIColor whiteColor];
    yearLB.text =@"年份";
    yearLB.hidden= YES;
    
    //PickerView上面ToolBar的月份LB
    monthLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(yearLB.frame)+38, yearLB.frame.origin.y, yearLB.frame.size.width, yearLB.frame.size.height)];
    monthLB.font = [UIFont boldSystemFontOfSize:17.0f];
    monthLB.textColor = [UIColor whiteColor];
    monthLB.text =@"月份";
    monthLB.hidden = YES;
    
    //PickerView上面ToolBar的日LB
    dayLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(monthLB.frame)+35, yearLB.frame.origin.y, yearLB.frame.size.width, yearLB.frame.size.height)];
    dayLB.font = [UIFont boldSystemFontOfSize:17.0f];
    dayLB.textColor = [UIColor whiteColor];
    dayLB.text =@"日";
    dayLB.hidden = YES;

    [_tb addSubview:yearLB];
    [_tb addSubview:monthLB];
    [_tb addSubview:dayLB];
    [_tb setBarStyle:UIBarStyleBlackOpaque];
    
    //设置ToolBar的背景色
    [_tb setBarTintColor:KCommonColor];
    
    cBtn = [[myBarButtonItem alloc] init];
    cBtn.tintColor = [UIColor whiteColor];
    
    myBarButtonItem *space = [[myBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    myBarButtonItem *iBtn = [[myBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleBordered target:self action:@selector(commitInput)];
    [iBtn setTintColor:[UIColor whiteColor]];
    [_tb setItems:[NSArray arrayWithObjects:cBtn,space,iBtn,nil]];

    scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    scrollview.delegate =self;
    scrollview.userInteractionEnabled = YES;
    scrollview.scrollEnabled = YES;
    scrollview.contentSize=CGSizeMake(0, scrollview.frame.size.height+100);
    scrollview.showsVerticalScrollIndicator = YES;
    scrollview.indicatorStyle=UIScrollViewIndicatorStyleWhite;
    [self.view addSubview:scrollview];
    
    [self.view addSubview:_tb];

    
    //给导航栏加一个返回按钮
    UIButton *leftbackBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [leftbackBtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
    [leftbackBtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateSelected];
    [leftbackBtn  addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    leftbackBtn.selected = YES;
    
    UIBarButtonItem *leftButtonitem  = [[UIBarButtonItem alloc] initWithCustomView:leftbackBtn];
    self.navigationItem.leftBarButtonItem=leftButtonitem;
    
    [self CreateContentView];
    
    //需要设置一个通知，获取系统的键盘显示和隐藏消息，然后做出位置改变的操作
    //这里的UIKeyboardWillShowNotification时系统自带的

    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardShow) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardHide) name:UIKeyboardWillHideNotification object:nil];
}

////点击Control1时（相对于用户就是点击其他地方），键盘隐藏
//-(void)hideKeyboard{
//    [useridTF resignFirstResponder];
//    [usernameTF resignFirstResponder];
//    [BirthdayTF resignFirstResponder];
//    [HeightTF resignFirstResponder];
//    [WeightTF resignFirstResponder];
//}
//键盘显示的时候，按钮向上跑，不会被遮盖
-(void)keyboardShow{
    
    if ([WeightTF isFirstResponder]) {
        
        scrollview.frame=CGRectMake(0,-50, KScreenWidth, KScreenHeight);
    }
    
}
//键盘隐藏是，按钮向下回到原先的位置
//这里面尝试一个动画，和没有动画，直接确定位置是一个效果，差不多
-(void)keyboardHide{
    [UIView animateWithDuration:0.25 animations:^{
        scrollview.frame=CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    }completion:^(BOOL finished){
        
    }];
}

-(void)hideenkebord
{
    [useridTF resignFirstResponder];
    [usernameTF resignFirstResponder];
    [BirthdayTF resignFirstResponder];
    [HeightTF resignFirstResponder];
    [WeightTF resignFirstResponder];
    
    self.datePicker4.hidden =YES;
    dropDown.hidden=YES;
    dropDown2.hidden =YES;
    _tb.hidden =YES;
    
    BloodtypeLB.hidden = NO;
    BloodtypeBtn.hidden  = NO;
    erweimaImage.hidden = NO;
    
    yearLB.hidden = YES;
    monthLB.hidden = YES;
    dayLB.hidden = YES;


}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
    
    [useridTF resignFirstResponder];
    [usernameTF resignFirstResponder];
    //[BirthdayTF resignFirstResponder];
    [HeightTF resignFirstResponder];
    [WeightTF resignFirstResponder];
    
    dropDown.hidden = YES;
    dropDown2.hidden = YES;
    
    self.datePicker4.hidden =YES;
    _tb.hidden =YES;
    
    BloodtypeLB.hidden = NO;
    BloodtypeBtn.hidden  = NO;
    erweimaImage.hidden = NO;
    
    yearLB.hidden = YES;
    monthLB.hidden = YES;
    dayLB.hidden = YES;
    
    


}

-(void)CreateContentView{
    
   
    
    
//    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideenkebord)];
//    [scrollview addGestureRecognizer:singleTap];


    UILabel *useridLB = [[UILabel alloc]initWithFrame:CGRectMake(40, 20, 70, 30)];
    useridLB.text=@"用户名:";
    useridLB.textColor = [UIColor blackColor];
    useridLB.font = [UIFont fontWithName:@"Helvetica" size:16];
    useridLB.textAlignment=NSTextAlignmentCenter;
    [useridLB sizeToFit];
    
    UILabel *usernameLB = [[UILabel alloc]initWithFrame:CGRectMake(useridLB.frame.origin.x+15, useridLB.frame.origin.y+40, 70, 30)];
    usernameLB.text=@"姓名:";
    usernameLB.textColor = [UIColor blackColor];
    usernameLB.font = [UIFont fontWithName:@"Helvetica" size:16];
    usernameLB.textAlignment=NSTextAlignmentCenter;
    [usernameLB sizeToFit];
    
    UILabel *sexLB = [[UILabel alloc]initWithFrame:CGRectMake(usernameLB.frame.origin.x, usernameLB.frame.origin.y+40, 70, 30)];
    sexLB.text=@"性别:";
    sexLB.textColor = [UIColor blackColor];
    sexLB.font = [UIFont fontWithName:@"Helvetica" size:16];
    sexLB.textAlignment=NSTextAlignmentCenter;
    [sexLB sizeToFit];
    
    UILabel *BirthdayLB = [[UILabel alloc]initWithFrame:CGRectMake(usernameLB.frame.origin.x, sexLB.frame.origin.y+40, 70, 30)];
    BirthdayLB.text=@"生日:";
    BirthdayLB.textColor = [UIColor blackColor];
    BirthdayLB.font = [UIFont fontWithName:@"Helvetica" size:16];
    BirthdayLB.textAlignment=NSTextAlignmentCenter;
    [BirthdayLB sizeToFit];
    
    UILabel *ConnectphoneLB = [[UILabel alloc]initWithFrame:CGRectMake(usernameLB.frame.origin.x-30, BirthdayLB.frame.origin.y+40, 70, 30)];
    ConnectphoneLB.text=@"联系电话:";
    ConnectphoneLB.textColor = [UIColor blackColor];
    ConnectphoneLB.font = [UIFont fontWithName:@"Helvetica" size:16];
    ConnectphoneLB.textAlignment=NSTextAlignmentCenter;
    [ConnectphoneLB sizeToFit];
    
    UILabel *HeightLB = [[UILabel alloc]initWithFrame:CGRectMake(usernameLB.frame.origin.x-42, ConnectphoneLB.frame.origin.y+40, 10, 30)];
    HeightLB.text=@"身高";
    HeightLB.textColor = [UIColor blackColor];
    HeightLB.font = [UIFont fontWithName:@"Helvetica" size:16];
    HeightLB.textAlignment=NSTextAlignmentCenter;
    [HeightLB sizeToFit];
    
    UILabel *HdanweiLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(HeightLB.frame), HeightLB.frame.origin.y+3, 10, 30)];
    HdanweiLB.text=@"(单位/cm)";
    HdanweiLB.textColor = [UIColor blackColor];
    HdanweiLB.font = [UIFont fontWithName:@"Helvetica" size:10];
    HdanweiLB.textAlignment=NSTextAlignmentLeft;
    [HdanweiLB sizeToFit];
    
    UILabel *maohao1LB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(HdanweiLB.frame), HeightLB.frame.origin.y, 10, 30)];
    maohao1LB.text=@":";
    maohao1LB.textColor = [UIColor blackColor];
    maohao1LB.font = [UIFont fontWithName:@"Helvetica" size:16];
    maohao1LB.textAlignment=NSTextAlignmentLeft;
    [maohao1LB sizeToFit];


    
    UILabel *WeightLB = [[UILabel alloc]initWithFrame:CGRectMake(usernameLB.frame.origin.x-39, HeightLB.frame.origin.y+40, 70, 30)];
    WeightLB.text=@"体重";
    WeightLB.textColor = [UIColor blackColor];
    WeightLB.font = [UIFont fontWithName:@"Helvetica" size:16];
    WeightLB.textAlignment=NSTextAlignmentCenter;
    [WeightLB sizeToFit];
    
    UILabel *WdanweiLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(WeightLB.frame), WeightLB.frame.origin.y+3, 10, 30)];
    WdanweiLB.text=@"(单位/kg)";
    WdanweiLB.textColor = [UIColor blackColor];
    WdanweiLB.font = [UIFont fontWithName:@"Helvetica" size:10];
    WdanweiLB.textAlignment=NSTextAlignmentLeft;
    [WdanweiLB sizeToFit];
    
    UILabel *maohao2LB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(WdanweiLB.frame), WeightLB.frame.origin.y, 10, 30)];
    maohao2LB.text=@":";
    maohao2LB.textColor = [UIColor blackColor];
    maohao2LB.font = [UIFont fontWithName:@"Helvetica" size:16];
    maohao2LB.textAlignment=NSTextAlignmentLeft;
    [maohao2LB sizeToFit];

    
    BloodtypeLB = [[UILabel alloc]initWithFrame:CGRectMake(usernameLB.frame.origin.x, WeightLB.frame.origin.y+40, 70, 30)];
    BloodtypeLB.text=@"血型:";
    BloodtypeLB.textColor = [UIColor blackColor];
    BloodtypeLB.font = [UIFont fontWithName:@"Helvetica" size:16];
    BloodtypeLB.textAlignment=NSTextAlignmentCenter;
    [BloodtypeLB sizeToFit];
    
    
    useridTF = [[UITextField alloc]initWithFrame:CGRectMake(useridLB.frame.origin.y+80, useridLB.frame.origin.y-5, KScreenWidth-130, 30)];
    useridTF.borderStyle=UITextBorderStyleRoundedRect;
    useridTF.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"baisekuang"]];
    //设置全部清除按钮，永远显示
    useridTF.clearButtonMode=UITextFieldViewModeAlways;
    //设置文字内容垂直居中
    useridTF.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    useridTF.delegate=self;
    useridTF.tag = 1000;
    useridTF.text=_userLoginname;
    useridTF.returnKeyType=UIReturnKeyDone;
    useridTF.keyboardType = UIKeyboardTypeNamePhonePad;
    
    
    usernameTF = [[UITextField alloc]initWithFrame:CGRectMake(useridTF.frame.origin.x, usernameLB.frame.origin.y-5, KScreenWidth-130, 30)];
    usernameTF.borderStyle=UITextBorderStyleRoundedRect;
    usernameTF.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"baisekuang"]];
    //设置全部清除按钮，永远显示
    usernameTF.clearButtonMode=UITextFieldViewModeAlways;
    //设置文字内容垂直居中
    usernameTF.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    usernameTF.delegate=self;
    usernameTF.tag = 1001;
    usernameTF.text =_username;
    usernameTF.returnKeyType=UIReturnKeyDone;
    usernameTF.keyboardType = UIKeyboardTypeNamePhonePad;
    
   //初始化性别字符串，将个人中心传过来的_usersex保存到sexstr中
    NSString *sexstr;
    if ([_usersex isEqualToString:@"0.0"]) {
        sexstr = @"女";
         Clicksexstr=@"0";
    }else if([_usersex isEqualToString:@"1.0"])
    {
     sexstr = @"男";
        Clicksexstr=@"1";
    }
   
    
   
    sexbutton = [[UIButton alloc] initWithFrame:CGRectMake(usernameTF.frame.origin.x, sexLB.frame.origin.y-5, KScreenWidth-130, 30)];
    [sexbutton setBackgroundImage:[UIImage imageNamed:@"baisekuang"] forState:UIControlStateNormal];
    [sexbutton setTitle:sexstr forState:UIControlStateNormal];
    sexbutton.tag=0;
    [sexbutton addTarget:self action:@selector(sexbuttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [sexbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    sexbutton.titleLabel.font = [UIFont systemFontOfSize:14];
    sexbutton.layer.borderWidth = 1;
    sexbutton.layer.borderColor = [IWColor(228, 228, 228) CGColor];
    sexbutton.layer.cornerRadius = 5;
    sexbutton.selected = YES;
    
    BirthdayBtn = [[UIButton alloc] initWithFrame:CGRectMake(sexbutton.frame.origin.x, BirthdayLB.frame.origin.y-5, KScreenWidth-130, 30)];
    [BirthdayBtn setBackgroundImage:[UIImage imageNamed:@"baisekuang"] forState:UIControlStateNormal];
    if ([_userbirthdaystr isEqualToString:@"(null)"]) {
         [BirthdayBtn setTitle:@"" forState:UIControlStateNormal];
    }
    [BirthdayBtn setTitle:_userbirthdaystr forState:UIControlStateNormal];
    [BirthdayBtn addTarget:self action:@selector(BirthdayBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [BirthdayBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    BirthdayBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    BirthdayBtn.layer.borderWidth = 1;
    BirthdayBtn.layer.borderColor = [IWColor(228, 228, 228) CGColor];
    BirthdayBtn.layer.cornerRadius = 5;

    
//    BirthdayTF = [[UITextField alloc]initWithFrame:CGRectMake(sexbutton.frame.origin.x, BirthdayLB.frame.origin.y-5, KScreenWidth-130, 30)];
//    BirthdayTF.borderStyle=UITextBorderStyleRoundedRect;
//    BirthdayTF.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"baisekuang"]];
//    //设置全部清除按钮，永远显示
//    BirthdayTF.clearButtonMode=UITextFieldViewModeAlways;
//    //设置文字内容垂直居中
//    BirthdayTF.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
//    BirthdayTF.delegate=self;
//    BirthdayTF.text=_userbirthdaystr;
//    BirthdayTF.tag = 1003;
//    BirthdayTF.returnKeyType=UIReturnKeyDone;
//    BirthdayTF.keyboardType = UIKeyboardTypeNamePhonePad;
   
    
    
    ConnectphoneTF = [[UITextField alloc]initWithFrame:CGRectMake(BirthdayBtn.frame.origin.x, ConnectphoneLB.frame.origin.y-5, KScreenWidth-130, 30)];
    ConnectphoneTF.borderStyle=UITextBorderStyleRoundedRect;
    ConnectphoneTF.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"baisekuang"]];
    //设置文字内容垂直居中
    ConnectphoneTF.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    //ConnectphoneTF.text = _userPhonestr;
    ConnectphoneTF.placeholder = _userPhonestr;
    ConnectphoneTF.enabled =NO;
    ConnectphoneTF.delegate=self;
    ConnectphoneTF.tag = 1004;

 
    
    HeightTF = [[UITextField alloc]initWithFrame:CGRectMake(ConnectphoneTF.frame.origin.x, HeightLB.frame.origin.y-5, KScreenWidth-130, 30)];
    HeightTF.borderStyle=UITextBorderStyleRoundedRect;
    HeightTF.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"baisekuang"]];
    //设置全部清除按钮，永远显示
    HeightTF.clearButtonMode=UITextFieldViewModeAlways;
    //设置文字内容垂直居中
    HeightTF.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    HeightTF.delegate=self;
    HeightTF.tag = 1005;
    HeightTF.text = _userheightstr;
    HeightTF.returnKeyType=UIReturnKeyDone;
    HeightTF.keyboardType = UIKeyboardTypeNamePhonePad;
   
    
    
    WeightTF = [[UITextField alloc]initWithFrame:CGRectMake(HeightTF.frame.origin.x, WeightLB.frame.origin.y-5, KScreenWidth-130, 30)];
    WeightTF.borderStyle=UITextBorderStyleRoundedRect;
    WeightTF.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"baisekuang"]];
    //设置全部清除按钮，永远显示
    WeightTF.clearButtonMode=UITextFieldViewModeAlways;
    //设置文字内容垂直居中
    WeightTF.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    WeightTF.delegate=self;
    WeightTF.text = _userweightstr;
    WeightTF.tag = 1006;
    WeightTF.returnKeyType=UIReturnKeyDone;
    WeightTF.keyboardType = UIKeyboardTypeNamePhonePad;
    
    
    BloodtypeBtn = [[UIButton alloc] initWithFrame:CGRectMake(WeightTF.frame.origin.x, BloodtypeLB.frame.origin.y-5, KScreenWidth-130, 30)];
    [BloodtypeBtn setBackgroundImage:[UIImage imageNamed:@"baisekuang"] forState:UIControlStateNormal];
    [BloodtypeBtn setTitle:_useBloodTypestr forState:UIControlStateNormal];
    [BloodtypeBtn addTarget:self action:@selector(BloodtypeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [BloodtypeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    BloodtypeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    BloodtypeBtn.layer.borderWidth = 1;
    BloodtypeBtn.layer.borderColor = [IWColor(228, 228, 228) CGColor];
    BloodtypeBtn.layer.cornerRadius = 5;
    BloodtypeBtn.tag =05115;
    BloodtypeBtn.selected = YES;
  

  
    
   

    erweimaImage = [[UIImageView alloc]initWithFrame:CGRectMake(KScreenWidth/2 - 80, BloodtypeBtn.frame.origin.y+40, 160,160 )];
    erweimaImage.backgroundColor = [UIColor whiteColor];
    erweimaImage.highlighted = YES;// flag
    erweimaImage.image = [QRCodeGenerator qrImageForString:ConnectphoneTF.placeholder imageSize:320];
    erweimaImage.userInteractionEnabled = YES;
    
    logimageArr = [NSMutableArray arrayWithObject:erweimaImage];
    
    UITapGestureRecognizer *scrollviewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickLogImage:)];
    [erweimaImage addGestureRecognizer:scrollviewTap];
    
    //退出帐号按钮
    UIButton *CommitBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(erweimaImage.frame) +20, KScreenWidth-40, 35)];
    [CommitBtn setBackgroundImage:[UIImage imageNamed:@"queding"] forState:UIControlStateNormal];
    [CommitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [CommitBtn addTarget:self action:@selector(CommitBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    CommitBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [CommitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    CommitBtn.selected = YES;
    



    [scrollview addSubview:useridLB];
    [scrollview addSubview:usernameLB];
    [scrollview addSubview:sexLB];
    [scrollview addSubview:BirthdayLB];
    [scrollview addSubview:ConnectphoneLB];
    [scrollview addSubview:HeightLB];
    [scrollview addSubview:HdanweiLB];
    [scrollview addSubview:maohao1LB];
    [scrollview addSubview:WeightLB];
    [scrollview addSubview:WdanweiLB];
    [scrollview addSubview:maohao2LB];
    [scrollview addSubview:BloodtypeLB];
    
    [scrollview addSubview:useridTF];
    [scrollview addSubview:usernameTF];
    [scrollview addSubview:BirthdayBtn];
   // [scrollview addSubview:BirthdayTF];
    [scrollview addSubview:ConnectphoneTF];
    [scrollview addSubview:HeightTF];
    [scrollview addSubview:WeightTF];
    
    [scrollview addSubview:sexbutton];
    [scrollview addSubview:BloodtypeBtn];
    
    [scrollview addSubview:erweimaImage];
    [scrollview addSubview:CommitBtn];
    
    
}


#pragma mark 二维码图片点击放大
- (void)clickLogImage:(UITapGestureRecognizer *)sender
{
    XHImageViewer *imageViewer = [[XHImageViewer alloc] init];
    imageViewer.delegate = self;
    
    [useridTF resignFirstResponder];
    [usernameTF resignFirstResponder];
    [BirthdayTF resignFirstResponder];
    [HeightTF resignFirstResponder];
    [WeightTF resignFirstResponder];
    dropDown.hidden =YES;
    dropDown2.hidden = YES;

    
    [imageViewer showWithImageViews:logimageArr selectedView:(UIImageView *)sender.view];
    
}

#pragma mark -PikerView的工具栏按钮 Delegate
-(void)commitInput{
    
    BloodtypeLB.hidden = NO;
    BloodtypeBtn.hidden  = NO;
    erweimaImage.hidden = NO;

    _tb.hidden = YES;
    self.datePicker4.hidden = YES;
}


#pragma  mark - UITextFieldDelegate
-(void)BirthdayBtnAction:(UIButton *)sender{

//    if (textField.tag == 1003)
//    {
        //[textField resignFirstResponder];
        
        BloodtypeLB.hidden = YES;
        BloodtypeBtn.hidden  = YES;
        erweimaImage.hidden = YES;
        
        
        yearLB.hidden = NO;
        monthLB.hidden = NO;
        dayLB.hidden = NO;

        
        _tb.hidden = NO;
        [cBtn setTitle:@""];
        [cBtn setEnabled:NO];
        [self.datePicker4 setHidden:NO];
        [self.datePicker4 setBackgroundColor:[UIColor whiteColor]];
        [self.view addSubview:self.datePicker4];
        [self.datePicker4 setDatePickerMode:UIDatePickerModeDate];
        [self.datePicker4 addTarget:self action:@selector(datePickerViewValueChangeData:) forControlEvents:UIControlEventValueChanged];
        [self.datePicker4 setFrame:CGRectMake(0, KScreenHeight-230, KScreenWidth, KScreenHeight-self.datePicker4.frame.origin.y-64)];
        [_tb setFrame:CGRectMake(0,self.datePicker4.frame.origin.y-40, KScreenWidth, 40)];
        [UIView commitAnimations];
  // }
}


-(void)datePickerViewValueChangeData:(id)sender{
    
    UIDatePicker *datePicker = (UIDatePicker*)sender;
    NSDate *date = [datePicker date];
    NSDateFormatter *formatter  = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *currentDateString   = [formatter stringFromDate:date];
     [BirthdayBtn setTitle:currentDateString forState:UIControlStateNormal];
}



-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([textField isFirstResponder]) {
        
        [textField resignFirstResponder];
    }
    return YES;
    
}


//键盘消失
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];// this will do the trick
    
    self.datePicker4.hidden =YES;
    dropDown.hidden=YES;
    dropDown2.hidden =YES;
    _tb.hidden =YES;
    
    BloodtypeLB.hidden = NO;
    BloodtypeBtn.hidden  = NO;
    erweimaImage.hidden = NO;
    
    yearLB.hidden = YES;
    monthLB.hidden = YES;
    dayLB.hidden = YES;


}

//血型按钮代理
-(void)BloodtypeBtnAction:(id)sender{
    bloodBtnselectstate = 1;
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithObjects:@"A", @"B", @"AB", @"O",nil];
    if(dropDown == nil) {
        CGFloat f = 160;
        dropDown = [[PerfectDropDown alloc]showDropDown:sender :&f :arr];
        dropDown.delegate = self;

        
        [useridTF resignFirstResponder];
        [usernameTF resignFirstResponder];
        [BirthdayTF resignFirstResponder];
        [HeightTF resignFirstResponder];
        [WeightTF resignFirstResponder];
        
        self.datePicker4.hidden =YES;
       
        dropDown2.hidden =YES;
        _tb.hidden =YES;
        
        BloodtypeLB.hidden = NO;
        BloodtypeBtn.hidden  = NO;
        erweimaImage.hidden = NO;
        
        yearLB.hidden = YES;
        monthLB.hidden = YES;
        dayLB.hidden = YES;

    }
    else {
        [dropDown hideDropDown:sender];
        [self rel];
        
    }
}

//性别按钮代理
-(void)sexbuttonAction:(id)sender{
    
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithObjects:@"男", @"女",nil];
    if(dropDown2 == nil) {
        CGFloat f = 80;
        dropDown2 = [[PerfectDropDown2 alloc]showDropDown:sender :&f :arr];
        dropDown2.delegate = self;
    }
    else {
        [dropDown2 hideDropDown:sender];
        [self rel2];
    }

    
    
}


- (void) niDropDownDelegateMethod: (PerfectDropDown *) sender {
    [self rel];
}

- (void) niDropDownDelegateMethod2:(PerfectDropDown2 *)sender2 {
   
    Clicksexstr =[NSString stringWithFormat:@"%ld",(long)sender2.selectedindex];
    if ([Clicksexstr isEqualToString:@"0"]) {
        Clicksexstr=@"1";
    }else
        Clicksexstr=@"0";
   
   // sexbutton.tag=sender2.selectedindex;
   
    [self rel2];
}

-(void)rel{
    dropDown = nil;
}

-(void)rel2{
    dropDown2 = nil;
}


#pragma mark - Navigation backButton Delegate
-(void)backClick:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
    
}


//限制联系方式输入框输入的长度
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;{ //string就是此时输入的那个字符textField就是此时正在输入的那个输入框返回YES就是可以改变输入框的值NO相反
    if ([string isEqualToString:@"\n"]) //按会车可以改变
    {
        return YES;
        
    }
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    if (useridTF == textField) //判断是否时我们想要限定的那个输入框
    {
        if ([toBeString length] > 15) { //如果输入框内容大于20则弹出警告
            textField.text = [toBeString substringToIndex:11];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"用户名长度应为3～15位" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] ;
            [alert show];
            return NO;
        }
    }
    return YES;
    
    
}


#pragma mark -  提交按钮 Delegate
-(void)CommitBtnAction:(id)sender{
    NSLog(@"点击提交");
    
    
    if ([useridTF.text isEqualToString:@""])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"用户名不能为空" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles: nil];
        [alert show];
        return;
    }else if (useridTF.text.length<3){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"用户名长度应为3～15位" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles: nil];
                [alert show];
                return;

    }
    else if ([BirthdayBtn.titleLabel.text isEqualToString:@"(null)"])
    {
    
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"生日不能为空" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles: nil];
        [alert show];
        return;

    }
    
    else if([ConnectphoneTF.placeholder isEqualToString:@""])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"联系电话不能为空" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles: nil];
        [alert show];
        return;
    }
    else if([HeightTF.text isEqualToString:@""])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"身高不能为空" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles: nil];
        [alert show];
        return;
    }
    else if([WeightTF.text isEqualToString:@""])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"体重不能为空" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles: nil];
        [alert show];
        return;
    }
    else if ([HeightTF.text compare:@"100" options:NSNumericSearch] == NSOrderedAscending  || [HeightTF.text compare:@"300" options:NSNumericSearch] == NSOrderedDescending)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"身高应在100厘米到300厘米之间" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles: nil];
        [alert show];
    }
    else if ([WeightTF.text compare:@"1" options:NSNumericSearch] == NSOrderedAscending  || [WeightTF.text compare:@"1000" options:NSNumericSearch] == NSOrderedDescending)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"体重应在1到1000斤之间" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles: nil];
        [alert show];
    }



    else{

    
    [self postCommit];
    }

}

#pragma mark - 提交数据
-(void)postCommit{
   [MBProgressHUD showMessage:@"加载中..." toView:self.view];//显示动画
    WebServices *helper1 = [[WebServices alloc] init];
    
    LoginInfoModel *model = [SaveUserInfo loadCustomObjectWithKey];
    LoginInfoData *data = model.data;
    
    
    NSString *sbJSON=[NSString stringWithFormat:@"{\"LoginName\":\"%@\",\"UserName\":\"%@\",\"Sex\":\"%@\",\"Birthday\":\"%@\",\"Phone\":\"%@\",\"Height\":\"%@\",\"Weight\":\"%@\",\"BloodType\":\"%@\"}",useridTF.text,usernameTF.text,Clicksexstr,BirthdayBtn.titleLabel.text,ConnectphoneTF.placeholder,HeightTF.text,WeightTF.text,BloodtypeBtn.titleLabel.text];
    
    NSMutableArray *arr=[NSMutableArray array];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:data.dataIdentifier,@"u_id", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:sbJSON,@"data", nil]];
    

    __weak PerfectPersonDataController *wself = self;
    NSString *soapMsg = [SoapHelper arrayToDefaultSoapMessage:arr methodName:UpdateUserInfoMethodName];
    //执行异步并取得结果
    [helper1 asyncServiceUrl:UserInfoWebServiceUrl nameSpace:defaultWebServiceNameSpace methodName:UpdateUserInfoMethodName soapMessage:soapMsg withBlock:^(NSString *json, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:wself.view animated:YES];//移除动画

        if(![json isEqualToString:@""])
        {
            //返回的json字符串转换成NSDictionary
            NSData* jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
            NSMutableDictionary *resultsDictionary = [jsonData objectFromJSONData];
            
            UserModel *info = [[UserModel alloc] initWithDictionary:resultsDictionary];
            if (info.status == 0) {
                
                //            [SaveUserInfo deleteCustomObject];
                
                userinfo.status = info.status;
                userinfo.msg = info.msg;
                userinfo.data.loginName = useridTF.text;
                userinfo.data.userName = usernameTF.text;
                NSString *doubleSEXstring = [NSString stringWithFormat:@"%ld",(long)[Clicksexstr integerValue]];
                userinfo.data.sex =  [doubleSEXstring doubleValue];
                userinfo.data.birthday = BirthdayTF.text;
                userinfo.data.phone = ConnectphoneTF.placeholder;
                userinfo.data.height = HeightTF.text;
                userinfo.data.weight = WeightTF.text;
                userinfo.data.bloodType = BloodtypeBtn.titleLabel.text;
                
                //将要提交的数据存到userinfo里去
                [SaveUserInfo saveCustomObject:userinfo];
                
                
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:info.msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                alertView.tag = 789658888;
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

    if (alertView.tag==789658888) {
        if (buttonIndex==0) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc

{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
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
