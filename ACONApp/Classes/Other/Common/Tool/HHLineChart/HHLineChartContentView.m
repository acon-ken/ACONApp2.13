//
//  HHLineChartContentView.m
//  TESTForLine
//
//  Created by sam.l on 14/12/23.
//  Copyright (c) 2014年 HYM. All rights reserved.
//

#import "HHLineChartContentView.h"
#import "HHLineChart.h"
#import "HHLineChartTool.h"
#import "LineChartInfo.h"

typedef enum : NSUInteger {
    MYDirectionX = 0,
    MYDirectionY,
    MYDirectionXandY,
} MYDirection;

@interface HHLineChartContentView ()
{
    CGFloat kScale_X;
    CGFloat kScale_Y;
    CGPoint kScale_center;
    CGPoint kOffset;
    BOOL isX;
    BOOL enableX;
    BOOL enableY;
    
}
@property (nonatomic,strong) HHLineChart *lineChartView;
@property (nonatomic,assign) MYDirection gestureDirection;
@end

@implementation HHLineChartContentView
- (instancetype)initWithFrame:(CGRect)frame;
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
        
        UIPinchGestureRecognizer *pin = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinchGestureRecognizer:)];
        [self addGestureRecognizer:pin];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
        
        UIPinchGestureRecognizer *pin = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinchGestureRecognizer:)];
        [self addGestureRecognizer:pin];
    }
    return self;
}

- (void)setTimeInterval:(NSInteger)timeInterval
{
    _timeInterval = timeInterval;
    if (self.lineChartView)
    {
        [self.lineChartView setTimeInterval:timeInterval];
    }
}
- (void)setDataSourceArray:(NSArray *)dataSourceArray
{
    _dataSourceArray = dataSourceArray;
    if ([_dataSourceArray count]<1) {
        
        if (self.lineChartView)
        {
            HHPoint *point = [HHPoint new];
            point.yValue = 0;
            point.xValue = 0;
            [self.lineChartView setLineSourceArray:@[point]];
        }
        return;
    }
    if ([[dataSourceArray lastObject]isKindOfClass:[LineChartInfo class]]) {
        NSDateFormatter *formate = [[NSDateFormatter alloc]init];
        formate.dateFormat = @"yyyy-MM-dd_HH:mm";
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 0; i < dataSourceArray.count; i ++) {
            LineChartInfo *info = [dataSourceArray objectAtIndex:i];
            HHPoint *point = [HHPoint new];
            point.yValue = [info.measureValueFormat doubleValue];
            NSString *str = [NSString stringWithFormat:@"%@_%@",info.measureTimeFormat,info.measureTimeT];
            NSDate *date = [formate dateFromString:str];
            point.xValue = (date.timeIntervalSince1970/60 - ((int)date.timeIntervalSince1970)%60);//分钟
            point.dateTime = date;
            point.time = info.measureTimeT ;
            point.date = info.measureTimeFormat;
            point.state = info.periodTypeNote;
            [array addObject:point];
        }
        _dataSourceArray = array;
    }
    
    if (self.lineChartView)
    {
        [self.lineChartView setLineSourceArray:self.dataSourceArray];
    }
}

- (void)setup
{
    CGRect lineFrame = self.frame;
    lineFrame.origin = CGPointMake(10, 10);
    lineFrame.size = CGSizeMake(lineFrame.size.width-20, lineFrame.size.height - 20);
    if (!self.lineChartView) {
         self.lineChartView = [[HHLineChart alloc]initWithFrame:lineFrame];
        [self addSubview:self.lineChartView];
//        self.lineChartView.backgroundColor = [UIColor blueColor];
    }
    [self.lineChartView setLineSourceArray:self.dataSourceArray];

    [self setNeedsDisplay];

}

- (void)setMaxY:(CGFloat)maxY
{
    _maxY = maxY;
    if (self.lineChartView)
    {
        self.lineChartView.maxValueY = maxY;
    }
}
- (void)setMinY:(CGFloat)minY
{
    _minY = minY;
    if (self.lineChartView)
    {
        self.lineChartView.minValueY = minY;
    }
}

