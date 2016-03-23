//
//  BloodGlucoseCell.m
//  ACONApp
//
//  Created by 朱红轻飞溅 on 14/12/9.
//  Copyright (c) 2014年 zw. All rights reserved.
//

#import "BloodGlucoseCell.h"

@implementation BloodGlucoseCell

- (void)initView{
    
    _topView.layer.borderWidth = 0.5;
    _topView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    if ([_bloodModel.regRate1 isEqualToString:@"100.00%"]) {
        _rateLB.attributedText = [self createRateStringValue1:@"达标率" Value2:@"100%"];
    }else{
       
        _rateLB.attributedText = [self createRateStringValue1:@"达标率" Value2: [NSString stringWithFormat:@"%@",_bloodModel.regRate1]];
        if ([[NSString stringWithFormat:@"%@",_bloodModel.regRate1] isEqualToString:@"(null)"]) {
            _rateLB.attributedText = [self createRateStringValue1:@"达标率" Value2: @"0"];
        }
    
    }
    
    _testLB.layer.borderWidth = 0.5;
    _testLB.layer.borderColor = [UIColor lightGrayColor].CGColor;
     _testLB.attributedText = [self createAttributedStringValue1:@"    测试" Value2:[NSString stringWithFormat:@"%@",_bloodModel.testCount1]];
    if ([[NSString stringWithFormat:@"%@",_bloodModel.testCount1] isEqualToString:@"(null)"]) {
       _testLB.attributedText = [self createAttributedStringValue1:@"    测试" Value2:@"0"];
    }
   
    
    _overproofLB.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _overproofLB.layer.borderWidth = 0.5;
     _overproofLB.attributedText = [self createAttributedStringValue1:@"  超标" Value2:[NSString stringWithFormat:@"%@",_bloodModel.exceedCount1]];
    if ([[NSString stringWithFormat:@"%@",_bloodModel.exceedCount1] isEqualToString:@"(null)"]) {
         _overproofLB.attributedText = [self createAttributedStringValue1:@"  超标" Value2:@"0"];
    }
   
    
    _afterValueLB1.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _afterValueLB1.layer.borderWidth = 0.5;
    _afterValueLB1.attributedText = [self createAttributedStringValue1:@" 餐后平均" Value2:[NSString stringWithFormat:@"%@",_bloodModel.eatHAvg1]];
    if ([[NSString stringWithFormat:@"%@",_bloodModel.eatHAvg1] isEqualToString:@"(null)"]) {
       _afterValueLB1.attributedText = [self createAttributedStringValue1:@" 餐后平均" Value2:@"0"];
    }

    
    _MaxValueLB.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _MaxValueLB.layer.borderWidth = 0.5;
    _MaxValueLB.attributedText = [self createAttributedStringValue1:@"    最高" Value2:[NSString stringWithFormat:@"%@",_bloodModel.maxValue1]];
    if ([[NSString stringWithFormat:@"%@",_bloodModel.maxValue1] isEqualToString:@"(null)"]) {
        _MaxValueLB.attributedText = [self createAttributedStringValue1:@"    最高" Value2:@"0"];
    }

    
    _MinValueLB.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _MinValueLB.layer.borderWidth = 0.5;
    _MinValueLB.attributedText = [self createAttributedStringValue1:@"  最低" Value2:[NSString stringWithFormat:@"%@",_bloodModel.minValue1]];
    if ([[NSString stringWithFormat:@"%@",_bloodModel.minValue1] isEqualToString:@"(null)"]) {
       _MinValueLB.attributedText = [self createAttributedStringValue1:@"  最低" Value2:@"0"];
    }


    _afterValueLB2.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _afterValueLB2.layer.borderWidth = 0.5;
    _afterValueLB2.attributedText = [self createAttributedStringValue1:@" 空腹平均" Value2:[NSString stringWithFormat:@"%@",_bloodModel.noEatAvg1]];
    if ([[NSString stringWithFormat:@"%@",_bloodModel.noEatAvg1] isEqualToString:@"(null)"]) {
        _afterValueLB2.attributedText = [self createAttributedStringValue1:@" 空腹平均" Value2:@"0"];
    }
    
    _meanValueLB.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _meanValueLB.layer.borderWidth = 0.5;
    _meanValueLB.attributedText = [self createAttributedStringValue1:@"    平均" Value2:[NSString stringWithFormat:@"%@",_bloodModel.avgValue1]];
    if ([[NSString stringWithFormat:@"%@",_bloodModel.avgValue1] isEqualToString:@"(null)"]) {
        _meanValueLB.attributedText = [self createAttributedStringValue1:@"    平均" Value2:@"0"];
    }

    
    _afterValueLB3.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _afterValueLB3.layer.borderWidth = 0.5;
    _afterValueLB3.attributedText = [self createAttributedStringValue1:@"  餐前平均" Value2:[NSString stringWithFormat:@"%@",_bloodModel.eatQAvg1]];
    if ([[NSString stringWithFormat:@"%@",_bloodModel.eatQAvg1] isEqualToString:@"(null)"]) {
         _afterValueLB3.attributedText = [self createAttributedStringValue1:@"  餐前平均" Value2:@"0"];
    }
    
    
    _randomValueLB.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _randomValueLB.layer.borderWidth = 0.5;
    _randomValueLB.attributedText = [self createAttributedStringValue1:@" 随机平均" Value2:[NSString stringWithFormat:@"%@",_bloodModel.randomAvg1]];
    if ([[NSString stringWithFormat:@"%@",_bloodModel.randomAvg1] isEqualToString:@"(null)"]) {
       _randomValueLB.attributedText = [self createAttributedStringValue1:@" 随机平均" Value2:@"0"];
    }
    


}


