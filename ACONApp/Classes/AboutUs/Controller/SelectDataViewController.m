//
//  SelectDataViewController.m
//  ACONApp
//
//  Created by fyf on 14/12/1.
//  Copyright (c) 2014年 zw. All rights reserved.
//

#import "SelectDataViewController.h"
#import "myBarButtonItem.h"



#define KCTaskSearchNavigationColor [UIColor colorWithRed:61/255.0 green:179/255.0 blue:232/255.0 alpha:1.0]



@interface myPicker2 ()
@end

@implementation myPicker2


@end


@interface SelectDataViewController ()
{
    
    UIButton *SubSetBeginTimeBtn; //设置开始时间按钮
    UIButton *SubSetOverTimeBtn; //设置结束时间按钮
    
    myBarButtonItem *cBtn; //pikerview上工具栏按钮
    
    myPicker2 *pickerViewTest;
    UIToolbar *_tb;
    
    NSDateFormatter *formatter; //Ly+
    NSDateFormatter *formatter1; //Ly+
    NSString *currentDateString;
    NSString *currentDateString1;
    
    
    UILabel *yearLB; //ToolBar上的年LB
    UILabel *monthLB; //ToolBar上的月LB
    UILabel *dayLB;//ToolBar上的日LB
}

@end

@implementation SelectDataViewController

+(id)shareIndence{
    SelectDataViewController *detailViewContrl2;
    @synchronized(self){
        detailViewContrl2 = [[SelectDataViewController alloc]init];
    }
    return detailViewContrl2;
}


