//
//  HHLineChart.h
//  TESTForLine
//
//  Created by sam.l on 14/12/22.
//  Copyright (c) 2014年 HYM. All rights reserved.
//

#import <UIKit/UIKit.h>
//** 测试开关*/
#define DEF_IS_TEST false
// true / false

// 大于最大值的点的颜色
#define DEF_P_COLOR_MAX [UIColor colorWithRed:251/255.0 green:64/255.0 blue:69/255.0 alpha:1.0]
// 正常值的点的颜色
#define DEF_P_COLOR_NOMAL [UIColor colorWithRed:23/255.0 green:144/255.0 blue:110/255.0 alpha:1.0]
// 小于最小值的点的颜色
#define DEF_P_COLOR_MIN [UIColor colorWithRed:105/255.0 green:168/255.0 blue:249/255.0 alpha:1.0]
// 折线颜色
#define DEF_Line_COLOR [UIColor colorWithRed:105/255.0 green:168/255.0 blue:249/255.0 alpha:1.0]

// 填充颜色
#define DEF_FILL_COLOR [UIColor colorWithRed:23/255.0 green:144/255.0 blue:110/255.0 alpha:0.6]


@interface HHLineChart : UIView

#pragma mark -
// 标题的字体
@property (nonatomic,retain) UIFont *x_TitleFont;
@property (nonatomic,retain) UIFont *y_TitleFont;

#pragma mark 偏移量 数据视图与真实视图 原点 的 偏移(数据视图 与 view(即像素)视图 的左上角偏移量 相当于  数据视图.frame.orgain )
// 内容 偏移量
@property (nonatomic) CGPoint contentOffset;

// 正常 坐标原点（非屏幕坐标系 原点）
@property (nonatomic,assign) CGPoint origin;

// 内容偏移量 （目前仅左右有效）；
@property (nonatomic,assign) UIEdgeInsets contentInset;
// 缩放中心
//@property (nonatomic,assign) CGPoint scaleCenter;

#pragma mark -
#pragma mark 缩放比例
// 缩放比例
@property (nonatomic,assign) CGFloat Scale_X;
@property (nonatomic,assign) CGFloat Scale_Y;

#pragma mark 最小缩放比例
/** 最小缩放比例 */
@property (nonatomic,readonly) CGFloat min_Scanle_X;
@property (nonatomic,readonly) CGFloat min_Scanle_Y;

#pragma mark 最大缩放比例
/** 最大缩放比例 */
@property (nonatomic,readonly) CGFloat max_Scanle_X;
@property (nonatomic,readonly) CGFloat max_Scanle_Y;

#pragma mark -
#pragma mark （暂无用） 当前数据源的（X，Y），X，Y为（ 最大值 － 最小值）
// 当前数据源的（X，Y），X，Y为（ 最大值 － 最小值）
@property (nonatomic,assign,readonly)CGSize currentSize;

// 当前日期
@property (nonatomic,retain) NSDate *kCurrentDate;

/* 从现在 距离 过去 天数 （12月12 过去3天 12月9 － 12月12） */
@property (nonatomic,assign) NSInteger timeInterval;

// 血糖最高值
@property (nonatomic,assign) CGFloat maxValueY;

// 血糖正常值
@property (nonatomic,assign) CGFloat normalValueY;

// 血糖最低值
@property (nonatomic,assign) CGFloat minValueY;

/**
 *   正常值范围 宽度最小值 ／ 高度 最大值
 */
@property (nonatomic,assign) CGSize normalValueRange;

//- (void)setScaleCenter:(CGPoint)scaleCenter withScale:(CGFloat)scale kScale:(CGFloat)kScale;
// 初始化

- (void)setLineSourceArray:(NSArray *)dataSourceArray;

@end