- (void)setNormalY:(CGFloat)normalY
{
    _normalY = normalY;
    if (self.lineChartView)
    {
        self.lineChartView.normalValueY = normalY;
    }
}
- (void)setNormalValueRange:(CGSize)normalValueRange
{
    _normalValueRange = normalValueRange;
    if (self.lineChartView)
    {
        self.lineChartView.normalValueRange = _normalValueRange;
    }
}

- (void)setKCurrentDate:(NSDate *)currrentDate
{
    _kCurrentDate = currrentDate;
    if (self.lineChartView) {
        self.lineChartView.kCurrentDate = _kCurrentDate;
    }
}


- (void)drawRect1:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    /*
//    CGFloat normal[1]={1};
//    CGContextSetLineDash(context,0,normal,0); //画实线

    // Drawing code
    // 画 x、y轴
    CGPoint originPoint = CGPointMake(0, self.frame.size.height);
    CGPoint endYPoint = CGPointMake(0,0);
    CGPoint endXPoint = CGPointMake(self.frame.size.width,self.frame.size.height);
    [HHLineChartTool drawLine:context startPoint:originPoint endPoint:endXPoint lineColor:[UIColor blackColor]];
    [HHLineChartTool drawLine:context startPoint:originPoint endPoint:endYPoint lineColor:[UIColor blackColor]];
    
    // 画正常值范围
//    CGContextSetRGBStrokeColor(context,0.5,0.5,0.5,0.5);//线条颜色
    CGContextSetRGBFillColor(context, 0.5, 0.5, 0.5, 0.5);
//    CGContextSetStrokeColorWithColor(context, DEF_NOMAL_AREA_COLOR.CGColor);
//    CGContextSetLineWidth(context,200);
//    CGContextAddRect(context,CGRectMake(2,2,270,270));
    CGContextFillRect(context,CGRectMake(0, rect.size.height - self.minY - (self.maxY -self.minY), rect.size.width, self.maxY -self.minY));
    CGContextStrokePath(context);
    
    [HHLineChartTool drawLine:context startPoint:CGPointMake(0,rect.size.height - self.maxY) endPoint:CGPointMake(rect.size.width,rect.size.height - self.maxY) lineColor:[UIColor whiteColor] lineWith:0.5f];
    [HHLineChartTool drawLine:context startPoint:CGPointMake(0,rect.size.height - self.minY) endPoint:CGPointMake(rect.size.width,rect.size.height - self.minY) lineColor:[UIColor whiteColor] lineWith:0.5f];
    }
    */
}

