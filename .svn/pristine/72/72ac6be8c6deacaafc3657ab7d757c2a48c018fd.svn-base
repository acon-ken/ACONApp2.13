//
//  BloodGlucosemeasurementController.m
//  ACONApp
//
//  Created by fyf on 14/11/27.
//  Copyright (c) 2014年 zw. All rights reserved.
//

#import "BloodGlucosemeasurementController.h"
#import "myBarButtonItem.h"

#import "DataListViewController.h"

#import "BloodGlucoseManageController.h"

#define KCTaskSearchNavigationColor [UIColor colorWithRed:61/255.0 green:179/255.0 blue:232/255.0 alpha:1.0]

@interface myPicker ()
@end

@implementation myPicker

@synthesize textField;

@end
@interface BloodGlucosemeasurementController ()<UIAlertViewDelegate>
{
    UIButton *emptystomachBtn; //空腹按钮
    UIButton *beforemealsBtn; //餐前按钮
    UIButton *aftermealBtn; //餐后按钮
    UIButton *RandomBtn; //随机按钮
    
    NSString *btnState;//四个按钮的状态
    
    
    UIButton *subBloodValueBtn; //设置血糖值按钮
   // UITextField *SubBloodvalueTF; //设置血糖值按钮
    UIButton *SubSetDateLB; //设置日期按钮
    UIButton *SubSetTimeLB; //设置时间Lable按钮
    
    
    UIButton *bloodcontrolBtn;//血糖控制按钮
    UIButton *remindmedicineBtn;//吃药提醒按钮
    UIImageView *Lineimage4;//添加分割线4
    
    myBarButtonItem *cBtn; //pikerview上工具栏按钮
    
    NSMutableArray*typeArray;
    myPicker *pickerViewTest;
    UIToolbar *_tb;
    
    
    UILabel *yearLB; //ToolBar上的年LB
    UILabel *monthLB; //ToolBar上的月LB
    UILabel *dayLB;//ToolBar上的日LB
    UILabel *HourLB;//ToolBar上的小时LB
    UILabel *minitLB;//ToolBar上的分钟LB
    
    int ClickStatic; //判断是否为系统时间 和 pickerview时间
    NSString *potimestr;//上传接口用到的时间字符串
    
    NSString *value;//picker选中行的值
}
@end

@implementation BloodGlucosemeasurementController

+(id)shareIndence{
    BloodGlucosemeasurementController *detailViewContrl;
    @synchronized(self){
        detailViewContrl = [[BloodGlucosemeasurementController alloc]init];
    }
    return detailViewContrl;
}

