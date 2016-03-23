//
//  BMBirthdayPick.m
//  TESTForPickView
//
//  Created by sam.l on 14-11-11.
//  Copyright (c) 2014年 bluemob. All rights reserved.
//

#import "BMBirthdayPick.h"
#define currentMonth [currentMonthString integerValue]

@implementation BMBirthdayPick
{
    NSString *currentMonthString;
    
    NSInteger _selectedYearRow;
    NSInteger _selectedMonthRow;
    NSInteger _selectedDayRow;
    
    BOOL firstTimeLoad;
    
//    NSString *_hYear;
//    NSString *_hMonth;
//    NSString *_hDay;
}

//- (id)init
//{
//    self = [super init];
//    if (self) {
//        [self loadDate];
//    }
//    return self;
//}

- (id)initWithFrame:(CGRect)frame withTagate:(id)object completeAction:(SEL)completeAction unCompleteAction:(SEL)unCompleteAction
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 6;
        
        self.pickView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 40 , frame.size.width, frame.size.height - 40)];
        self.pickView.delegate = self;
        self.pickView.dataSource = self;
        [self addSubview:self.pickView];
        
        CGFloat space = 40;
        UIButton *completeBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [completeBtn setTitle:@"完成" forState:UIControlStateNormal];
        completeBtn.frame = CGRectMake(space, 10, 60, 30);
        [completeBtn setTintColor:[UIColor whiteColor]];
        [completeBtn setBackgroundImage:[UIImage imageNamed:@"honganniu.png"] forState:UIControlStateNormal];
        [completeBtn addTarget:object action:completeAction forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:completeBtn];
        
        
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        cancelBtn.frame = CGRectMake(frame.size.width - 60-space, 10, 60, 30);
        [cancelBtn setTintColor:[UIColor whiteColor]];
        [cancelBtn setBackgroundImage:[UIImage imageNamed:@"honganniu.png"] forState:UIControlStateNormal];
        [cancelBtn addTarget:object action:unCompleteAction forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelBtn];
        [self loadDate];
    }
    return self;
}


//- (id)initWithCoder:(NSCoder *)aDecoder
//{
//    self = [super initWithCoder:aDecoder];
//    if (self) {
//        [self loadDate];
//    }
//    return self;
//}

- (void)loadDate
{
    firstTimeLoad = NO;
//    self.dataSource = self;
//    self.delegate = self;
    
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 6;
    
    NSDate *date = [NSDate date];
    
    self.hYear = @"";
    self.hMonth = @"";
    self.hDay = @"";
    
    // Get Current Year
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy"];
    
    NSString *currentyearString = [NSString stringWithFormat:@"%@",
                                   [formatter stringFromDate:date]];
    
    
    // Get Current  Month
    
    [formatter setDateFormat:@"MM"];
    
    currentMonthString = [NSString stringWithFormat:@"%ld",(long)[[formatter stringFromDate:date]integerValue]];
    
    
    // Get Current  Date
    
    [formatter setDateFormat:@"dd"];
    NSString *currentDateString = [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
    
    
    // PickerView -  Years data
    
    _yearArray = [[NSMutableArray alloc]init];
    
    for (int i = 1970; i <= 2050 ; i++)
    {
        [_yearArray addObject:[NSString stringWithFormat:@"%d",i]];
        
    }
    
    
    // PickerView -  Months data
    
    self.monthArray = [[NSMutableArray alloc]init];
    for (int i = 1; i <= 12; i++)
    {
//            NSLog(@"%@",[NSString stringWithFormat:@"%0.5d",1]);
        [self.monthArray addObject:[NSString stringWithFormat:@"%0.2d",i]];
    }
    
    // PickerView -  days data
    
    self.DaysArray = [[NSMutableArray alloc]init];
    for (int i = 1; i <= 31; i++)
    {
        [_DaysArray addObject:[NSString stringWithFormat:@"%0.2d",i]];
        
    }
    _selectedYearRow = [_yearArray indexOfObject:currentyearString];
    _selectedMonthRow = [_monthArray indexOfObject:currentMonthString];
    _selectedDayRow = [_DaysArray indexOfObject:currentDateString];
    
    [self.pickView selectRow:_selectedYearRow inComponent:0 animated:YES];
    
    [self.pickView selectRow:_selectedMonthRow inComponent:2 animated:YES];
    
    [self.pickView selectRow:_selectedDayRow inComponent:4 animated:YES];
    
}

- (void)resetDateYear:(NSString *)year month:(NSString *)month day:(NSString *)day
{
    NSInteger row = -1;
    row = [_yearArray indexOfObject:year];
    if (row >= 0 && row <= [_yearArray count]-1) {
        _selectedYearRow = row;
        [self.pickView selectRow:row inComponent:0 animated:NO];

    }
    
    row = [_monthArray indexOfObject:month];
    if (row >= 0&& row <= [_monthArray count]-1) {
        _selectedMonthRow = row;
        [self.pickView selectRow:row inComponent:2 animated:NO];

    }
    
    row = [_DaysArray indexOfObject:day];
    if (row >= 0&& row <= [_DaysArray count]-1) {
        _selectedDayRow = row;
        [self.pickView selectRow:row inComponent:4 animated:NO];
        
    }
    
    [self setDate];
//    [self refreshLabelAppearance];

}

- (void)setDate
{
    self.hYear = self.yearArray[_selectedYearRow];
    self.hMonth = self.monthArray[_selectedMonthRow];
    self.hDay = self.DaysArray[_selectedDayRow];
}

#pragma mark - UIPickerViewDelegate


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    if (component == 0)
    {
        _selectedYearRow = row;
        [self.pickView reloadAllComponents];
    }
    else if (component == 2)
    {
        _selectedMonthRow = row;
        [self.pickView reloadAllComponents];
    }
    else if (component == 4)
    {
        _selectedDayRow = row;
//        [self reloadAllComponents];
    }
    [self refreshLabelAppearance];
    
    [self setDate];
}

