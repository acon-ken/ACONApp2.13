//
//  RemindCell.m
//  ACONApp
//
//  Created by 朱红轻飞溅 on 14/12/15.
//  Copyright (c) 2014年 zw. All rights reserved.
//

#import "RemindCell.h"



@interface RemindCell()<UITextFieldDelegate>
{
    NSString *remindID;
    BOOL bKeyBoardHide;
    
}

@end

@implementation RemindCell

- (void)awakeFromNib
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    bKeyBoardHide = YES;
}

+ (NSString *)ID
{
    return @"RemindCell";
}

+ (id)createRemindCell
{
    return  [[NSBundle mainBundle] loadNibNamed:@"RemindCell" owner:nil options:nil][0];
}

- (void)updateFrame
{
    if (iOS7) {
        _titleTF.layer.borderWidth = 0.8;
        _titleTF.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
        _timeTF.layer.borderWidth = 0.8;
        _timeTF.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
        _remarkTF.layer.borderWidth = 0.8;
        _remarkTF.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }
    else
    {
        _titleTF.layer.borderWidth = 0.5;
        _titleTF.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
        _timeTF.layer.borderWidth = 0.5;
        _timeTF.layer.borderColor = [UIColor lightGrayColor].CGColor;

        _remarkTF.layer.borderWidth = 0.5;
        _remarkTF.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }

    UIDatePicker *_datePicker = [[UIDatePicker alloc] init];
    [_datePicker setDatePickerMode:UIDatePickerModeTime];
    [_datePicker setFrame:CGRectMake(0, KScreenHeight-50, KScreenWidth, 50)];
    [_datePicker addTarget:self action:@selector(birthdayChange:) forControlEvents:UIControlEventValueChanged];
   
    
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _datePicker.frame.size.width, 35)];
    redView.backgroundColor = KCommonColor;
    redView.userInteractionEnabled = YES;
    
    UIButton *sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(redView.frame.size.width-80,0,80,35)];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(dismissRedviewBtnAction) forControlEvents:UIControlEventTouchUpInside];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sureBtn.selected = YES;

    
   //PickerView上面ToolBar的小时LB
   UILabel *HourLB = [[UILabel alloc]initWithFrame:CGRectMake(KScreenWidth/2-55, 5, 40, 30)];
    HourLB.font = [UIFont boldSystemFontOfSize:17.0f];
    HourLB.textColor = [UIColor whiteColor];
    HourLB.text =@"小时";
   
    
    //PickerView上面ToolBar的分钟LB
    UILabel *minitLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(HourLB.frame)+30, HourLB.frame.origin.y, HourLB.frame.size.width, HourLB.frame.size.height)];
    minitLB.font = [UIFont boldSystemFontOfSize:17.0f];
    minitLB.textColor = [UIColor whiteColor];
    minitLB.text =@"分钟";
    
   
    [redView addSubview:HourLB];
    [redView addSubview:minitLB];
    [redView addSubview:sureBtn];
    [_datePicker addSubview:redView];
    _timeTF.inputView = _datePicker;}

//Pickerview上确定按钮点击事件
-(void)dismissRedviewBtnAction{
    _timeTF.inputView.hidden = YES;
    NSLog(@"123456789");
}

- (void)RemindInformationWithDict:(NSDictionary *)dict editionBool:(BOOL)editionBool
{
    if (editionBool) {
        
//        [_titleTF becomeFirstResponder];
        _titleTF.enabled = YES;
        _timeTF.enabled = YES;
        _remarkTF.enabled = YES;
        
    }else{
        _titleTF.enabled = NO;
        _timeTF.enabled = NO;
        _remarkTF.enabled = NO;
    }
    
    _titleTF.text = dict[@"title"];
    _timeTF.text = dict[@"time"];
    _remarkTF.text = dict[@"remark"];
    
    remindID = dict[@"ID"];
    _titleTF.delegate = self;
    _timeTF.delegate = self;
    _remarkTF.delegate = self;

}

- (void)CellBecomeFirstResponderEditionBool:(BOOL)editionBool
{
    if (bKeyBoardHide) {
        [_titleTF becomeFirstResponder];
    }
    else
    {
        [_titleTF resignFirstResponder];
    }
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"ID"] = remindID;
    params[@"title"] = _titleTF.text;
    params[@"time"] = _timeTF.text;
    params[@"remark"] = _remarkTF.text;
    params[DEF_ACONUserID] = [[[SaveUserInfo loadCustomObjectWithKey] data]dataIdentifier];
    if ([_delegate respondsToSelector:@selector(RemindInformationWithEditionDict:)]) {
        [_delegate RemindInformationWithEditionDict:params];
    }
}
- (void)birthdayChange:(UIDatePicker *)picker
{
    
    // 1.取得当前时间
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"HH:mm";
    NSString *time = [fmt stringFromDate:picker.date];
    
    // 2.赋值到文本框
    _timeTF.text = time;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([_delegate respondsToSelector:@selector(RemindInformationWithBeginEdit:)]) {
        [_delegate RemindInformationWithBeginEdit:textField];
    }
}


-(void)keyboardWillHide:(NSNotification *)notification
{
    NSLog(@"*-----HideKeyBoard");
    bKeyBoardHide = YES;
}

-(void)keyboardWillShow:(NSNotification *)notification
{
    NSLog(@"*-----ShowKeyBoard");
    bKeyBoardHide = NO;
}
@end