- (NSMutableAttributedString *)createAttributedStringValue1:(NSString *)value1 Value2:(NSString *)value2
{
    NSString *str0 =value1;
    NSString *str1 =value2;
    NSString *com = [NSString stringWithFormat:@"%@ %@",str0,str1];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:com];
    
    NSDictionary *str0dict = @{NSForegroundColorAttributeName: [UIColor blackColor], NSFontAttributeName: [UIFont systemFontOfSize:12]};
    CGFloat value = [value2 floatValue];
    
    UIColor *color;
    
    if (value > 33.0f) {
        color = [UIColor redColor];
    }
    else if (value < 0.6f)
    {
        color = [UIColor blueColor];
    }
    else
    {
        color = KCommonColor;
    }
    
    NSDictionary *str1dict = @{NSForegroundColorAttributeName:color, NSFontAttributeName: [UIFont systemFontOfSize:13]};
    
    [str addAttributes:str0dict range:[com rangeOfString:str0]];
    [str addAttributes:str1dict range:[com rangeOfString:str1]];
    
    return str;
}

/**
 *  达标率
 *
 *  @return <#return value description#>
 */
- (NSMutableAttributedString *)createRateStringValue1:(NSString *)value1 Value2:(NSString *)value2
{
    NSString *str0 =value1;
    NSString *str1 =value2;
    NSString *com = [NSString stringWithFormat:@"%@  (%@)",str0,str1];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:com];
    
    NSDictionary *str0dict = @{NSForegroundColorAttributeName: [UIColor blackColor], NSFontAttributeName: [UIFont systemFontOfSize:13]};
    CGFloat value = [value2 floatValue];
    
    UIColor *color;
    
    if (value > 33.0f) {
        color = [UIColor redColor];
    }
    else if (value < 0.6f)
    {
        color = [UIColor blueColor];
    }
    else
    {
        color = KCommonColor;
    }
    
    NSDictionary *str1dict = @{NSForegroundColorAttributeName:color, NSFontAttributeName: [UIFont systemFontOfSize:13]};
    
    [str addAttributes:str0dict range:[com rangeOfString:str0]];
    [str addAttributes:str1dict range:[com rangeOfString:str1]];
    
    return str;
}

+ (NSString *)ID
{
    return @"BloodGlucoseCell";
}

+ (id)createBloodGlucoseCell
{
    return [[NSBundle mainBundle] loadNibNamed:@"BloodGlucoseCell" owner:nil options:nil][0];
}
@end
