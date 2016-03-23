//
//  HHLineChartTool.m
//  TESTForLine
//
//  Created by sam.l on 14/12/22.
//  Copyright (c) 2014年 HYM. All rights reserved.
//

#import "HHLineChartTool.h"

@implementation HHLineChartTool

+ (void)drawPoint:(CGContextRef)context point:(CGPoint)point color:(UIColor *)color{
    
    CGContextSetShouldAntialias(context, YES ); //抗锯齿
    CGColorSpaceRef Pointcolorspace1 = CGColorSpaceCreateDeviceRGB();
    CGContextSetStrokeColorSpace(context, Pointcolorspace1);
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    CGContextMoveToPoint(context, point.x,point.y);
    CGContextAddArc(context, point.x, point.y, 2, 0, 360, 0);
    CGContextClosePath(context);
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillPath(context);
    CGColorSpaceRelease(Pointcolorspace1);
}
+ (void)drawLine:(CGContextRef)context startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint lineColor:(UIColor *)lineColor{
    
    CGContextSetShouldAntialias(context, YES ); //抗锯齿
    CGColorSpaceRef Linecolorspace1 = CGColorSpaceCreateDeviceRGB();
    CGContextSetStrokeColorSpace(context, Linecolorspace1);
    CGContextSetLineWidth(context, 0.5);
    CGContextSetStrokeColorWithColor(context, lineColor.CGColor);
    CGContextMoveToPoint(context, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
    CGContextStrokePath(context);
    CGColorSpaceRelease(Linecolorspace1);
}
+ (void)drawLine:(CGContextRef)context startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint lineColor:(UIColor *)lineColor lineWith:(CGFloat )lineWith{
    
    CGContextSetShouldAntialias(context, YES ); //抗锯齿
    CGColorSpaceRef Linecolorspace1 = CGColorSpaceCreateDeviceRGB();
    CGContextSetStrokeColorSpace(context, Linecolorspace1);
    CGContextSetLineWidth(context, lineWith);
    CGContextSetStrokeColorWithColor(context, lineColor.CGColor);
    CGContextMoveToPoint(context, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
    CGContextStrokePath(context);
    CGColorSpaceRelease(Linecolorspace1);
}

+ (void)drawRectPoint:(CGContextRef)context point:(CGPoint)point color:(UIColor *)color{
    
    /*  NO.11
     CGRect aRect= CGRectMake(80, 80, 160, 100);
         CGContextSetRGBStrokeColor(context, 0.6, 0.9, 0, 1.0);
        CGContextSetLineWidth(context, 3.0);
   	      CGContextSetFillColorWithColor(context, aColor.CGColor);
    	       CGContextAddRect(context, rect); //矩形
       CGContextAddEllipseInRect(context, aRect); //椭圆
   	    CGContextDrawPath(context, kCGPathStroke);

     
                 124.	     画一个实心的圆
                 125.
                 126.	     CGContextFillEllipseInRect(context, CGRectMake(95, 95, 100.0, 100));
                 127.	    */
   
    
    
    CGContextSetShouldAntialias(context, YES ); //抗锯齿
    CGColorSpaceRef Pointcolorspace1 = CGColorSpaceCreateDeviceRGB();
    CGContextSetStrokeColorSpace(context, Pointcolorspace1);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextMoveToPoint(context, point.x,point.y);
//    CGContextAddArc(context, point.x, point.y, 2, 0, 360, 0);
    // 外全圆
    CGContextAddArc(context, point.x, point.y, 5, 0, 2*M_PI, 0);
    CGContextClosePath(context);
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillPath(context);
//    // 过渡
    CGContextAddArc(context, point.x, point.y, 4, 0, 2*M_PI, 0);
    CGContextClosePath(context);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillPath(context);
//    // 内圈
    CGContextAddArc(context, point.x, point.y, 2, 0, 2*M_PI, 0);
    CGContextClosePath(context);
    CGContextSetFillColorWithColor(context, color.CGColor);
//    CGContextStrokePath(context);
    CGContextFillPath(context);
    CGColorSpaceRelease(Pointcolorspace1);
}



@end



@implementation HHPoint

@end