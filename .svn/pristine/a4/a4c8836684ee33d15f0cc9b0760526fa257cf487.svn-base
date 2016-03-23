

#import "BMTimePickView.h"
@interface BMTimePickView ()
{
    NSString *currentDays;
    NSString *currentHours;
    NSString *currentMinutes;
    
    BOOL _flagMinutesToHour;// 满60分钟 进位
    BOOL _flagHourToDays; // 满24小时 进位
    
    BOOL _isToday;//  是否为今天
    
//    NSDate *endDate;
    NSDate *startDate;
    
    NSDateFormatter *formatter;
}
@property (nonatomic,retain) NSMutableArray *yearMonthAndDayArray;

@end

@implementation BMTimePickView

//- (id)init
//{
//    self = [super init];
//    if (self) {
//        [self loadDate];
//        
//    }
//    return self;
//}

- (id)initWithFrame:(CGRect)frame withTagate:(id)object completeAction:(SEL)completeAction unCompleteAction:(SEL)unCompleteAction
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 6;
        
        self.pickView = [[UIPickerView alloc]initWithFrame:self.bounds];
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


- (void)loadDate
{
    _flagHourToDays = NO;
    _flagMinutesToHour = NO;
    _isToday = NO;
    

    
    startDate = [[NSDate date]dateByAddingTimeInterval:60*60];
    formatter = [[NSDateFormatter alloc]init];
    
    _yearMonthAndDayArray = [[NSMutableArray alloc]init];
    _monthAndDayArray = [[NSMutableArray alloc]init];
    _hoursArray = [[NSMutableArray alloc]init];
    _minutesArray = [[NSArray alloc]initWithObjects:@"00",@"30",nil];

    _selectedMonthAndDayRow = 0;
    _selectedHourRow = 0;
    _selectedMinutesRow = 0;
    
    [formatter setDateFormat:@"mm"];
    currentMinutes = [NSString stringWithFormat:@"%@",[formatter stringFromDate:startDate]];
    // 小时
    [formatter setDateFormat:@"HH"];
    currentHours = [NSString stringWithFormat:@"%@",[formatter stringFromDate:startDate]];
    // 天
    [formatter setDateFormat:@"dd"];
    currentDays = [NSString stringWithFormat:@"%@",[formatter stringFromDate:startDate]];
    
    [self setFlag];
    
    NSDate *date = [NSDate date];
    [formatter setDateFormat:@"dd"];
    if ([currentDays isEqualToString:[formatter stringFromDate:date]]) {
        _isToday = YES;
    }
    
    
    [self setMonthAndDay];
    [self setYearMonthAndDay];
    [self setHours];
    
    [self.pickView selectRow:_selectedMonthAndDayRow inComponent:0 animated:YES];
    [self.pickView selectRow:_selectedHourRow inComponent:1 animated:YES];
    [self.pickView selectRow:_selectedMinutesRow inComponent:2 animated:YES];

}

- (void)setMonthAndDay
{
    [formatter setDateFormat:@"MM月dd日"];
    
//    [monthAndDayArray removeAllObjects];
    for (int i = 0; i < 15; i ++) {
        
        NSDate *date = [[NSDate date]dateByAddingTimeInterval:60*60*24*i];
        [_monthAndDayArray addObject:[formatter stringFromDate:date]];
    }
    
    _selectedMonthAndDayRow = 0;
}

- (void)setYearMonthAndDay
{
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    //    [monthAndDayArray removeAllObjects];
    for (int i = 0; i < 15; i ++) {
        
        NSDate *date = [[NSDate date]dateByAddingTimeInterval:60*60*24*i];
        [_yearMonthAndDayArray addObject:[formatter stringFromDate:date]];
    }
}