- (void)refreshLabelAppearance
{
    if ([self.pickView viewForRow:_selectedYearRow forComponent:0]) {
        UILabel *tempLB = (UILabel *)[self.pickView viewForRow:_selectedYearRow forComponent:0];
        tempLB.textColor = [UIColor whiteColor];
        tempLB.backgroundColor = [UIColor redColor];
   
    }
    if ([self.pickView viewForRow:_selectedMonthRow forComponent:2]) {
        UILabel *tempLB = (UILabel *)[self.pickView viewForRow:_selectedMonthRow forComponent:2];
        tempLB.textColor = [UIColor whiteColor];
        tempLB.backgroundColor = [UIColor redColor];
    }
    if ([self.pickView viewForRow:_selectedDayRow forComponent:4])
    {
        UILabel *tempLB = (UILabel *)[self.pickView viewForRow:_selectedDayRow forComponent:4];
        tempLB.textColor = [UIColor whiteColor];
        tempLB.backgroundColor = [UIColor redColor];

    }

}
#pragma mark - UIPickerViewDatasource

- (UIView *)pickerView:(UIPickerView *)pickerView
            viewForRow:(NSInteger)row
          forComponent:(NSInteger)component
           reusingView:(UIView *)view {
    
    UILabel *pickerLabel = (UILabel *)view;
    
    if (pickerLabel == nil) {
        CGRect frame = CGRectMake(0.0, 0.0, 30, 30);
        pickerLabel = [[UILabel alloc] initWithFrame:frame];
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont systemFontOfSize:14.0f]];
        pickerLabel.layer.cornerRadius = 4;
    }
    
    if (component == 0)
    {
        pickerLabel.frame = CGRectMake(0.0, 0.0, 60, 30);
        pickerLabel.text =  [_yearArray objectAtIndex:row]; // Year
    }
    else if (component == 2)
    {
        pickerLabel.frame = CGRectMake(0.0, 0.0, 50, 30);
        pickerLabel.text =  [_monthArray objectAtIndex:row];  // Month
    }
    else if (component == 4)
    {
        pickerLabel.frame = CGRectMake(0.0, 0.0, 50, 30);
        pickerLabel.text =  [_DaysArray objectAtIndex:row]; // Date
        
    }
    else if (component == 1)
    {
        pickerLabel.text = @"年";
    }
    else if (component == 3)
    {
        
        pickerLabel.text = @"月";
    }
    else if (component == 5)
    {
        pickerLabel.text = @"日";
        
    }
    return pickerLabel;
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 6;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    if (component == 0)
    {
        return [_yearArray count];
        
    }
    else if (component == 2)
    {
        return [_monthArray count];
    }
    else if (component == 4)
    { // day
        
        if (firstTimeLoad )
        {
            if (currentMonth == 1 || currentMonth == 3 || currentMonth == 5 || currentMonth == 7 || currentMonth == 8 || currentMonth == 10 || currentMonth == 12)
            {
                return 31;
            }
            else if (currentMonth == 2)
            {
                int yearint = [[_yearArray objectAtIndex:_selectedYearRow]intValue ];
                
                if(((yearint %4==0)&&(yearint %100!=0))||(yearint %400==0)){
                    
                    return 29;
                }
                else
                {
                    return 28; // or return 29
                }
                
            }
            else
            {
                return 30;
            }
            
        }
        else
        {
            
            if (_selectedMonthRow == 0 || _selectedMonthRow == 2 || _selectedMonthRow == 4 || _selectedMonthRow == 6 || _selectedMonthRow == 7 || _selectedMonthRow == 9 || _selectedMonthRow == 11)
            {
                return 31;
            }
            else if (_selectedMonthRow == 1)
            {
                int yearint = [[_yearArray objectAtIndex:_selectedYearRow]intValue ];
                
                if(((yearint %4==0)&&(yearint %100!=0))||(yearint %400==0)){
                    if (_selectedDayRow > 29-1) {
                        _selectedDayRow = 29-1;
                    }
                    return 29;
                }
                else
                {
                    if (_selectedDayRow > 28-1) {
                        _selectedDayRow = 28-1;
                    }
                    return 28; // or return 29
                }
                
                
                
            }
            else
            {
                if (_selectedDayRow > 30-1) {
                    _selectedDayRow = 30-1;
                }
                return 30;
            }
            
        }
        
        
    }
    else
    {
        return 1;
    }

    
}

//- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
//{
//    return 50;
//}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if (1== component ||3==component|| 5== component) {
        return 30;
    }
    else if (0 == component)
    {
        return 60;
    }
    return 50;
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

#pragma mark -
- (NSString *)hYear
{
    return [self.yearArray objectAtIndex:_selectedYearRow];
}
- (NSString *)hMonth
{
    return [self.monthArray objectAtIndex:_selectedMonthRow];
}
- (NSString *)hDay
{
    return [self.DaysArray objectAtIndex:_selectedDayRow];
}

@end


