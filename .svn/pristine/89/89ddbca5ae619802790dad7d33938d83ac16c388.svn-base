
#import <UIKit/UIKit.h>

@interface BMTimePickView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic,retain) UIPickerView *pickView;
/// 月 日
@property (nonatomic,retain) NSMutableArray *monthAndDayArray;
/// 小时
@property (nonatomic,retain) NSMutableArray *hoursArray;
/// 分钟
@property (nonatomic,retain) NSArray *minutesArray;

//选择分区，非实际数字
@property (nonatomic,assign) NSInteger selectedMonthAndDayRow;// XX月XX日
@property (nonatomic,assign) NSInteger selectedHourRow;// 时
@property (nonatomic,assign) NSInteger selectedMinutesRow;// 分

@property (nonatomic,copy,readonly) NSString *yearMonthAndDay;
@property (nonatomic,copy,readonly) NSString *monthAndDay;
@property (nonatomic,copy,readonly) NSString *hours;
@property (nonatomic,copy,readonly) NSString *minutes;

- (id)initWithFrame:(CGRect)frame withTagate:(id)object completeAction:(SEL)completeAction unCompleteAction:(SEL)unCompleteAction;
//- (void)resetDateYear:(NSString *)year month:(NSString *)month day:(NSString *)day;
/// 刷新已选择表面
//- (void)refreshLabelAppearance;
@end