- (void)viewDidLoad {
    [super viewDidLoad];
  
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"beijin"]];
    self.title = @"请选择日期";
    self.edgesForExtendedLayout = NO;
    
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

    
    
    
    UILabel *SetBeginTimeLB = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, 70, 30)];
    SetBeginTimeLB.text=@"开始时间";
    SetBeginTimeLB.textColor = [UIColor darkGrayColor];
    SetBeginTimeLB.textAlignment=NSTextAlignmentCenter;
    [SetBeginTimeLB sizeToFit];
    
    //添加分割线1
    UIImageView *Lineimage1 = [[UIImageView alloc]initWithFrame:CGRectMake(20, SetBeginTimeLB.frame.origin.y+40, KScreenWidth-30,1 )];
    Lineimage1.highlighted = YES;// flag
    Lineimage1.image = [UIImage imageNamed:@"xian"];
    
    
    UILabel *SetOverTimeLB = [[UILabel alloc]initWithFrame:CGRectMake(20, SetBeginTimeLB.frame.origin.y+60, 70, 30)];
    SetOverTimeLB.text=@"结束时间";
    SetOverTimeLB.textColor = [UIColor darkGrayColor];
    SetOverTimeLB.textAlignment=NSTextAlignmentCenter;
    [SetOverTimeLB sizeToFit];
    
    //添加分割线2
    UIImageView *Lineimage2 = [[UIImageView alloc]initWithFrame:CGRectMake(20, SetOverTimeLB.frame.origin.y+40, KScreenWidth-30,1 )];
    Lineimage2.highlighted = YES;// flag
    Lineimage2.image = [UIImage imageNamed:@"xian"];
    
    
    pickerViewTest  = [[myPicker2 alloc]init];
    _datePicker3 = [[UIDatePicker alloc] init];
    _datePicker2 = [[UIDatePicker alloc] init];
    
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
    [self.view addSubview:_tb];
    
    //调用系统时间
    NSString *date;
    NSDateFormatter *formatterDate = [[NSDateFormatter alloc]init];
    [formatterDate setDateFormat:@"yyyy-MM-dd"];
    date=[formatterDate stringFromDate:[NSDate date]];
    
    
    
    SubSetBeginTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    SubSetBeginTimeBtn.frame=CGRectMake(SetBeginTimeLB.frame.size.width+70, 16, 80, 30);
    SubSetBeginTimeBtn.tag=250250;
    [SubSetBeginTimeBtn setTitle:date forState:UIControlStateNormal];
    SubSetBeginTimeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [SubSetBeginTimeBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [SubSetBeginTimeBtn addTarget:self action:@selector(SubSetBeginTimeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    SubSetOverTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    SubSetOverTimeBtn.frame=CGRectMake(SubSetBeginTimeBtn.frame.origin.x,SubSetBeginTimeBtn.frame.origin.y
                                       +60, 80, 30);
    SubSetOverTimeBtn.tag=260260;
    [SubSetOverTimeBtn setTitle:date forState:UIControlStateNormal];
    SubSetOverTimeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [SubSetOverTimeBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [SubSetOverTimeBtn addTarget:self action:@selector(SubSetOverTimeBtnAction:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:SetBeginTimeLB];
    [self.view addSubview:SetOverTimeLB];
    [self.view addSubview:Lineimage1];
    [self.view addSubview:Lineimage2];
    [self.view addSubview:SubSetBeginTimeBtn];
    [self.view addSubview:SubSetOverTimeBtn];
   
}

#pragma mark -PikerView的工具栏按钮 Delegate
-(void)commitInput{
    
    _tb.hidden = YES;
    self.datePicker2.hidden =YES;
    self.datePicker3.hidden = YES;
}


#pragma  mark -UIPickerViewDataSource
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return  1;
}


#pragma mark -SubSetBeginTimeBtn Delegate
-(void)SubSetBeginTimeBtnAction:(id)sender{
  
    _tb.hidden = NO;
    
    yearLB.hidden = NO;
    monthLB.hidden = NO;
    dayLB.hidden = NO;
    
    [self.datePicker2 setHidden:NO];
    [self.datePicker2 setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.datePicker2];
    [self.datePicker2 setDatePickerMode:UIDatePickerModeDate];
    [self.datePicker2 addTarget:self action:@selector(SetBeginTimeBtnValueChangeData:) forControlEvents:UIControlEventValueChanged];
    [self.datePicker2 setFrame:CGRectMake(0, KScreenHeight-230, KScreenWidth, KScreenHeight-self.datePicker2.frame.origin.y-64)];
    [_tb setFrame:CGRectMake(0, self.datePicker2.frame.origin.y-40, KScreenWidth, 40)];
    [UIView commitAnimations];
}

#pragma mark -SubSetOverTimeBtn Delegate
-(void)SubSetOverTimeBtnAction:(id)sender{
    
    _tb.hidden = NO;
  
    yearLB.hidden = NO;
    monthLB.hidden = NO;
    dayLB.hidden = NO;
    
    
    //调用系统时间
    NSString *date;
    NSDateFormatter *formatterDate = [[NSDateFormatter alloc]init];
    [formatterDate setDateFormat:@"yyyy-MM-dd"];
    date=[formatterDate stringFromDate:[NSDate date]];
    NSDate *maxdata = [NSDate date];
    
    self.datePicker3.maximumDate = maxdata;
    [self.datePicker3 setHidden:NO];
    [self.datePicker3 setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.datePicker3];
    [self.datePicker3 setDatePickerMode:UIDatePickerModeDate];
    [self.datePicker3 addTarget:self action:@selector(SetOverTimeBtnValueChangeData:) forControlEvents:UIControlEventValueChanged];
    [self.datePicker3 setFrame:CGRectMake(0, KScreenHeight-230, KScreenWidth, KScreenHeight-self.datePicker3.frame.origin.y-64)];
    [_tb setFrame:CGRectMake(0, self.datePicker3.frame.origin.y-40, KScreenWidth, 40)];
    [UIView commitAnimations];
}


-(void)SetBeginTimeBtnValueChangeData:(id)sender{
    
        UIDatePicker *datePicker = (UIDatePicker*)sender;
        NSDate *date = [datePicker date];
        formatter  = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        currentDateString   = [formatter stringFromDate:date];
        [SubSetBeginTimeBtn setTitle:currentDateString forState:UIControlStateNormal];
    
    
}

-(void)SetOverTimeBtnValueChangeData:(id)sender{
    
        UIDatePicker *datePicker1 = (UIDatePicker*)sender;
        NSDate *date1 = [datePicker1 date];
        formatter1  = [[NSDateFormatter alloc]init];
        [formatter1 setDateFormat:@"yyyy-MM-dd"];
        currentDateString1  = [formatter1 stringFromDate:date1];
        [SubSetOverTimeBtn setTitle:currentDateString1 forState:UIControlStateNormal];
        

}

//键盘消失
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];// this will do the trick
    
    self.datePicker2.hidden = YES;
    self.datePicker3.hidden = YES;
    _tb.hidden = YES;
    
    yearLB.hidden = YES;
    monthLB.hidden = YES;
    dayLB.hidden = YES;
    
}




#pragma mark - Navigation backButton Delegate
-(void)backClick:(id)sender{
    
    NSLog(@"返回上一页");
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Navigation RightButton Delegate
-(void)rightBtnAction:(id)sender{
    NSLog(@"保存");
    //创建了两个日期对象
    NSDate *date1=[formatter dateFromString:currentDateString];
    NSDate *date2=[formatter1 dateFromString:currentDateString1];
    
    NSDateFormatter *formatter9 =[[NSDateFormatter alloc] init];
    [formatter9 setDateFormat:@"yyyy-MM-dd"];
    NSString *currentTime = [formatter9 stringFromDate:[NSDate date]];
    
    
    
    if(date1 ==nil &&date2 ==nil){
        date1 = date2 = [formatter9 dateFromString:currentTime];
        
    }
    else if(date1 == nil) {
        date1 = [formatter9 dateFromString:currentTime];
    }
    else if (date2 == nil)
    {
        date2 = [formatter9 dateFromString:currentTime];
    }
    
    //取两个日期对象的时间间隔：
    //这里的NSTimeInterval 并不是对象，是基本型，其实是double类型，是由c定义的:typedef double NSTimeInterval;
    NSTimeInterval time=[date2 timeIntervalSinceDate:date1];
    int days=((int)time)/(3600*24);
    //   int hours=((int)time)%(3600*24)/3600;
    NSString *dateContent=[[NSString alloc] initWithFormat:@"%i",days];
    
    
    if([dateContent integerValue]<0)
    {
        
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"开始时间不能大于结束时间！" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles: nil];
        [alertView show];
    }else
    {
        //调用这条通知并传递参数
        [[NSNotificationCenter defaultCenter] postNotificationName:@"senderData" object:dateContent];
        
        [self.navigationController popViewControllerAnimated:YES];
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
