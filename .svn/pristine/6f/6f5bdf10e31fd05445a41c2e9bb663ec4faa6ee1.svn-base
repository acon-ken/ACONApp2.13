//
//  BMBirthdayPick.h
//  TESTForPickView
//
//  Created by sam.l on 14-11-11.
//  Copyright (c) 2014年 bluemob. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BMBirthdayPick : UIView<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic,retain) UIPickerView *pickView;
/// 年
@property (nonatomic,retain) NSMutableArray *yearArray;
/// 月
@property (nonatomic,retain) NSMutableArray *monthArray;
/// 日
@property (nonatomic,retain) NSMutableArray *DaysArray;

/// 年
@property (nonatomic,copy) NSString *hYear;
/// 月
@property (nonatomic,copy) NSString *hMonth;
/// 日
@property (nonatomic,copy) NSString *hDay;

//// ** 不应提供的接口 **
//@property (nonatomic,assign) int selectedYearRow;
//@property (nonatomic,assign) int selectedMonthRow;
//@property (nonatomic,assign) int selectedDayRow;
- (id)initWithFrame:(CGRect)frame withTagate:(id)object completeAction:(SEL)completeAction unCompleteAction:(SEL)unCompleteAction;

- (void)resetDateYear:(NSString *)year month:(NSString *)month day:(NSString *)day;
/// 刷新已选择表面
- (void)refreshLabelAppearance;

@end
