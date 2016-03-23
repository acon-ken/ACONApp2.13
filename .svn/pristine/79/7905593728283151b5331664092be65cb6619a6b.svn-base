//
//  HHLineChartTool.h
//  TESTForLine
//
//  Created by sam.l on 14/12/22.
//  Copyright (c) 2014年 HYM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>
@interface HHLineChartTool : NSObject

+ (void)drawPoint:(CGContextRef)context point:(CGPoint)point color:(UIColor *)color;

+ (void)drawLine:(CGContextRef)context startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint lineColor:(UIColor *)lineColor;
+ (void)drawLine:(CGContextRef)context startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint lineColor:(UIColor *)lineColor lineWith:(CGFloat )lineWith;

//同心圆
+ (void)drawRectPoint:(CGContextRef)context point:(CGPoint)point color:(UIColor *)color;
@end

// 点
@interface HHPoint : NSObject

@property double xValue; //水平x轴的值
@property double yValue; //垂直y轴的值
@property (nonatomic,retain)NSDate *dateTime;
@property (nonatomic,copy) NSString *date;// 2014-12-23
@property (nonatomic,copy) NSString *time;//08:10
@property (nonatomic,copy) NSString *state;//餐前？


@end