#pragma mark -
#pragma mark 手势 调用 方法
- (void)pinchGestureRecognizer:(UIPinchGestureRecognizer *)sender
{
    //比例（经常用到放缩比例）这个属性默认值是1，通过获取放缩比例属性
    if( 2 == [sender numberOfTouches])
    {
        CGFloat scale =  [(UIPinchGestureRecognizer *)sender scale];
        //    //捏合的速度
        //    CGFloat velocity = [(UIPinchGestureRecognizer *)sender velocity];
        
        //    NSString *resultString = [[NSString alloc] initWithFormat:
        //
        //                              @"Pinch - scale = %f, velocity = %f",
        //
        //                              scale, velocity];
        
        //    NSLog(@"%@", resultString);
        //    if([sender state] == UIGestureRecognizerStateEnded) {
        if ([sender state] == UIGestureRecognizerStateBegan) {
            kScale_X = self.lineChartView.Scale_X;
            kScale_Y = self.lineChartView.Scale_Y;
            
            kOffset = self.lineChartView.contentOffset;
            
            CGPoint point1 = [sender locationOfTouch:0 inView:self];
            CGPoint point2 = [sender locationOfTouch:1 inView:self];
            if (0 == (point1.x - point2.x)) {
                isX = NO;
                self.gestureDirection = MYDirectionY;
            }else
            {
                CGFloat slope = (point1.y -point2.y)/(point1.x - point2.x);
                
//                double S = sqrt(fabs(slope));
                double flag = sqrt(3);
                if (slope >= - 1/flag && slope <= 1/flag) {
                    self.gestureDirection = MYDirectionX;
                }else if ((-flag < slope && slope < -1/flag) || (1/flag < slope && slope < flag))
                {
                    self.gestureDirection = MYDirectionXandY;
                    
                }else if (slope <= -flag || slope >= flag)
                {
                    self.gestureDirection = MYDirectionY;
                }
                
                if (slope>-1 && slope<1) {
                    isX = YES;
                }else
                {
                    isX = NO;
                }
            }
            CGPoint tempPoint = CGPointMake((point1.x + point2.x)/2, (point1.y +point2.y)/2);
//            kScale_center = [self convertPoint:tempPoint toView:_lineChartView];
            kScale_center = [_lineChartView convertPoint:tempPoint fromView:self];
            kScale_center.x -= _lineChartView.contentInset.left;// 调整手势中心点位置
//            NSLog(@"(%F,%F)",kScale_center.x,kScale_center.y);
        }
        if([sender state] == UIGestureRecognizerStateChanged) {
            if (scale > 1.0)
            { //放大

                switch (self.gestureDirection) {
                    case MYDirectionX:
                    {
                        if(scale*kScale_X <= self.lineChartView.max_Scanle_X)
                        {
                            [self.lineChartView setScale_X:kScale_X * scale];
                            enableX = YES;
                        }else
                        {
                            [self.lineChartView setScale_X:self.lineChartView.max_Scanle_X];
                            enableX = NO;
                        }

                    }
                        break;
                    case MYDirectionY:
                    {
                        if(scale*kScale_Y <= self.lineChartView.max_Scanle_Y)
                        {
                            [self.lineChartView setScale_Y:kScale_Y * scale];
                            enableY = YES;
                        }else
                        {
                            [self.lineChartView setScale_Y:self.lineChartView.max_Scanle_Y];
                            enableY = NO;
                        }

                    }
                        break;
                    case MYDirectionXandY:
                    {
                        if(scale*kScale_X <= self.lineChartView.max_Scanle_X)
                        {
                            [self.lineChartView setScale_X:kScale_X * scale];
                            enableX = YES;
                        }else
                        {
                            [self.lineChartView setScale_X:self.lineChartView.max_Scanle_X];
                            enableX = NO;
                        }
                        
                        if(scale*kScale_Y <= self.lineChartView.max_Scanle_Y)
                        {
                            [self.lineChartView setScale_Y:kScale_Y * scale];
                            enableY = YES;
                           
                        }else
                        {
                            [self.lineChartView setScale_Y:self.lineChartView.max_Scanle_Y];
                             enableY = NO;
                        }

                    }
                        break;
                    default:
                        break;
                }
                /*
                if (isX)
                {
                    if(scale*kScale_X <= self.lineChartView.max_Scanle_X)
                    {
                        [self.lineChartView setScale_X:kScale_X * scale];
                    }else
                    {
                        [self.lineChartView setScale_X:self.lineChartView.max_Scanle_X];
//                        return;
                    }

                }else
                {
                    if(scale*kScale_Y <= self.lineChartView.max_Scanle_Y)
                    {
                        [self.lineChartView setScale_Y:kScale_Y * scale];
                    }else
                    {
                        [self.lineChartView setScale_Y:self.lineChartView.max_Scanle_Y];
//                        return;
                    }
                }*/
                
            }
            else if (scale <1.0)
            { //缩小
                switch (self.gestureDirection) {
                    case MYDirectionX:
                    {
                        if(scale*kScale_X >= self.lineChartView.min_Scanle_X)
                        {
                            [self.lineChartView setScale_X:kScale_X * scale];
                            enableX = YES;
                        }else
                        {
                            [self.lineChartView setScale_X:self.lineChartView.min_Scanle_X];
                            enableX = NO;
                        }
                    }
                        break;
                    case MYDirectionY:
                    {
                        if(scale*kScale_Y >= self.lineChartView.min_Scanle_Y)
                        {
                            [self.lineChartView setScale_Y:kScale_Y * scale];
                            enableY = YES;
                        }else
                        {
                            [self.lineChartView setScale_Y:self.lineChartView.min_Scanle_Y];
                            enableY = NO;
                        }
                        
                    }
                        break;
                    case MYDirectionXandY:
                    {
                        if(scale*kScale_X >= self.lineChartView.min_Scanle_X)
                        {
                            [self.lineChartView setScale_X:kScale_X * scale];
                            enableX = YES;
                        }else
                        {
                            [self.lineChartView setScale_X:self.lineChartView.min_Scanle_X];
                            enableX = NO;
                            //                        return;
                        }
                        
                        if(scale*kScale_Y >= self.lineChartView.min_Scanle_Y)
                        {
                            [self.lineChartView setScale_Y:kScale_Y * scale];
                            enableY = YES;
                        }else
                        {
                            [self.lineChartView setScale_Y:self.lineChartView.min_Scanle_Y];
                            enableY = NO;
                            //                        return;
                        }
                        
                    }
                        break;
                    default:
                        break;
                }
                /*
                if (isX)//X轴缩放
                {
                    
                    if(scale*kScale_X >= self.lineChartView.min_Scanle_X)
                    {
                        [self.lineChartView setScale_X:kScale_X * scale];
                    }else
                    {
                        [self.lineChartView setScale_X:self.lineChartView.min_Scanle_X];
//                        return;
                    }
                    
                }else
                {
                    if(scale*kScale_Y >= self.lineChartView.min_Scanle_Y)
                    {
                        [self.lineChartView setScale_Y:kScale_Y * scale];
                    }else
                    {
                        [self.lineChartView setScale_Y:self.lineChartView.min_Scanle_Y];
//                        return;
                    }
                }*/
            }
            /*
            CGFloat x = isX?(1 - scale)*kScale_center.x + scale * kOffset.x:self.lineChartView.contentOffset.x;
            CGFloat y = isX ? self.lineChartView.contentOffset.y : ( (scale - 1) * (self.lineChartView.origin.y - kScale_center.y) + kOffset.y * scale);
             */
            
            CGFloat x = (1 - scale)*kScale_center.x + scale * kOffset.x;//:self.lineChartView.contentOffset.x;
            CGFloat y = ( (scale - 1) * (self.lineChartView.origin.y - kScale_center.y) + kOffset.y * scale);
            
            if (MYDirectionY == self.gestureDirection) {
                x = self.lineChartView.contentOffset.x;
//                NSLog(@"YYYYY");
            }else if (MYDirectionX == self.gestureDirection)
            {
                y = self.lineChartView.contentOffset.y;
//                NSLog(@"XXXXX");
            }
            if (!enableX) {
                x = self.lineChartView.contentOffset.x;
            }
            if (!enableY) {
                y = self.lineChartView.contentOffset.y;
            }
            
//            CGFloat y = isX?self.lineChartView.contentOffset.y :(self.lineChartView.origin.y -kScale_center.y +kOffset.y) * scale - self.lineChartView.currentSize.height *kScale_Y;// + kOffset.y;//    (1 - scale)*kScale_center.y + scale * kOffset.y;
//            NSLog(@"(%f,%f)",x,y);
            [self.lineChartView setContentOffset:CGPointMake(x, y)];
        }
        if([sender state] == UIGestureRecognizerStateEnded ||[sender state] ==
           UIGestureRecognizerStateFailed ||[sender state] == UIGestureRecognizerStateRecognized)
        {
            kScale_X = 1.0;
            kScale_Y = 1.0;
            kScale_center = CGPointZero;
        }
    }

//
//    if (touchesArr.count == 1) {
//
//        CGPoint touchLocation=[[touches anyObject] locationInView:self];
//        CGPoint prevouseLocation=[[touches anyObject] previousLocationInView:self];
//        float xDiffrance=touchLocation.x-prevouseLocation.x;
//        float yDiffrance=touchLocation.y-prevouseLocation.y;
//
//        [self setNeedsDisplay];
//    }

}
@end