- (void)viewDidDisappear:(BOOL)animated
{
    ClickStatic =1;
    
    //调用系统时间
    NSDateFormatter *formatterDate = [[NSDateFormatter alloc]init];
    [formatterDate setDateFormat:@"HH:mm:ss"];
    potimestr=[formatterDate stringFromDate:[NSDate date]];
    
    [formatterDate setDateFormat:@"HH:mm"];
    [formatterDate stringFromDate:[NSDate date]];

    
    [SubSetTimeLB setTitle:[formatterDate stringFromDate:[NSDate date]] forState:UIControlStateSelected];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"血糖测量";
    self.view.backgroundColor = KBackgroundColor;
    
    self.navigationController.navigationBarHidden = NO;
    self.edgesForExtendedLayout = NO;
    
    helper = [[WebServices alloc] initWithDelegate:self];
    
    typeArray = [NSMutableArray array];
    for (int i = 6; i< 334; i ++) {
        NSString *value = [NSString stringWithFormat:@"%.1f",i *0.1];
        
        [typeArray addObject:value];
    }

    //ClickStatic状态为0时 取系统时间
    ClickStatic = 0;
    
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
    [rightBtn setTitle:@"保存" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftButtonitem  = [[UIBarButtonItem alloc] initWithCustomView:leftbackBtn];
    self.navigationItem.leftBarButtonItem=leftButtonitem;
    UIBarButtonItem *righButtonitemt  = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem=righButtonitemt;

    
    UILabel *BloodvalueLB = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, 70, 30)];
    BloodvalueLB.text=@"血糖数值";
    BloodvalueLB.textColor = [UIColor darkGrayColor];
    BloodvalueLB.textAlignment=NSTextAlignmentCenter;
    [BloodvalueLB sizeToFit];
    
    //添加分割线1
   UIImageView *Lineimage1 = [[UIImageView alloc]initWithFrame:CGRectMake(20, BloodvalueLB.frame.origin.y+40, KScreenWidth-30,1 )];
    Lineimage1.highlighted = YES;// flag
    Lineimage1.image = [UIImage imageNamed:@"xian"];
   
    
    UILabel *SetDateLB = [[UILabel alloc]initWithFrame:CGRectMake(20, KBorderH+60, 70, 30)];
    SetDateLB.text=@"设定日期";
    SetDateLB.textColor = [UIColor darkGrayColor];
    SetDateLB.textAlignment=NSTextAlignmentCenter;
    [SetDateLB sizeToFit];
    
    //添加分割线2
    UIImageView *Lineimage2 = [[UIImageView alloc]initWithFrame:CGRectMake(20, SetDateLB.frame.origin.y+40, KScreenWidth-30,1 )];
    Lineimage2.highlighted = YES;// flag
    Lineimage2.image = [UIImage imageNamed:@"xian"];
    
    
    UILabel *SetTimeLB = [[UILabel alloc]initWithFrame:CGRectMake(20, KBorderH+120, 70, 30)];
    SetTimeLB.text=@"设定时间";
    SetTimeLB.textColor = [UIColor darkGrayColor];
    SetTimeLB.textAlignment=NSTextAlignmentCenter;
    [SetTimeLB sizeToFit];
    
 
    //添加分割线3
    UIImageView *Lineimage3 = [[UIImageView alloc]initWithFrame:CGRectMake(20, SetTimeLB.frame.origin.y+40, KScreenWidth-30,1 )];
    Lineimage3.highlighted = YES;// flag
    Lineimage3.image = [UIImage imageNamed:@"xian"];
    
    UILabel *TimeslotLB = [[UILabel alloc]initWithFrame:CGRectMake(20, KBorderH+180, 70, 30)];
    TimeslotLB.text=@"时间段";
    TimeslotLB.textColor = [UIColor darkGrayColor];
    TimeslotLB.textAlignment=NSTextAlignmentCenter;
    [TimeslotLB sizeToFit];
    
    
    //添加分割线4
    Lineimage4 = [[UIImageView alloc]initWithFrame:CGRectMake(20, TimeslotLB.frame.origin.y+40, KScreenWidth-30,1 )];
    Lineimage4.highlighted = YES;// flag
    Lineimage4.image = [UIImage imageNamed:@"xian"];
    
    
    //输入的血糖值按钮
    subBloodValueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    subBloodValueBtn.frame=CGRectMake(KScreenWidth-180, 20, 80, 30);
//    subBloodValueBtn.selected=YES;
    [subBloodValueBtn setTitle:@" " forState:UIControlStateNormal];
    subBloodValueBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [subBloodValueBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [subBloodValueBtn addTarget:self action:@selector(subBloodValueBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    

    
    UIView *lineview = [[UIView alloc]initWithFrame:CGRectMake(subBloodValueBtn.frame.origin.x+20, CGRectGetMaxY(subBloodValueBtn.frame)-5, subBloodValueBtn.frame.size.width-15, 1)];
    lineview.backgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview:lineview];
    
    UILabel *CompanyLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(subBloodValueBtn.frame)+10, 25, 70, 30)];
    CompanyLB.text=@"mmol/L";
    CompanyLB.font = [UIFont systemFontOfSize:14];
    CompanyLB.textColor = [UIColor darkGrayColor];
    CompanyLB.textAlignment=NSTextAlignmentCenter;
    [CompanyLB sizeToFit];

    
    
    pickerViewTest  = [[myPicker alloc]init];
    pickerViewTest.delegate =self;
    //设置pickerView默认选中行
    [pickerViewTest selectRow:64 inComponent:0 animated:NO];

    _datePicker = [[UIDatePicker alloc] init];
    _datePicker5 = [[UIDatePicker alloc] init];
    
    _tb = [[UIToolbar alloc] init];
    
    //PickerView上面ToolBar的年份LB
    yearLB = [[UILabel alloc]initWithFrame:CGRectMake(KScreenWidth/2-89, 10, 40, 30)];
    yearLB.font = [UIFont boldSystemFontOfSize:17.0f];
    yearLB.textColor = [UIColor whiteColor];
    yearLB.text =@"年份";
    yearLB.hidden= YES;
    
    //PickerView上面ToolBar的月份LB
    monthLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(yearLB.frame)+30, yearLB.frame.origin.y, yearLB.frame.size.width, yearLB.frame.size.height)];
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
    
    //PickerView上面ToolBar的小时LB
    HourLB = [[UILabel alloc]initWithFrame:CGRectMake(105, yearLB.frame.origin.y, yearLB.frame.size.width+20, yearLB.frame.size.height)];
    HourLB.font = [UIFont boldSystemFontOfSize:17.0f];
    HourLB.textColor = [UIColor whiteColor];
    HourLB.text =@"小时";
    HourLB.hidden = YES;
    
    //PickerView上面ToolBar的分钟LB
    minitLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(HourLB.frame)+10, yearLB.frame.origin.y, yearLB.frame.size.width+20, yearLB.frame.size.height)];
    minitLB.font = [UIFont boldSystemFontOfSize:17.0f];
    minitLB.textColor = [UIColor whiteColor];
    minitLB.text =@"分钟";
    minitLB.hidden = YES;

    [_tb addSubview:yearLB];
    [_tb addSubview:monthLB];
    [_tb addSubview:dayLB];
    [_tb addSubview:HourLB];
    [_tb addSubview:minitLB];
    [_tb setBarStyle:UIBarStyleBlackOpaque];
    
    //设置ToolBar的背景色
    [_tb setBarTintColor:KCommonColor];
    
