//
//  UserDefinedViewController.m
//  ACONApp
//
//  Created by 朱红轻飞溅 on 14/12/10.
//  Copyright (c) 2014年 zw. All rights reserved.
//

#import "UserDefinedViewController.h"
#import "myBarButtonItem.h"

@interface myPickerA ()
@end

@implementation myPickerA

@synthesize textField;

@end


@interface UserDefinedViewController ()
{
    UIButton *beginBtn;
    UIButton *endBtn;
    
    myBarButtonItem *cBtn; //pikerview上工具栏按钮
    
    NSMutableArray*typeArray;
    myPickerA *pickerViewTest;
    UIToolbar *_tb;
}

@end

@implementation UserDefinedViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = KBackgroundColor;
    self.title = @"请选择日期";
    self.edgesForExtendedLayout = NO;
    _datePicker = [[UIDatePicker alloc] init];
    
    //给导航栏加一个返回按钮
    UIButton *leftbackBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [leftbackBtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
    [leftbackBtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateSelected];
    [leftbackBtn  addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    leftbackBtn.selected = YES;
    UIBarButtonItem *leftButtonitem  = [[UIBarButtonItem alloc] initWithCustomView:leftbackBtn];
    self.navigationItem.leftBarButtonItem=leftButtonitem;

    [self createMainView];
    
    
    pickerViewTest  = [[myPickerA alloc]init];
    _datePicker = [[UIDatePicker alloc] init];
    
    _tb = [[UIToolbar alloc] init];
    //    [_tb setFrame:CGRectMake(0, KcurrentViewSizeHeight, KcurrentViewSizeWidth, 40)];
    [_tb setBarStyle:UIBarStyleBlackOpaque];
    cBtn = [[myBarButtonItem alloc] init];
    cBtn.tintColor = [UIColor whiteColor];
    
    myBarButtonItem *space = [[myBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    myBarButtonItem *iBtn = [[myBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleBordered target:self action:@selector(commitInput)];
    [iBtn setTintColor:[UIColor whiteColor]];
    [_tb setItems:[NSArray arrayWithObjects:cBtn,space,iBtn,nil]];
    [self.view addSubview:_tb];


}

- (void)createMainView
{
    UIView *beginView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 50)];
    beginView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:beginView];
    
    beginBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, beginView.frame.size.height)];
    beginBtn.tag = 1001;
    [beginBtn setBackgroundColor:[UIColor clearColor]];
    [beginBtn setTitle:@"2014-10-30" forState:UIControlStateNormal];
    [beginBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [beginBtn addTarget:self action:@selector(SubSetDateLBAction:) forControlEvents:UIControlEventTouchUpInside];
    [beginView addSubview:beginBtn];
    
    UILabel *beginLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, beginBtn.frame.size.height)];
    beginLB.text = @"开始时间";
    beginLB.textColor = [UIColor grayColor];
    beginLB.textAlignment = NSTextAlignmentCenter;
    [beginBtn addSubview:beginLB];
    
    UIImageView *beginline = [[UIImageView alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(beginView.frame), KScreenWidth - 10, 1)];
    beginline.backgroundColor = [UIColor lightGrayColor];
    [beginView addSubview:beginline];
    
    //
    UIView *endView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(beginline.frame), KScreenWidth, 50)];
//    endView.backgroundColor = [UIColor redColor];
    [self.view addSubview:endView];
    
    endBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, endView.frame.size.height)];
    endBtn.tag = 2002;
    [endBtn setBackgroundColor:[UIColor clearColor]];
    [endBtn setTitle:@"2014-10-30" forState:UIControlStateNormal];
    [endBtn addTarget:self action:@selector(datePickerViewValueChangeData:) forControlEvents:UIControlEventTouchUpInside];
    [endBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [endView addSubview:endBtn];
    
    UILabel *endLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, beginBtn.frame.size.height)];
    endLB.text = @"结束时间";
    endLB.textColor = [UIColor grayColor];
    endLB.textAlignment = NSTextAlignmentCenter;
    [endBtn addSubview:endLB];
    
    UIImageView *endline = [[UIImageView alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(endBtn.frame), KScreenWidth - 10, 1)];
    endline.backgroundColor = [UIColor lightGrayColor];
    [endView addSubview:endline];
}

#pragma mark -SubSetDateLB Delegate
-(void)SubSetDateLBAction:(id)sender{
    
    [cBtn setTitle:@"请设置日期"];
    [cBtn setEnabled:NO];
    [self.datePicker setHidden:NO];
    [self.datePicker setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.datePicker];
    [self.datePicker setDatePickerMode:UIDatePickerModeDate];
    [self.datePicker addTarget:self action:@selector(datePickerViewValueChangeData:) forControlEvents:UIControlEventValueChanged];
    [self.datePicker setFrame:CGRectMake(0,KScreenHeight - 250, KScreenWidth, 250)];
    [_tb setFrame:CGRectMake(0, KScreenHeight - 250 -40, KScreenWidth, 40)];
    [UIView commitAnimations];
    
}

-(void)datePickerViewValueChangeData:(id)sender{
    
    UIDatePicker *datePicker = (UIDatePicker*)sender;
    NSDate *date = [datePicker date];
    NSDateFormatter *formatter  = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *currentDateString   = [formatter stringFromDate:date];
    [beginBtn setTitle:currentDateString forState:UIControlStateNormal];
    
}



#pragma mark -PikerView的工具栏按钮 Delegate
-(void)cancelInput{
    NSLog(@"---");
}
-(void)commitInput{
    
    [self hiddenKeyBoard];
}

#pragma  mark - 隐藏键盘
-(void)hiddenKeyBoard{
    [UIView beginAnimations:nil context:Nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.1];
    [_tb setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height + _datePicker.frame.size.height, [UIScreen mainScreen].bounds.size.width, 40)];
    [pickerViewTest setFrame: CGRectMake(0, [UIScreen mainScreen].bounds.size.height+40, [UIScreen mainScreen].bounds.size.width,100)];
    [_datePicker setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 100)];
    [UIView commitAnimations];
}

#pragma  mark -UIPickerViewDataSource
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return  1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return  typeArray.count;
}

- (void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
