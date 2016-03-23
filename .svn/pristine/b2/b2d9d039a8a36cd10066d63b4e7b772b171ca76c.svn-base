//
//  HHLineChartContentView.h
//  TESTForLine
//
//  Created by sam.l on 14/12/23.
//  Copyright (c) 2014年 HYM. All rights reserved.
//

#import <UIKit/UIKit.h>
#define DEF_NOMAL_AREA_COLOR [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:255.0/255.0 alpha:0.7]
@interface HHLineChartContentView : UIView
// 血糖最高值
@property (nonatomic,assign) CGFloat maxY;
// 血糖最低值
@property (nonatomic,assign) CGFloat minY;

// 血糖正常值
@property (nonatomic,assign) CGFloat normalY;

/**
 *  // 正常值范围 宽度最小值 ／ 高度 最大值
 */
@property (nonatomic,assign) CGSize normalValueRange;

// 数据源
@property (nonatomic,retain) NSArray *dataSourceArray;
// 当前日期
@property (nonatomic,retain) NSDate *kCurrentDate;
/* 从现在 距离 过去 天数 （12月12 过去3天 12月9 － 12月12） */
@property (nonatomic,assign) NSInteger timeInterval;

- (instancetype)initWithFrame:(CGRect)frame;
- (instancetype)init;
@end