//    cBtn = [[myBarButtonItem alloc] init];
//    cBtn.tintColor = [UIColor whiteColor];
    
    myBarButtonItem *space = [[myBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    myBarButtonItem *iBtn = [[myBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleBordered target:self action:@selector(commitInput)];
    [iBtn setTintColor:[UIColor whiteColor]];
    [_tb setItems:[NSArray arrayWithObjects:/*cBtn,*/space,iBtn,nil]];
    [self.view addSubview:_tb];

    
    //调用系统日期
    NSString *datestr;
    NSDateFormatter *formatterDate1 = [[NSDateFormatter alloc]init];
    [formatterDate1 setDateFormat:@"yyyy-MM-dd"];
    datestr=[formatterDate1 stringFromDate:[NSDate date]];
    
    //调用系统时间
    NSString *timestr;
    NSDateFormatter *formatterDate = [[NSDateFormatter alloc]init];
    [formatterDate setDateFormat:@"HH:mm"];
    timestr=[formatterDate stringFromDate:[NSDate date]];

    
    SubSetDateLB = [UIButton buttonWithType:UIButtonTypeCustom];
    SubSetDateLB.frame=CGRectMake(KScreenWidth-138, KBorderH+60, 120, 30);
    SubSetDateLB.tag =1000000;
    [SubSetDateLB setTitle:datestr forState:UIControlStateNormal];
    SubSetDateLB.titleLabel.font = [UIFont systemFontOfSize:14];
    [SubSetDateLB setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [SubSetDateLB addTarget:self action:@selector(SubSetDateLBAction:) forControlEvents:UIControlEventTouchUpInside];

    SubSetTimeLB = [UIButton buttonWithType:UIButtonTypeCustom];
    SubSetTimeLB.frame=CGRectMake(KScreenWidth-120, KBorderH+120, 120, 30);
    SubSetTimeLB.tag =1000001;
    [SubSetTimeLB setTitle:timestr forState:UIControlStateNormal];
    SubSetTimeLB.titleLabel.font = [UIFont systemFontOfSize:14];
    [SubSetTimeLB setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [SubSetTimeLB addTarget:self action:@selector(SubSetTimeLBAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    emptystomachBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    emptystomachBtn.frame=CGRectMake(KScreenWidth-195, KBorderH+170, 40, 40);
    emptystomachBtn.selected=NO;
    emptystomachBtn.tag =6666;
    [emptystomachBtn setTitle:@"空腹" forState:UIControlStateNormal];
    emptystomachBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [emptystomachBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [emptystomachBtn setTitleColor:KCTaskSearchNavigationColor forState:UIControlStateSelected];
    [emptystomachBtn addTarget:self action:@selector(emptystomachBtnAction:) forControlEvents:UIControlEventTouchUpInside];

    beforemealsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    beforemealsBtn.frame=CGRectMake(emptystomachBtn.frame.origin.x+40, KBorderH+170, 40, 40);
    beforemealsBtn.selected=NO;
    beforemealsBtn.tag =7777;
    [beforemealsBtn setTitle:@"餐前" forState:UIControlStateNormal];
    beforemealsBtn.titleLabel.font = [UIFont systemFontOfSize:14];
     [beforemealsBtn setTitleColor:KCTaskSearchNavigationColor forState:UIControlStateSelected];
    [beforemealsBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [beforemealsBtn addTarget:self action:@selector(beforemealsBtnAction:) forControlEvents:UIControlEventTouchUpInside];

    aftermealBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    aftermealBtn.frame=CGRectMake(beforemealsBtn.frame.origin.x+40, KBorderH+170, 40, 40);
    aftermealBtn.selected=NO;
    aftermealBtn.tag =8888;
    [aftermealBtn setTitle:@"餐后" forState:UIControlStateNormal];
    aftermealBtn.titleLabel.font = [UIFont systemFontOfSize:14];
     [aftermealBtn setTitleColor:KCTaskSearchNavigationColor forState:UIControlStateSelected];
    [aftermealBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [aftermealBtn addTarget:self action:@selector(aftermealBtnAction:) forControlEvents:UIControlEventTouchUpInside];

    RandomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    RandomBtn.frame=CGRectMake(aftermealBtn.frame.origin.x
                               +40, KBorderH+170, 40, 40);
    RandomBtn.selected=YES;
    RandomBtn.tag =9999;
    [RandomBtn setTitle:@"随机" forState:UIControlStateNormal];
    RandomBtn.titleLabel.font = [UIFont systemFontOfSize:14];
     [RandomBtn setTitleColor:KCTaskSearchNavigationColor forState:UIControlStateSelected];
    [RandomBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [RandomBtn addTarget:self action:@selector(RandomBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:BloodvalueLB];
    [self.view addSubview:SetDateLB];
    [self.view addSubview:SetTimeLB];
    [self.view addSubview:TimeslotLB];
    [self.view addSubview:subBloodValueBtn];
    [self.view addSubview:CompanyLB];
    [self.view addSubview:SubSetDateLB];
    [self.view addSubview:SubSetTimeLB];
    [self.view addSubview:emptystomachBtn];
    [self.view addSubview:beforemealsBtn];
    [self.view addSubview:aftermealBtn];
    [self.view addSubview:RandomBtn];
     [self.view addSubview:Lineimage1];
    [self.view addSubview:Lineimage2];
    [self.view addSubview:Lineimage3];
     [self.view addSubview:Lineimage4];
    
    
    bloodcontrolBtn = [[UIButton alloc] initWithFrame:CGRectMake(KScreenWidth/4-20, TimeslotLB.frame.origin.y+150, 100, 35)];
    [bloodcontrolBtn setBackgroundImage:[UIImage imageNamed:@"queding"] forState:UIControlStateNormal];
    [bloodcontrolBtn setTitle:@"血糖控制" forState:UIControlStateNormal];
    [bloodcontrolBtn addTarget:self action:@selector(bloodcontrolBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    bloodcontrolBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [bloodcontrolBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    bloodcontrolBtn.selected = YES;
    [self.view addSubview:bloodcontrolBtn];

    
    
    remindmedicineBtn = [[UIButton alloc] initWithFrame:CGRectMake(bloodcontrolBtn.frame.origin.x+120, bloodcontrolBtn.frame.origin.y, 100, 35)];
    [remindmedicineBtn setBackgroundImage:[UIImage imageNamed:@"queding"] forState:UIControlStateNormal];
    [remindmedicineBtn setTitle:@"吃药提醒" forState:UIControlStateNormal];
    [remindmedicineBtn addTarget:self action:@selector(remindmedicineBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    remindmedicineBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [remindmedicineBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    remindmedicineBtn.selected = YES;
    [self.view addSubview:remindmedicineBtn];

    btnState = @"4";

}


#pragma  mark -UIPickerViewDataSource
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return  1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return  typeArray.count;
}
#pragma  mark -UIPickerViewDelegate
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return  [typeArray objectAtIndex:row];
}

#pragma mark - 代理
#pragma mark 选中了第component列第row行就会调用
// 只有手动选中了某一行才会通知代理
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //获取选中的列中的所在的行
    NSInteger index=[pickerViewTest selectedRowInComponent:0];
    //然后是获取这个行中的值，就是数组中的值
    value=[typeArray objectAtIndex:index];
    
    [subBloodValueBtn setTitle:value forState:UIControlStateNormal];
   


 }


#pragma mark - 血糖测量输入按钮
-(void)subBloodValueBtnAction:(id)sender{
    
    yearLB.hidden = YES;
    monthLB.hidden = YES;
    dayLB.hidden= YES;
    
    HourLB.hidden = YES;
    minitLB.hidden = YES;
    
    pickerViewTest.hidden = NO;
    _tb.hidden = NO;
    pickerViewTest.delegate  = self;
    pickerViewTest.dataSource= self;
    [pickerViewTest setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:pickerViewTest];
    [UIView beginAnimations:nil context:Nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.2];
    pickerViewTest.frame = CGRectMake(0, KScreenHeight-230, KScreenWidth, KScreenHeight-self.datePicker.frame.origin.y-64);
    [_tb setFrame:CGRectMake(0,pickerViewTest.frame.origin.y-40, KScreenWidth, 40)];
       [UIView commitAnimations];


}



#pragma mark -PikerView的工具栏按钮 Delegate
-(void)commitInput{
    
    if (value== nil) {
        [subBloodValueBtn setTitle:@"7.0" forState:UIControlStateNormal];
    }

    
    bloodcontrolBtn.hidden = NO;
    remindmedicineBtn.hidden = NO;
    
    
    _tb.hidden = YES;
    pickerViewTest.hidden =YES;
    self.datePicker.hidden = YES;
    self.datePicker5.hidden = YES;
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



#pragma mark -SubSetDateLB Delegate
-(void)SubSetDateLBAction:(id)sender{
    bloodcontrolBtn.hidden = YES;
    remindmedicineBtn.hidden = YES;
    
    _tb.hidden = NO;
    yearLB.hidden = NO;
    monthLB.hidden = NO;
    dayLB.hidden= NO;
    HourLB.hidden = YES;
    minitLB.hidden=YES;


//    [cBtn setTitle:@""];
//    [cBtn setEnabled:NO];
    [self.datePicker setHidden:NO];
    [self.datePicker setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.datePicker];
    [self.datePicker setDatePickerMode:UIDatePickerModeDate];
    [self.datePicker addTarget:self action:@selector(datePickerViewValueChangeData:) forControlEvents:UIControlEventValueChanged];
    [self.datePicker setFrame:CGRectMake(0, KScreenHeight-230, KScreenWidth, KScreenHeight-self.datePicker.frame.origin.y-64)];
    [_tb setFrame:CGRectMake(0,self.datePicker.frame.origin.y-40, KScreenWidth, 40)];
    [UIView commitAnimations];

}

#pragma mark -SubSetTimeLB Delegate
-(void)SubSetTimeLBAction:(id)sender{
    bloodcontrolBtn.hidden = YES;
    remindmedicineBtn.hidden = YES;
    
    _tb.hidden = NO;
    yearLB.hidden = YES;
    monthLB.hidden = YES;
    dayLB.hidden= YES;
    HourLB.hidden = NO;
    minitLB.hidden = NO;
    
 
//    [cBtn setTitle:@""];
//    [cBtn setEnabled:NO];
    [self.datePicker5 setHidden:NO];
    [self.datePicker5 setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.datePicker5];
    [self.datePicker5 setDatePickerMode:UIDatePickerModeTime];
    [self.datePicker5 addTarget:self action:@selector(datePickerViewValueChange:) forControlEvents:UIControlEventValueChanged];
    [self.datePicker5 setFrame:CGRectMake(0, KScreenHeight-230, KScreenWidth, KScreenHeight-self.datePicker5.frame.origin.y-64)];
    [_tb setFrame:CGRectMake(0,self.datePicker5.frame.origin.y-40, KScreenWidth, 40)];
    [UIView commitAnimations];
    
}

-(void)datePickerViewValueChangeData:(id)sender{
    
    UIDatePicker *datePicker = (UIDatePicker*)sender;
    NSDate *date = [datePicker date];
    NSDateFormatter *formatter  = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *currentDateString   = [formatter stringFromDate:date];
    [SubSetDateLB setTitle:currentDateString forState:UIControlStateNormal];
    
}

-(void)datePickerViewValueChange:(id)sender{
    
    //ClickStatic状态为1时 取picker设置的时间
    ClickStatic =1;
    
    UIDatePicker *datePicker = (UIDatePicker*)sender;
    NSDate *date = [datePicker date];
    NSDateFormatter *formatter  = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"HH:mm:ss"];
    potimestr   = [formatter stringFromDate:date];
    
    //截取pickerview里的时间字符串转化格式为HH:mm
    NSMutableString* string =[NSMutableString stringWithString:potimestr];
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:@"HH:mm:ss"];
    
    NSDate* inputDate = [inputFormatter dateFromString:string];
    [inputFormatter setDateFormat:@"HH:mm"];
    [inputFormatter stringFromDate:inputDate];
   
    
    [SubSetTimeLB setTitle:[inputFormatter stringFromDate:inputDate] forState:UIControlStateNormal];

}
#pragma mark -NavigationBackBtn Delegate
-(void)backClick:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - NavigationRightBtn Delegate
-(void)rightBtnAction:(id)sender{
    
    if (ClickStatic ==0) {
        //调用系统时间
        NSDateFormatter *formatterDate = [[NSDateFormatter alloc]init];
        [formatterDate setDateFormat:@"HH:mm:ss"];
        potimestr=[formatterDate stringFromDate:[NSDate date]];
    }
    
    if ([subBloodValueBtn.titleLabel.text isEqualToString:@" "])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"血糖数值不能为空" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles: nil];
        [alert show];
        return;
    }
    else if([SubSetDateLB.titleLabel.text isEqualToString:@""])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请设定日期" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles: nil];
        [alert show];
        return;
    }else if([SubSetTimeLB.titleLabel.text isEqualToString:@""])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请设定时间" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles: nil];
        [alert show];
        return;
    }
    else{
        [self insertData];
    }
    

}

#pragma mark - emptystomachBtn Delegate
-(void)emptystomachBtnAction:(id)sender{
   
//    [emptystomachBtn setTitleColor:KCTaskSearchNavigationColor forState:UIControlStateNormal];
    emptystomachBtn.selected = YES;
    
    aftermealBtn.selected = NO;
    beforemealsBtn.selected = NO;
    RandomBtn.selected = NO;

    
    [beforemealsBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [aftermealBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [RandomBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    
    btnState = @"3";
    

}

#pragma mark - beforemealsBtn Delegate
-(void)beforemealsBtnAction:(id)sender{
    
   // [beforemealsBtn setTitleColor:KCTaskSearchNavigationColor forState:UIControlStateNormal];
    beforemealsBtn.selected =YES;
    
   
    aftermealBtn.selected = NO;
    emptystomachBtn.selected = NO;
    RandomBtn.selected = NO;


    [emptystomachBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [aftermealBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [RandomBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    
    btnState = @"1";

    
}

#pragma mark - aftermealBtn Delegate
-(void)aftermealBtnAction:(id)sender{
    
  //  [aftermealBtn setTitleColor:KCTaskSearchNavigationColor forState:UIControlStateNormal];
    aftermealBtn.selected = YES;
    
    beforemealsBtn.selected = NO;
    emptystomachBtn.selected = NO;
    RandomBtn.selected = NO;
    
    [beforemealsBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [emptystomachBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [RandomBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];

    btnState = @"2";

    
}

#pragma mark - RandomBtn Delegate
-(void)RandomBtnAction:(id)sender{
    
  //  [RandomBtn setTitleColor:KCTaskSearchNavigationColor forState:UIControlStateNormal];
    RandomBtn.selected = YES;
    
    beforemealsBtn.selected = NO;
    emptystomachBtn.selected = NO;
    aftermealBtn.selected = NO;

    [aftermealBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [beforemealsBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [emptystomachBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];

    btnState = @"4";
    
}

#pragma mark - bloodcontrolBtn Delegate
-(void)bloodcontrolBtnAction:(id)sender{
    
    BloodGlucoseManageController *blooddd = [[BloodGlucoseManageController alloc]init];
    blooddd.selectBtn = NO;
    [self.navigationController pushViewController:blooddd animated:YES];
    
    
}


#pragma mark - remindmedicineBtn Delegate
-(void)remindmedicineBtnAction:(id)sender{
    
    BloodGlucoseManageController *blooddd = [[BloodGlucoseManageController alloc]init];
    blooddd.selectBtn = YES;
    [self.navigationController pushViewController:blooddd animated:YES];
    
}

//键盘消失
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
 
      [self.view endEditing:YES];// this will do the trick
  
    bloodcontrolBtn.hidden = NO;
    remindmedicineBtn.hidden = NO;
    
    self.datePicker5.hidden = YES;
    self.datePicker.hidden =YES;
    pickerViewTest.hidden = YES;
    _tb.hidden =YES;
    
    yearLB.hidden = YES;
    monthLB.hidden = YES;
    dayLB.hidden = YES;
    
    HourLB.hidden = YES;
    minitLB.hidden = YES;
}


/**
 *  手工输入
 */
- (void)insertData{
    
    [MBProgressHUD showMessage:@"加载中..." toView:self.view];//显示动画
    WebServices *service = [[WebServices alloc] init];
    LoginInfoModel *userinfo = [SaveUserInfo loadCustomObjectWithKey];
    
    NSString *sbJSON=[NSString stringWithFormat:@"{\"UserId\":\"%@\",\"MeasureTimeFormat\":\"%@\",\"MeasureValue\":\"%@\",\"PeriodType\":\"%@\"}",userinfo.data.dataIdentifier,[NSString stringWithFormat:@"%@ %@",SubSetDateLB.titleLabel.text,potimestr/*SubSetTimeLB.titleLabel.text*/],subBloodValueBtn.titleLabel.text,btnState];
    //1.空腹 2.
    
    NSMutableArray *arr=[NSMutableArray array];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:userinfo.data.dataIdentifier,@"u_Id", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:sbJSON,@"data", nil]];
    
    
    NSString *soapMsg = [SoapHelper arrayToDefaultSoapMessage:arr methodName:InsertGlucoseMethodName];
    [service asyncServiceUrl:GetGlucoseWebServiceUrl nameSpace:defaultWebServiceNameSpace methodName:InsertGlucoseMethodName soapMessage:soapMsg withBlock:^(NSString *json, NSError *error) {
    [MBProgressHUD hideHUDForView:self.view animated:YES];//移除动画
        if(![json isEqualToString:@""])
        {
            //返回的json字符串转换成NSDictionary
            NSData* jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
            NSMutableDictionary *resultsDictionary = [jsonData objectFromJSONData];
            
            NSString *status = [NSString stringWithFormat:@"%@",resultsDictionary[@"status"]];
            if ([status isEqualToString:@"0"])
            {
//                UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:resultsDictionary[@"msg"] delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles: nil];
//                [alertView show];
                
//                DataListViewController *datalist = [[DataListViewController alloc]init];
//                [self.navigationController pushViewController:datalist animated:YES];
                
                UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:resultsDictionary[@"msg"] delegate:self cancelButtonTitle:@"继续输入" otherButtonTitles: @"确定", nil];
                alertView.tag = 3214;
                [alertView show];
                
            }
            else
            {
                UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:resultsDictionary[@"msg"] delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles: nil];
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

    if (alertView.tag == 3214) {
        if (buttonIndex == 0) {
             [subBloodValueBtn setTitle:@" " forState:UIControlStateNormal];
           
            emptystomachBtn.selected  = YES;
            beforemealsBtn.selected = NO;
            aftermealBtn.selected = NO;
            RandomBtn.selected = NO;
            
            
            //调用系统日期
            NSString *datestr;
            NSDateFormatter *formatterDate = [[NSDateFormatter alloc]init];
            [formatterDate setDateFormat:@"yyyy-MM-dd"];
            datestr=[formatterDate stringFromDate:[NSDate date]];
            [SubSetDateLB setTitle:datestr forState:UIControlStateNormal];

            //调用系统时间
            NSString *timestr;
            NSDateFormatter *formatterDate2 = [[NSDateFormatter alloc]init];
            [formatterDate2 setDateFormat:@"HH:mm"];
            timestr=[formatterDate2 stringFromDate:[NSDate date]];
            [SubSetTimeLB setTitle:timestr forState:UIControlStateNormal];
           
        }
        else if (buttonIndex == 1){
        
            DataListViewController *datalist = [[DataListViewController alloc]init];
            [self.navigationController pushViewController:datalist animated:YES];
        }
    }
}

@end
