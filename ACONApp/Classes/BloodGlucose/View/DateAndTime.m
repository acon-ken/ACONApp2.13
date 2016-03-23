//
//  DateAndTime.m
//  ACONApp
//
//  Created by 朱红轻飞溅 on 14/12/18.
//  Copyright (c) 2014年 zw. All rights reserved.
//

#import "DateAndTime.h"

@implementation DateAndTime


+ (id)createDateAndTimeCell
{
    return [[NSBundle mainBundle] loadNibNamed:@"DateAndTime" owner:self options:nil][0];
}

- (void)initView
{
    _Time1.layer.cornerRadius = 10;
    _Time1.layer.masksToBounds = YES;
    
    
    _Time2.layer.cornerRadius = 10;
    _Time2.layer.masksToBounds = YES;

    _Time3.layer.cornerRadius = 10;
    _Time3.layer.masksToBounds = YES;

    _Time4.layer.cornerRadius = 10;
    _Time4.layer.masksToBounds = YES;
    
    [self initTime];

}

- (void)initTime
{
    //获取系统当前时间,格式化成 yyyy年MM月dd日 HH:mm:ss
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmm"];
    NSString *currentTime = [formatter stringFromDate:[NSDate date]];

    NSRange range;
    range.length = 1;
    
    range.location = 8;
    _Time1.image = [UIImage imageNamed:[NSString stringWithFormat:@"0%@.png",[currentTime substringWithRange:range]]];
    
    range.location = 9;
    _Time2.image = [UIImage imageNamed:[NSString stringWithFormat:@"0%@.png",[currentTime substringWithRange:range]]];
    
    range.location = 10;
    _Time3.image = [UIImage imageNamed:[NSString stringWithFormat:@"0%@.png",[currentTime substringWithRange:range]]];
    
    range.location = 11;
    _Time4.image = [UIImage imageNamed:[NSString stringWithFormat:@"0%@.png",[currentTime substringWithRange:range]]];
    
    range.location = 0;
    _year1.image = [UIImage imageNamed:[NSString stringWithFormat:@"x%@.png",[currentTime substringWithRange:range]]];
    
    range.location = 1;
    _year2.image = [UIImage imageNamed:[NSString stringWithFormat:@"x%@.png",[currentTime substringWithRange:range]]];
    
    range.location = 2;
    _year3.image = [UIImage imageNamed:[NSString stringWithFormat:@"x%@.png",[currentTime substringWithRange:range]]];
    
    range.location = 3;
    _year4.image = [UIImage imageNamed:[NSString stringWithFormat:@"x%@.png",[currentTime substringWithRange:range]]];
    
    range.location = 4;
    int location4 = [[currentTime substringWithRange:range] integerValue];
    
    range.location = 5;
    int Month = [[currentTime substringWithRange:range] integerValue];
    switch (Month) {
        case 1:
            _month1.image = [UIImage imageNamed:@"J.png"];
            _month2.image = [UIImage imageNamed:@"A.png"];
            _month3.image = [UIImage imageNamed:@"N.png"];
            break;
        case 2:
            _month1.image = [UIImage imageNamed:@"F.png"];
            _month2.image = [UIImage imageNamed:@"E.png"];
            _month3.image = [UIImage imageNamed:@"B.png"];
            break;
        case 3:
            _month1.image = [UIImage imageNamed:@"M.png"];
            _month2.image = [UIImage imageNamed:@"A.png"];
            _month3.image = [UIImage imageNamed:@"R.png"];
            break;
        case 4:
            _month1.image = [UIImage imageNamed:@"A.png"];
            _month2.image = [UIImage imageNamed:@"P.png"];
            _month3.image = [UIImage imageNamed:@"R.png"];
            break;
        case 5:
            _month1.image = [UIImage imageNamed:@"M.png"];
            _month2.image = [UIImage imageNamed:@"A.png"];
            _month3.image = [UIImage imageNamed:@"Y.png"];
            break;
        case 6:
            _month1.image = [UIImage imageNamed:@"J.png"];
            _month2.image = [UIImage imageNamed:@"U.png"];
            _month3.image = [UIImage imageNamed:@"N.png"];
            break;
        case 7:
            _month1.image = [UIImage imageNamed:@"J.png"];
            _month2.image = [UIImage imageNamed:@"U.png"];
            _month3.image = [UIImage imageNamed:@"L.png"];
            break;
        case 8:
            _month1.image = [UIImage imageNamed:@"A.png"];
            _month2.image = [UIImage imageNamed:@"U.png"];
            _month3.image = [UIImage imageNamed:@"G.png"];
            break;
        case 9:
            _month1.image = [UIImage imageNamed:@"S.png"];
            _month2.image = [UIImage imageNamed:@"E.png"];
            _month3.image = [UIImage imageNamed:@"P.png"];
            break;
        case 0:
            _month1.image = [UIImage imageNamed:@"O.png"];
            _month2.image = [UIImage imageNamed:@"C.png"];
            _month3.image = [UIImage imageNamed:@"T.png"];
            break;
        default:
            break;
    }
    
    if (location4 == 1&&Month==1) {
        _month1.image = [UIImage imageNamed:@"N.png"];
        _month2.image = [UIImage imageNamed:@"O.png"];
        _month3.image = [UIImage imageNamed:@"V.png"];
    }
    else if (location4 ==1 && Month == 2)
    {
        _month1.image = [UIImage imageNamed:@"D.png"];
        _month2.image = [UIImage imageNamed:@"E.png"];
        _month3.image = [UIImage imageNamed:@"C.png"];
    }
    
    range.location = 6;
    _date1.image = [UIImage imageNamed:[NSString stringWithFormat:@"x%@.png",[currentTime substringWithRange:range]]];
    
    range.location = 7;
    _date2.image = [UIImage imageNamed:[NSString stringWithFormat:@"x%@.png",[currentTime substringWithRange:range]]];
    
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    
    [inputFormatter setDateFormat:@"HHmm"];
    NSString *currentTime8 = [inputFormatter stringFromDate:[NSDate date]];
    NSDate* inputDate1 = [inputFormatter dateFromString:currentTime8];
//    NSLog(@"%@",currentTime8);
    
    NSString* string = @"1200";
    NSDate* inputDate = [inputFormatter dateFromString:string];
//    NSLog(@"date = %@", inputDate);

    NSTimeInterval _fitstDate = [inputDate1 timeIntervalSince1970]*1;
    NSTimeInterval _secondDate = [inputDate timeIntervalSince1970]*1;
    
    
    if ((_fitstDate - _secondDate )> 0) {
        
        //第一个时间大
        _AMAndPM.image = [UIImage imageNamed:@"PM.png"];
        
    }else
    {
        _AMAndPM.image = [UIImage imageNamed:@"AM.png"];
    }

}
@end