- (void)setHours
{
    [_hoursArray removeAllObjects];
    int begainHours = (_flagMinutesToHour?[currentHours intValue]+1:[currentHours intValue]);
    if (!_isToday) {
        begainHours = 0;
    }
    for (int i = begainHours; i <= 23; i++)
    {
        [_hoursArray addObject:[NSString stringWithFormat:@"%02d",i]];
    }
    _flagMinutesToHour = NO;
//    _selectedMinutesRow = 0;
}

- (void)setFlag
{
    // 一个小时后的 下一个半个小时 eg: 31/30 = 1
    [formatter setDateFormat:@"mm"];
    if ([[formatter stringFromDate:startDate] intValue] <= 30) { // [0 ~ 30] --> 30
        _selectedMinutesRow = 1;// 30
        _flagMinutesToHour = NO;
    }else
    {
        _selectedMinutesRow = 0;
        _flagMinutesToHour = YES;// (30,60) 小时向上加一
    }
    
    [formatter setDateFormat:@"HH"];
    if (_flagMinutesToHour &&([[formatter stringFromDate:startDate] integerValue] +1) >= 24) { // [0 ~ 30] --> 30
        _flagHourToDays = YES;
    }
    
}

#pragma mark - UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    if (component == 0)
    {
        _selectedMonthAndDayRow = row;
        if (_selectedMonthAndDayRow != 0 ) {
            _isToday = NO;
        }else
        {
            _isToday = YES;
            _selectedHourRow = 0;
            _selectedMinutesRow = 0;
            [self setFlag];
            [self.pickView selectRow:0 inComponent:1 animated:NO];
            [self.pickView selectRow:_selectedMinutesRow inComponent:2 animated:NO];
        }
        [self setHours];
        [self.pickView reloadAllComponents];
    }
    else if (component == 1)
    {
        _selectedHourRow = row;
        [self.pickView reloadAllComponents];
    }
    else if (component == 2)
    {
        _selectedMinutesRow = row;
    }
    else
    {
        
    }
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if (0 == component) {
        return 80;
    }
    return 50;
}

#pragma mark - UIPickerViewDatasource

- (UIView *)pickerView:(UIPickerView *)pickerView
            viewForRow:(NSInteger)row
          forComponent:(NSInteger)component
           reusingView:(UIView *)view {
    
    // Custom View created for each component
    
    UILabel *pickerLabel = (UILabel *)view;
    
    if (pickerLabel == nil) {
        CGRect frame = CGRectMake(0.0, 0.0, 50, 60);
        pickerLabel = [[UILabel alloc] initWithFrame:frame];
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont systemFontOfSize:15.0f]];
        pickerLabel.textColor = [UIColor blackColor];
    }
    
    if (component == 0)
    {
        pickerLabel.frame = CGRectMake(0, 0, 80, 60);
        pickerLabel.text =  [_monthAndDayArray objectAtIndex:row]; // 月 日
        if(0 == row)
        {
            pickerLabel.text = @"今天";
        }
        
    }
    else if (component == 1)
    {
        pickerLabel.text =  [_hoursArray objectAtIndex:row];  // 小时
    }
    else if (component == 2)
    {
        pickerLabel.text =  [_minutesArray objectAtIndex:row]; // 分钟
        
    }
    else
    {

    }
    
    return pickerLabel;
    
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    
    return 3;
    
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    if (component == 0)
    {
        return [_monthAndDayArray count];
        
    }
    else if (component == 1)
    {
        return [_hoursArray count];
    }
    else if (component == 2)
    {
        return [_minutesArray count];
    }
    else
    {
        return 0;
        
    }
    
    
    
}
#pragma mark -
- (NSString *)yearMonthAndDay
{
    return [self.yearMonthAndDayArray objectAtIndex:_selectedMonthAndDayRow];
}
- (NSString *)monthAndDay
{
    return [self.monthAndDayArray objectAtIndex:_selectedMonthAndDayRow];
}
- (NSString *)hours
{
    return [self.hoursArray objectAtIndex:_selectedHourRow];
}
- (NSString *)minutes
{
    return [self.minutesArray objectAtIndex:_selectedMinutesRow];
}

@end
