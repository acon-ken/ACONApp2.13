//
//  HHLineChart.m
//  TESTForLine
//
//  Created by sam.l on 14/12/22.
//  Copyright (c) 2014年 HYM. All rights reserved.
//

#import "HHLineChart.h"
#import "HHLineChartTool.h"
#import <CoreText/CoreText.h>
#import <objc/runtime.h>
typedef enum : NSUInteger {
    XPerStepValueModelWeek = 1,
    XPerStepValueModelDAY ,
    XPerStepValueModelHour,
    XPerStepValueModelMinutes,
}XPerStepValueModel;
@interface HHLineChart ()
{
    UITouch *lastTouch;
    
    // 缩放 两点之间距离
    double t_x_distance;
    double t_y_distance;
    // 缩放 中心点
    CGPoint touchCenter;
    UILabel *_label;
    
    // 提示文字所在位置
    CGPoint textLocation;
    NSString *text;
    
//    NSMutableArray *kBtnArray;
    
    NSMutableSet *reusableButtonSet;
    NSMutableSet *visableButtonSet;
    //** x轴方向 标题 偏移量*/
    CGFloat xTitleOffset;
    // x 轴显示日期格式
    NSDateFormatter *kDAteFormater;

}
/** 每格像素值 动态 */
@property (nonatomic,assign) CGFloat xPerStepPX;
@property (nonatomic,assign) CGFloat yPerStepPX;
/**********************  真实数值 ********************/

@property (nonatomic,assign) CGFloat begainX;// 点 数组中 最小X值
@property (nonatomic,assign) CGFloat begainY;// 点 数组中 最小Y值
@property (nonatomic,assign) CGFloat endX;// 点 数组中 最大X值
@property (nonatomic,assign) CGFloat endY;// 点 数组中 最大Y值

// x轴每格代表的真实值 模式 天，小时，分钟
//@property (nonatomic,assign) XPerStepValueModel xPerStepValueModel;

// x，y轴  刻度每格代表的 真实数值 大小

/** x 每格真实值 */
@property (nonatomic,assign) NSInteger xPerStepValue;
/** y 每格真实值 */
@property (nonatomic,assign) CGFloat yPerStepValue;

/******************  比例 ： 像素／真实数值 ****************/

// x，y轴  像素／真实数值
/** x轴  像素／真实数值 */
@property (nonatomic,assign) CGFloat x_PX_Scale_Value;
/** y轴  像素／真实数值 */
@property (nonatomic,assign) CGFloat y_PX_Scale_Value;

/**********************  px 像素数值 ********************/

//PX 血糖最高值 PX
@property (nonatomic,assign,readonly) CGFloat max_PX_Y;
//PX 血糖最低值 PX
@property (nonatomic,assign,readonly) CGFloat min_PX_Y;


/********************** 其他 ********************/
// 数据源
@property (nonatomic,retain) NSArray *dataSourceArray;

//**  详情文字描述 字体 */
@property (nonatomic,retain) UIFont *detailTextFont;

@property (nonatomic,retain) NSMutableArray *x_Title_Array;//x轴刻度
@property (nonatomic,retain) NSMutableArray *Y_Title_Array;//y轴刻度

// 网格 线条颜色
@property (nonatomic,retain) UIColor *line_Color_X;
@property (nonatomic,retain) UIColor *line_Color_Y;

static bool isLineIntersectRectangle(CGFloat linePointX1,
                                     CGFloat linePointY1,
                                     CGFloat linePointX2,
                                     CGFloat linePointY2,
                                     CGFloat rectangleLeftTopX,
                                     CGFloat rectangleLeftTopY,
                                     CGFloat rectangleRightBottomX,
                                     CGFloat rectangleRightBottomY);
@end

@implementation HHLineChart

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code

        [self steup];
    }
    return self;

}
- (instancetype)init
{
    self = [super init];
    if (self) {
        // Initialization code
        
        [self steup];
    }
    return self;
}
#pragma mark 初始化
- (void)steup
{
    self.clearsContextBeforeDrawing = YES;
    self.contentOffset = CGPointMake(0, 0);
    _Scale_X = 1.0;
    _Scale_Y = 1.0;
    
    /*    (0,0) ----------> X（轴）
     |  （视图上的坐标系）
     |
     |
     V
     (Y轴)
     ^
     |  （期望的坐标系）
     |
     |-------------> X (轴)
     */
    self.origin = CGPointMake(50, (self.frame.size.height - 60));
    
    self.begainX = 0;
    self.begainY = 0;
    self.endX = 0;
    self.endY = 0;
    
    self.maxValueY = 0;
    self.minValueY = 0;
    
    self.x_TitleFont = [UIFont systemFontOfSize:9.f];
    self.y_TitleFont = [UIFont systemFontOfSize:9.f];
    
    self.x_PX_Scale_Value = 30;
    //        self.y_PX_Scale_Value = 10;
    self.y_PX_Scale_Value = 30;
    //        self.x_PX_Scale_Value = (frame.size.width - _origin.x)*1000/20;
    
    self.xPerStepValue = 60;
//    self.xPerStepValueModel = XPerStepValueModelDAY;
    self.line_Color_X = [UIColor blackColor];
    self.yPerStepValue = 5;
    
    
    self.detailTextFont = [UIFont systemFontOfSize:10.0f];
    
    self.contentInset = UIEdgeInsetsMake(0, self.x_PX_Scale_Value, 0, self.x_PX_Scale_Value);
    
    //  初始化 重用／当前显示的button 集合
    reusableButtonSet = [NSMutableSet set];
    visableButtonSet = [NSMutableSet set];
    
    //** x轴方向 标题 偏移量*/
    xTitleOffset = 0;
    
    _timeInterval = 7;//默认过去七天
    kDAteFormater = [[NSDateFormatter alloc]init];
    kDAteFormater.dateFormat = @"MM月dd日";//yyyy年
    
    [self reloadData];
    self.backgroundColor = [UIColor clearColor];
}
#pragma mark -
#pragma mark 真实值

#pragma mark 真实 血糖值 范围
- (void)setMaxValueY:(CGFloat)maxValueY
{
    _maxValueY = maxValueY;
    [self setNeedsDisplay];
}

- (void)setNormalValueY:(CGFloat)normalValueY
{
    _normalValueY = normalValueY;
    [self setNeedsDisplay];
}

- (void)setMinValueY:(CGFloat)minValueY
{
    _minValueY = minValueY;
    [self setNeedsDisplay];
}

- (void)setNormalValueRange:(CGSize)normalValueRange
{
    _normalValueRange = normalValueRange;
    [self setNeedsDisplay];
}

#pragma mark -
#pragma mark 像素值
#pragma mark 像素值 血糖值 范围
/**
 *  血糖值范围
 */
- (CGFloat)max_PX_Y
{
     return self.normalValueRange.height *_y_PX_Scale_Value*_Scale_Y + (self.frame.size.height - _origin.y);
    // 真实值 * Y每格刻度值 * Y方向缩放比例 ＋ 原点Y坐标
}
- (CGFloat)min_PX_Y
{
    return self.normalValueRange.width *_y_PX_Scale_Value*_Scale_Y + (self.frame.size.height - _origin.y);
}

#pragma mark 缩放比例 X 轴 Y轴
- (void)setScale_X:(CGFloat)Scale_X
{
    _Scale_X = Scale_X;
    
    //  每格像素值    // self.x_PX_Scale_Value *self.xPerStepValue*self.Scale_X
    if (self.xPerStepPX >= (6.0/4.0)*self.x_PX_Scale_Value - 1)
    {
        // 放大视图
        
        if (self.xPerStepValue/(60*24) < 2) //两天
        {
            if (self.xPerStepValue < 60*2) {
                self.xPerStepValue = 60;
            }else if (self.xPerStepValue >= 60*2)
            {
                self.xPerStepValue-=1*60;//小时
            }
        }
        else if (self.xPerStepValue/(60*24)<=15)//15天
        {
            self.xPerStepValue -=1*60*24;//天
            if (self.xPerStepValue/(60*24) < 1) {
                self.xPerStepValue = 60*24;
            }
        }
        else if (self.xPerStepValue/(60*24*30)<=2)//两个月
        {
            self.xPerStepValue -= 60*24*15;//天
            if (self.xPerStepValue/(60*24*15) < 1) {
                self.xPerStepValue = 60*24*15;
            }
        }
        else if (self.xPerStepValue/(60*24*365)<=1)  // 大于两个月 小与1年
        {
            self.xPerStepValue -= 60*24*30;//月
            if (self.xPerStepValue/(60*24*30)<2)
            {
                self.xPerStepValue = 60*24*30*2;
            }
        }
        else //大于1年
        {
            self.xPerStepValue -= 60*24*365;//年
            if (self.xPerStepValue/(60*24*365)<1)
            {
                self.xPerStepValue = 60*24*365;
            }

        }
        
        [self setX_Title_Array:nil];
    }
    else if (self.xPerStepPX < self.x_PX_Scale_Value - 1)
    {
        
        // 缩小视图
        if (self.xPerStepValue/(60*24) < 2)// 两天
        {
            self.xPerStepValue+=1*60;//小时
            
        }else if (self.xPerStepValue/(60*24)<=15)//15天
        {
            if (self.xPerStepValue/(60*24)<3) {
                self.xPerStepValue = 60*24*2;
            }
            self.xPerStepValue +=1*60*24;//天
            
        }else if (self.xPerStepValue/(60*24*30)<=2)//两个月
        {
            self.xPerStepValue += 60*24*15;//天
            
        }else if (self.xPerStepValue/(60*24*365)<=1)// 小雨1年
        {
            self.xPerStepValue +=60*24*30;//月
        }
        else //大于1年
        {
            self.xPerStepValue +=60*24*365;//年
        }
        
        //self.xPerStepValue +=1*60;//小时
        [self setX_Title_Array:nil];
    }
    
    if ((self.xPerStepPX < self.x_PX_Scale_Value - 1)) {
        self.Scale_X = Scale_X;
        return;
    }
    
    [self setNeedsDisplay];
}

- (void)setScale_Y:(CGFloat)Scale_Y
{
    _Scale_Y = Scale_Y;
    
    //  每格像素值
    // self.y_PX_Scale_Value *self.yPerStepValue*self.Scale_y
    if (self.yPerStepPX >= (6.0/4.0)*self.y_PX_Scale_Value - 1)
    {//y放大
        if (self.yPerStepValue <= 1.0) {
            if (self.yPerStepValue <= 0.1) {
                self.yPerStepValue = 0.1;
            }else
            {
                self.yPerStepValue -= 0.1;
            }
        }
        else if (self.yPerStepValue >1.0 && self.yPerStepValue <= 5.0)
        {
            self.yPerStepValue -= 1.0;
        }
        else
        {
            if (self.yPerStepValue <10.0) {
                self.yPerStepValue = 5.0;
            }else
            {
                self.yPerStepValue -= 5.0;
            }
        }

        [self setY_Title_Array:nil];
    }
    else if (self.yPerStepPX < self.y_PX_Scale_Value - 1)
    {
        // 缩小视图
        if (self.yPerStepValue <=1.0) {
            self.yPerStepValue+=0.1;
        }
        else if (self.yPerStepValue >1.0 && self.yPerStepValue < 5.0)
        {
            self.yPerStepValue += 1.0;
        }
        else
        {
            if (self.yPerStepValue <10.0) {
                self.yPerStepValue = 5.0;
            }else
            {
                self.yPerStepValue += 5.0;
            }
        }

        [self setY_Title_Array:nil];
    }
    
    [self setNeedsDisplay];
}

#pragma mark 每格像素值 X 轴 Y轴
/** 每格像素值 */
- (CGFloat)xPerStepPX
{
    return self.x_PX_Scale_Value *self.xPerStepValue*self.Scale_X;
}
- (CGFloat)yPerStepPX
{
    return self.y_PX_Scale_Value*self.yPerStepValue*self.Scale_Y;
}

#pragma mark 最小缩放比例 X 轴 Y轴
/** 最小缩放比例 */
- (CGFloat)min_Scanle_X
{
    //根据_contentInset调整缩放比例
    return (self.frame.size.width - _origin.x - _contentInset.left - _contentInset.right)/((_endX - _begainX)*_x_PX_Scale_Value + _contentInset.left + _contentInset.right);
    
     return (self.frame.size.width - _origin.x)/((_endX - _begainX)*_x_PX_Scale_Value + _contentInset.left + _contentInset.right);
}
- (CGFloat)min_Scanle_Y
{
    return _origin.y/(self.currentSize.height*_y_PX_Scale_Value);
    return 1.0;
}

#pragma mark 最大缩放比例 X 轴 Y轴

/** 最大缩放比例 */
- (CGFloat)max_Scanle_X
{
    //最大比例，原比例
    return 1.0/60.0;// 分钟为单位 1   小时为单位1/60  ?；
    return ((_endX - _begainX)*_x_PX_Scale_Value + _contentInset.left + _contentInset.right)/(self.frame.size.width - _origin.x);
}
- (CGFloat)max_Scanle_Y
{
    return 10.0;
}

#pragma mark -
#pragma mark 设置偏移量
-(void)setContentOffset:(CGPoint)contentOffset
{
    

    
    if (-contentOffset.x > (_Scale_X * (self.endX - self.begainX)*_x_PX_Scale_Value - self.frame.size.width + _contentInset.left + _contentInset.right) + _origin.x)
    {
        contentOffset.x = -(_Scale_X * (self.endX - self.begainX)*_x_PX_Scale_Value - self.frame.size.width + _contentInset.left + _contentInset.right +  _origin.x);
    }

    if (contentOffset.x > 0) {
        contentOffset.x = 0;
    }
    if (self.Scale_X > self.max_Scanle_X) {
        self.Scale_X = self.max_Scanle_X;
    }
    if (self.Scale_X < self.min_Scanle_X) {
        self.Scale_X = self.min_Scanle_X;
    }

    
    if (contentOffset.y > (_Scale_Y * self.currentSize.height * _y_PX_Scale_Value -  _origin.y))
    {
        contentOffset.y = _Scale_Y * self.currentSize.height * _y_PX_Scale_Value -  _origin.y;
    }
    if (contentOffset.y < 0) {
        contentOffset.y = 0;
    }
    if (self.Scale_Y > self.max_Scanle_Y) {
        self.Scale_Y = self.max_Scanle_Y;
    }
    if (self.Scale_Y < self.min_Scanle_Y) {
        self.Scale_Y = self.min_Scanle_Y;
    }
    _contentOffset = contentOffset;
    
}

#pragma mark 加载新的数据源

- (void)setLineSourceArray:(NSArray *)dataSourceArray
{
    self.dataSourceArray = dataSourceArray;
    [self reloadData];
}


#pragma mark 设置当前日期

- (void)setKCurrentDate:(NSDate *)currentDate
{
    _kCurrentDate = currentDate;
    [self reloadData];
}


#pragma mark 重载数据源
- (void)reloadData
{
    if (self.dataSourceArray == nil) {
        return;
    }
    // 重载数据源 重设偏移量
    self.contentOffset = CGPointZero;
    
    NSArray *dataSourceArray = [NSArray arrayWithArray:self.dataSourceArray];
    if (dataSourceArray == nil) {
        return;
    }
    NSSortDescriptor *sortDescriptor1 = [NSSortDescriptor sortDescriptorWithKey:@"_xValue" ascending:YES];
    NSSortDescriptor *sortDescriptor2 = [NSSortDescriptor sortDescriptorWithKey:@"_yValue" ascending:YES];
   
    
    NSArray *array = [dataSourceArray sortedArrayUsingDescriptors:[NSArray arrayWithObjects:sortDescriptor2, nil]];
    HHPoint *point2 = [array objectAtIndex:0];
    _begainY = point2.yValue *_y_PX_Scale_Value;
    _endY = [[array lastObject] yValue]*_y_PX_Scale_Value;
    
    self.dataSourceArray = [dataSourceArray sortedArrayUsingDescriptors:[NSArray arrayWithObjects:sortDescriptor1, nil]];
//    HHPoint *point1 = [self.dataSourceArray objectAtIndex:0];
    
//** 初始化时起点为当前时间的 过去 八天（实际 数据 显示 七 天） */

    NSDate *begainDate = [self.kCurrentDate dateByAddingTimeInterval:-60*60*24*_timeInterval];
//    double timeInterval = begainDate.timeIntervalSince1970/(60*60*24) - ((int)begainDate.timeIntervalSince1970)%(60*60*24);
//    NSDate *begainDateLine = [NSDate dateWithTimeIntervalSince1970:((int)begainDate.timeIntervalSince1970)/(60*60*24)];
//    NSDate *begainDateLine2 = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    _begainX = ((int)begainDate.timeIntervalSince1970)/60;
    _endX = ((int)[[self.kCurrentDate dateByAddingTimeInterval:(60*60*24 -1)] timeIntervalSince1970])/60;
//    _begainX = point1.xValue ;
//    _endX = [[self.dataSourceArray lastObject] xValue] ;

    
    self.Scale_X = self.min_Scanle_X;
    self.Scale_Y = self.min_Scanle_Y;
    self.xPerStepValue = ( (int)((_endX - _begainX)/7)/60 + 1 )*60;
    self.yPerStepValue = ( (int)((self.currentSize.height * 10.0)/(45.0/5) + 10.0))/10.0;
    
    [self setY_Title_Array:nil];
    [self setX_Title_Array:nil];
    [self setNeedsDisplay];
}

- (CGSize)currentSize
{
    return CGSizeMake((_endX-_begainX), (40 - 0));

    return CGSizeMake((_endX-_begainX), (_endY -_begainY));
}

#pragma mark -
#pragma mark 设置X，Y轴标题

- (void)setX_Title_Array:(NSMutableArray *)x_Title_Array
{
    if (!_x_Title_Array)
    {
        _x_Title_Array = [[NSMutableArray alloc]init];
    }

    [_x_Title_Array removeAllObjects];

    if (!self.dataSourceArray) {
        return;
    }
    
//    for (int i = 0; i <= (self.frame.size.width - self.origin.x)/self.x_PX_Scale_Value; i++) {
//        
//    }
#warning 数据过多的话，用［分线］程处理 以下数据

    xTitleOffset =  _begainX - ((int)(_begainX/60))*60 ;
/*
 // 数据量较多
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
    NSNumber *xValue = [NSNumber numberWithInteger:_xPerStepValue];
    objc_setAssociatedObject(self,
                             @"xPerStepValue",
                             xValue,
                             OBJC_ASSOCIATION_RETAIN);
    
    dispatch_async(queue, ^{
        NSMutableArray *tempArray = [NSMutableArray array];
        for (int i = _begainX ; i <= _endX + self.xPerStepValue ; i += self.xPerStepValue)
        {
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:((int)(i/60))*60*60];//初始化为 小时为单位
            [tempArray addObject:[NSString stringWithFormat:@"%@",[kDAteFormater stringFromDate:date]]];
        }

        dispatch_async(dispatch_get_main_queue(), ^{
        NSInteger inum = [objc_getAssociatedObject(self, @"xPerStepValue") integerValue];
            
            if (inum == xValue.integerValue) {
                [_x_Title_Array removeAllObjects];
                [_x_Title_Array addObjectsFromArray:tempArray];
                [self setNeedsDisplay];
            }
        });
    });
    
    return;
 */
// 数据量较小
    for (int i = _begainX ; i <= _endX + self.xPerStepValue; i += self.xPerStepValue)
    {
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:((int)(i/60))*60*60];//初始化为 小时为单位
        if (self.xPerStepValue >= 2*60*24) {// 美格代表的分钟数
            [kDAteFormater setDateFormat:@"MM月dd\nyyyy年"];//yyyy年
        }else
        {
            [kDAteFormater setDateFormat:@"HH:mm\nyy年MM月dd日"];
        }
//        [kDAteFormater setDateFormat:@"HH:mm\nMM月dd日"];

        [_x_Title_Array addObject:[NSString stringWithFormat:@"%@",[kDAteFormater stringFromDate:date]]];
    }

    return;
    
//    NSSortDescriptor *sortDescriptor1 = [NSSortDescriptor sortDescriptorWithKey:@"_timeIntervalSinceNow" ascending:YES];
//    _x_Title_Array = [NSMutableArray arrayWithArray:[_x_Title_Array sortedArrayUsingDescriptors:[NSArray arrayWithObjects:sortDescriptor1, nil]]];

}

- (void)setY_Title_Array:(NSMutableArray *)Y_Title_Array
{
    if (_Y_Title_Array)
    {
        [_Y_Title_Array removeAllObjects];
    }
    else
    {
        _Y_Title_Array = [[NSMutableArray alloc]init];
    }
    
    // 数据量较小
    // 数据量较小
    for (NSInteger i = 0 ; i < self.currentSize.height*10.0 + self.yPerStepValue*10.0 +0.1; i +=  (floor(self.yPerStepValue*10.0+0.01)<=0)?1: floor(self.yPerStepValue*10.0+0.01))
    {
        [_Y_Title_Array addObject:[NSString stringWithFormat:@"%.1f",i/10.0]];
        //        if (floor(self.yPerStepValue*10.0+0.01)<=0) {
        //            NSLog(@"______________%f_________________",self.yPerStepValue*10.0);
        //        }
        
    }

    return;
    
    for (int i = 0; i <=40; i +=5)
    {
 
        [_Y_Title_Array addObject:[NSNumber numberWithInt:i]];
    }
    
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
#pragma mark -
#pragma mark 画图
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
/********************** - 像素坐标系 刻度范围 - ***********************/
    /*
    if (DEF_IS_TEST)
    {
//        for (CGFloat index = self.origin.x; index < rect.size.width; index+=20) {
//            
//                //画竖线（不包含原点位置的竖线）
//    //            CGFloat dashPattern[]= {6.0, 5};
//    //            CGContextSetLineDash(context, 0.0, dashPattern, 2); //虚线效果
//                [HHLineChartTool drawLine:context
//                               startPoint:CGPointMake(index, rect.size.height)
//                                 endPoint:CGPointMake(index, 0)
//                                lineColor:[UIColor redColor]];
//        }
        for (CGFloat index = _begainX; index <= self.endX; index+=60) {
            
                // 起始点
                CGFloat startPointX = _Scale_X * (index  - _begainX)*_x_PX_Scale_Value + _origin.x + _contentOffset.x;// 向手势X方向挪动

                
                          // 转换坐标
            CGFloat start = startPointX + _contentInset.left;
   
                
                CGFloat normal[1]={1};
                CGContextSetLineDash(context,0,normal,0); //画实线
                
                [HHLineChartTool drawLine:context startPoint:CGPointMake(start, 0) endPoint:CGPointMake(start, rect.size.height) lineColor:[UIColor redColor]];
            [[UIColor redColor] setStroke];
            NSString *valStr = [NSString stringWithFormat:@"%.f", index];
             CGSize title1Size = [valStr sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:self.x_TitleFont,NSFontAttributeName,nil]];
            CGRect titleRect1 = CGRectMake(start - (title1Size.width)/2,
                                           self.origin.y - title1Size.height,
                                           title1Size.width,
                                           title1Size.height);
            
             //Save the current context and do the character rotation magic.
            CGContextSaveGState(context);
            CGContextTranslateCTM(context, start, self.origin.y - title1Size.height);//设置 转换 坐标系 原点（旋转中心）
            CGAffineTransform textTransform = CGAffineTransformMakeRotation(M_PI_4);// 设置旋转角度顺时针 旋转中心 所画 字符串 的origin 坐标
            CGContextConcatCTM(context, textTransform);
            //    CGContextTranslateCTM(context, -100, -400);
            
            //Draw the character
            [valStr drawAtPoint:CGPointMake(start + titleRect1.size.width/2, self.origin.y - 2) withAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:20.0f],NSFontAttributeName, nil]];
            CGContextRestoreGState(context);
            
            
            [valStr drawInRect:titleRect1 withAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:12.f],NSFontAttributeName,nil]];
        }

    }

*/
/*****************************************************************/

/*****************************************************************/
#pragma mark y坐标轴  刻度范围
/********************** - y坐标轴 刻度范围 - ***********************/
    
    
    CGPoint originPoint = self.origin;
    CGPoint endYPoint = CGPointMake(_origin.x,0);
    CGPoint endXPoint = CGPointMake(self.frame.size.width ,_origin.y);
    [HHLineChartTool drawLine:context startPoint:originPoint endPoint:endXPoint lineColor:[UIColor blackColor]];
    [HHLineChartTool drawLine:context startPoint:originPoint endPoint:endYPoint lineColor:[UIColor blackColor]];
    
    // 画正常值范围
    
    //    CGContextSetRGBStrokeColor(context,0.5,0.5,0.5,0.5);//线条颜色
//    CGContextSetRGBFillColor(context, 0.5, 0.5, 0.5, 0.5);
    [DEF_FILL_COLOR setFill];
    //    CGContextSetStrokeColorWithColor(context, DEF_NOMAL_AREA_COLOR.CGColor);
    //    CGContextSetLineWidth(context,200);
    //    CGContextAddRect(context,CGRectMake(2,2,270,270));
    CGFloat minRange = (_origin.y - _Scale_Y * self.normalValueRange.width * _y_PX_Scale_Value + _contentOffset.y); // 向手势Y方向（下）挪动
    CGFloat maxRange = (_origin.y - _Scale_Y * self.normalValueRange.height * _y_PX_Scale_Value + _contentOffset.y); // 向手势Y方向（下）挪动
    if (minRange >= maxRange && minRange<=_origin.y)
    {
        [HHLineChartTool drawLine:context startPoint:CGPointMake(_origin.x,minRange) endPoint:CGPointMake(rect.size.width,minRange) lineColor:[UIColor whiteColor] lineWith:0.5f];
    }
    if (maxRange<= _origin.y)
    {
        [HHLineChartTool drawLine:context startPoint:CGPointMake(_origin.x,maxRange) endPoint:CGPointMake(rect.size.width,maxRange) lineColor:[UIColor whiteColor] lineWith:0.5f];
    }
    
    if (minRange >=_origin.y) {
        minRange = _origin.y;
    }
    if (maxRange <=_origin.y) {
        CGContextFillRect(context,CGRectMake(_origin.x, minRange , rect.size.width, maxRange - minRange));
        CGContextStrokePath(context);
    }


    
 
    
#pragma mark 文字 偏高 偏低 正常
    
    UIFont *font = [UIFont systemFontOfSize:12.f];
    
    CGFloat kSpace2Orgain = 25;
    CGSize textSize = [@"偏高" sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,nil]];
    CGFloat maxY = (_origin.y - _Scale_Y * self.maxValueY * _y_PX_Scale_Value + _contentOffset.y); // 向手势Y方向（下）挪动
    CGFloat nomalY = (_origin.y - _Scale_Y * self.normalValueY * _y_PX_Scale_Value + _contentOffset.y); // 向手势Y方向（下）挪动
    CGFloat minY = (_origin.y - _Scale_Y * self.minValueY * _y_PX_Scale_Value + _contentOffset.y); // 向手势Y方向（下）挪动

    if (maxY<=_origin.y) {
        [@"偏高" drawAtPoint:CGPointMake(self.origin.x - textSize.width - kSpace2Orgain,maxY - textSize.height/2) withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:DEF_P_COLOR_MAX}];
        
        [HHLineChartTool drawLine:context startPoint:CGPointMake(_origin.x,maxY) endPoint:CGPointMake(rect.size.width,maxY) lineColor:DEF_P_COLOR_MAX lineWith:0.5f];

    }
    if (nomalY<=_origin.y) {
        
        [@"正常" drawAtPoint:CGPointMake(self.origin.x - textSize.width - kSpace2Orgain,nomalY - textSize.height/2) withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:DEF_P_COLOR_NOMAL}];
         [HHLineChartTool drawLine:context startPoint:CGPointMake(_origin.x,nomalY) endPoint:CGPointMake(rect.size.width,nomalY) lineColor:DEF_P_COLOR_NOMAL lineWith:0.5f];
    }
    if (minY<=_origin.y) {
        [@"偏低" drawAtPoint:CGPointMake(self.origin.x - textSize.width - kSpace2Orgain,minY - textSize.height/2) withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:DEF_P_COLOR_MIN}];
         [HHLineChartTool drawLine:context startPoint:CGPointMake(_origin.x,minY) endPoint:CGPointMake(rect.size.width,minY) lineColor:DEF_P_COLOR_MIN lineWith:0.5f];
    }

//       [@"0123\n456789" drawInRect:CGRectMake(100, 100, 100, 100) withAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:20.0f],NSFontAttributeName,[UIColor redColor],NSForegroundColorAttributeName,@3,NSStrokeWidthAttributeName ,[UIColor greenColor],NSStrokeColorAttributeName, nil]];
    
    // 起始点
//    CGFloat textPointX = textLocation.x  - _contentOffset.x;// 向手势X方向挪动
//    CGFloat testPointY = (_origin.y - );// － _contentOffset.y; // 向手势Y方向（下）挪动
 
    
/*****************************************************************/
#pragma mark 下边 x 刻度
/************************ - 水平方向刻度 - *************************/
    
    NSInteger begain;
    NSInteger end;
    
    double indexBegain = (_x_PX_Scale_Value*_Scale_X*xTitleOffset - _contentOffset.x - _contentInset.left)/(_x_PX_Scale_Value * _xPerStepValue * _Scale_X);
    double indexEnd = (rect.size.width - self.origin.x + _x_PX_Scale_Value*_Scale_X*xTitleOffset - _contentOffset.x - _contentInset.left)/(_x_PX_Scale_Value * _xPerStepValue * _Scale_X);
    
    begain = (int)floor(indexBegain);
    end = (int)ceil(indexEnd);
    
    //数组边界 过滤
    begain = begain>=0?begain:0;
    end = (end<=self.x_Title_Array.count-1)?end:(self.x_Title_Array.count-1);
    
    for (NSInteger index = begain; index <= end; index++) {
        //    for (NSInteger index=0; index < self.x_Title_Array.count; index++) {
        
        NSString *str = [self.x_Title_Array objectAtIndex:index];
        NSString *valStr = [NSString stringWithFormat:@"%@", str];
        
        float xPosition = self.origin.x + index* self.x_PX_Scale_Value *self.xPerStepValue*self.Scale_X + self.contentOffset.x + self.contentInset.left - ( self.x_PX_Scale_Value*self.Scale_X * xTitleOffset) ;
        
        if (xPosition > self.origin.x && xPosition < rect.size.width) {
            
            //画x轴文字
            //            CGContextSetTextDrawingMode(<#CGContextRef c#>, <#CGTextDrawingMode mode#>)
            
            CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
            CGSize title1Size = [valStr sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:self.x_TitleFont,NSFontAttributeName,nil]];
            //            CGRect titleRect1 = CGRectMake(xPosition - (title1Size.width)/2,
            //                                           self.origin.y + 2,
            //                                           title1Size.width,
            //                                           title1Size.height);
            //            CGAffineTransform textTransForm = CGAffineTransformMakeRotation(-M_PI_4);
            //            CGContextSetTextMatrix(context, textTransForm);
            //             [valStr drawInRect:titleRect1 withAttributes:[NSDictionary dictionaryWithObjectsAndKeys:self.x_TitleFont,NSFontAttributeName,nil]];
            
 //********** 字体旋转 ***********/
            //Save the current context and do the character rotation magic.
            CGContextSaveGState(context);
            CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);

            CGContextTranslateCTM(context, xPosition, self.origin.y);//设置 转换 坐标系 原点（旋转中心）
            CGAffineTransform textTransform = CGAffineTransformMakeRotation(M_PI_4);// 设置旋转角度顺时针 旋转中心 所画 字符串 的origin 坐标
            CGContextConcatCTM(context, textTransform);
    
            //Draw the character
            [valStr drawAtPoint:CGPointMake(/*(title1Size.height/2)*sin(M_PI_4)*/ 0, 0) withAttributes:[NSDictionary dictionaryWithObjectsAndKeys:self.x_TitleFont,NSFontAttributeName, nil]];
            
            //Restore context to make sure the rotation is only applied to this character.
            CGContextRestoreGState(context);
            
 //********** 字体旋转 end ***********/
            
            //画竖线（不包含原点位置的竖线）
            CGFloat dashPattern[]= {6.0, 5};
            CGContextSetLineDash(context, 0.0, dashPattern, 2); //虚线效果
            [HHLineChartTool drawLine:context
                             startPoint:CGPointMake(xPosition, self.origin.y)
                               endPoint:CGPointMake(xPosition, 0)
                              lineColor:self.line_Color_X];
        }
    }

/************************   -- END ---   *************************/
    
/*****************************************************************/
#pragma mark 左边 y 刻度
/********************** - 左边垂直方向刻度 - ***********************/

    for (NSInteger i = 0; i < self.Y_Title_Array.count; i++) {
        NSNumber *num = [self.Y_Title_Array objectAtIndex:i];
        NSString *valStr = [NSString stringWithFormat:@"%.2lf", [num doubleValue]];
//        CGSize textSize = [valStr sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:self.y_TitleFont,NSFontAttributeName,nil]];
        
        
        CGFloat yPosition = _origin.y - (i) * self.y_PX_Scale_Value *_yPerStepValue*self.Scale_Y + self.contentOffset.y;// - (textSize.height/2);
        
        if (yPosition > 0 &&yPosition<=_origin.y) {
            //画左y轴文字
//        [[UIColor redColor] set];
            CGSize title1Size = [valStr sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:self.y_TitleFont,NSFontAttributeName,nil]];
            CGRect titleRect1 = CGRectMake(_origin.x - title1Size.width-1,
                                           yPosition - (title1Size.height)/2,
                                           title1Size.width,
                                           title1Size.height);
            
            [valStr drawInRect:titleRect1 withAttributes:[NSDictionary dictionaryWithObjectsAndKeys:self.y_TitleFont,NSFontAttributeName,nil]];
            
            /*  不要虚线
            //画横线（不包含原点位置的横线）
            CGFloat dashPattern[]= {6.0, 5};
            CGContextSetLineDash(context, 0.0, dashPattern, 2); //虚线效果
            if (yPosition >= _origin.y) {
                continue;
            }
            [HHLineChartTool drawLine:context
                             startPoint:CGPointMake(self.origin.x, yPosition)
                               endPoint:CGPointMake(rect.size.width, yPosition)
                              lineColor:[UIColor grayColor]];
             */
        }
    }

 
/************************   -- END ---   *************************/
#pragma mark 数据源 画折线
/*****************************************************************/
/************************ 根据数据源画折线 *************************/
//    CGFloat self_Height = self.frame.size.height;

    [reusableButtonSet addObjectsFromArray:[visableButtonSet allObjects]];
    for (UIButton *button in reusableButtonSet) {
        [button removeFromSuperview];
    }
    [visableButtonSet removeAllObjects];
    
    if (self.dataSourceArray && self.dataSourceArray.count > 0) {
    
        for (NSInteger i = 0; i < self.dataSourceArray.count-1; i++) {
            
            HHPoint *point1 = [self.dataSourceArray objectAtIndex:i];
            HHPoint *point2 = [self.dataSourceArray objectAtIndex:i+1];
            
//            NSLog(@"(%f,%f)",point1.xValue,point1.yValue);
            
           
            
            // 暂不做Y方向
 /*           // 起始点
            CGFloat startPointX = _Scale_X * (point1.xValue - _origin.x - _begainX) + _contentOffset.x;// 向手势X方向挪动
            CGFloat startPointY = self_Height - (point1.yValue - _origin.y);// + _contentOffset.y; // 向手势Y方向挪动
            // 终止点
            CGFloat endPointX = _Scale_X * (point2.xValue - _origin.x - _begainX) + _contentOffset.x;
            CGFloat endPointY = self_Height - (point2.yValue - _origin.y);// + _contentOffset.y; // 向手势Y方向挪动
*/
            // 起始点
            CGFloat startPointX = _Scale_X * (point1.xValue  - _begainX)*_x_PX_Scale_Value + _origin.x + _contentOffset.x;// 向手势X方向挪动
            CGFloat startPointY = (_origin.y - _Scale_Y * point1.yValue * _y_PX_Scale_Value + _contentOffset.y); // 向手势Y方向（下）挪动
            
            
            // 终止点
            CGFloat endPointX = _Scale_X * (point2.xValue - _begainX)*_x_PX_Scale_Value + _origin.x + _contentOffset.x;
            CGFloat endPointY =(_origin.y - _Scale_Y * point2.yValue * _y_PX_Scale_Value + _contentOffset.y); // 向手势Y方向（下）挪动
            
            // 转换坐标
            CGPoint startPoint = CGPointMake(startPointX + _contentInset.left , startPointY );
            CGPoint endPoint = CGPointMake(endPointX + _contentInset.left ,endPointY );
            
            
            if (startPoint.x>=self.origin.x && startPoint.x < rect.size.width)
            {
                UIButton *reusableBtn = [self getButton];
                reusableBtn.tag = i;
                reusableBtn.center = startPoint;
//                UIButton *tempBtn = [kBtnArray objectAtIndex:i];
//                tempBtn.tag = i;
//                tempBtn.backgroundColor = [UIColor redColor];
//                tempBtn.bounds = CGRectMake(0, 0, 8, 8);
//                tempBtn.center = startPoint;
//            
                // 颜色点
                UIColor *color1 = [self colorForPoint:point1];
                
                UIColor *color2 = [self colorForPoint:point2];
                
                CGFloat normal[1]={1};
                CGContextSetLineDash(context,0,normal,0); //画实线
                

                if (startPoint.y<=_origin.y) {
                    [HHLineChartTool drawRectPoint:context point:startPoint color:color1];
                }
                
                if ((self.dataSourceArray.count-1) == (i+1)) {
                    UIButton *reusableBtn = [self getButton];
                    reusableBtn.tag = i+1;
                    reusableBtn.center = endPoint;
                    if (endPoint.y<=_origin.y)
                    {
                        [HHLineChartTool drawRectPoint:context point:endPoint color:color2];
                    }
                }
    
            }
            
            
            if (!(endPoint.x < self.origin.x || startPoint.x > rect.size.width)) {
                CGPoint tempStartPoint = startPoint;
                if (startPoint.x< self.origin.x) {
                    tempStartPoint.y = startPoint.y + fabs(self.origin.x - startPoint.x) * (startPoint.y - endPoint.y)/(startPoint.x - endPoint.x);
                    tempStartPoint.x = self.origin.x;
                  
                }
                CGPoint tempEndPoint = endPoint;
                if (endPoint.x > rect.size.width ) {
                    tempEndPoint.x = rect.size.width;
                    tempEndPoint.y =  startPoint.y + fabs(rect.size.width - startPoint.x) * (startPoint.y - endPoint.y)/(startPoint.x - endPoint.x);
                }
                CGPoint tempLowPoint = tempStartPoint;
                CGPoint tempHighPoint = tempEndPoint;
                if (tempHighPoint.y > tempLowPoint.y) {//找出两个点的 Y 最大值  tempHighPoint.y 值 较小 位置较高
                    CGPoint temp = tempLowPoint;
                    tempLowPoint = tempHighPoint;
                    tempHighPoint = temp;
                }
                if (tempHighPoint.y >= _origin.y) {
                    continue;
                }
                if (tempLowPoint.y >= _origin.y) {
                    tempLowPoint.x = tempLowPoint.x - (tempLowPoint.y - _origin.y)*(tempLowPoint.x - tempHighPoint.x)/(tempLowPoint.y - tempHighPoint.y);
                    tempLowPoint.y = _origin.y;
                }
                
                
                CGFloat normal[1]={1};
                CGContextSetLineDash(context,0,normal,0); //画实线
                [HHLineChartTool drawLine:context startPoint:tempLowPoint endPoint:tempHighPoint lineColor:[UIColor greenColor]];
            }
            
            
/*
            //画折线
            if ( isLineIntersectRectangle(xPosition, y1Position, xPosition2, y1Position2, _leftTopPoint.x, _leftTopPoint.y, _rightBottomPoint.x, _rightBottomPoint.y) )
            {
                [ARLineChartCommon drawLine:context startPoint:startPoint endPoint:endPoint lineColor:line1Color];
            }
            //画折线2
            if ( isLineIntersectRectangle(xPosition, y2Position, xPosition2, y2Position2, _leftTopPoint.x, _leftTopPoint.y, _rightBottomPoint.x, _rightBottomPoint.y) )
            {
                [ARLineChartCommon drawLine:context startPoint:startPoint2 endPoint:endPoint2 lineColor:line2Color];
            }
*/

        }
        
        if (self.dataSourceArray.count == 1) {
            HHPoint *point1 = [self.dataSourceArray objectAtIndex:0];
            CGFloat startPointX = _Scale_X * (point1.xValue  - _begainX)*_x_PX_Scale_Value + _origin.x + _contentOffset.x;// 向手势X方向挪动
            CGFloat startPointY = (_origin.y - _Scale_Y * point1.yValue * _y_PX_Scale_Value + _contentOffset.y); // 向手势Y方向（下）挪动
            
            
            // 转换坐标
            CGPoint startPoint = CGPointMake(startPointX + _contentInset.left , startPointY );
            
            if (startPoint.x>=self.origin.x && startPoint.x < rect.size.width)
            {
                UIButton *reusableBtn = [self getButton];
                reusableBtn.tag = 0;
                reusableBtn.center = startPoint;
                //                UIButton *tempBtn = [kBtnArray objectAtIndex:i];
                //                tempBtn.tag = i;
                //                tempBtn.backgroundColor = [UIColor redColor];
                //                tempBtn.bounds = CGRectMake(0, 0, 8, 8);
                //                tempBtn.center = startPoint;
                //
                // 颜色点
                UIColor *color1 = [self colorForPoint:point1];
                
                CGFloat normal[1]={1};
                CGContextSetLineDash(context,0,normal,0); //画实线
                
                
                if (startPoint.y<=_origin.y) {
                    [HHLineChartTool drawRectPoint:context point:startPoint color:color1];
                }
            }
            
        }
        
    }

#pragma mark 按钮文字
 /***************** 按钮文字 *****************/
        //画按钮文字
    
    
    CGFloat startPointX = _Scale_X * (textLocation.x  - _begainX)*_x_PX_Scale_Value + _origin.x + _contentOffset.x;// 向手势X方向挪动
    CGFloat startPointY = (_origin.y - _Scale_Y *textLocation.y * _y_PX_Scale_Value + _contentOffset.y); // 向手势Y方向（下）挪动

        CGSize title1Size = [text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:self.detailTextFont,NSFontAttributeName,nil]];
        CGRect titleRect1 = CGRectMake(startPointX + _contentInset.left,
                                       startPointY,
                                       title1Size.width,
                                       title1Size.height);
    // 文字挡住 x 轴
    if (title1Size.height + startPointY + 6 >= self.origin.y) {
        titleRect1.origin.y -= (title1Size.height + 6);
    }else
    {
        titleRect1.origin.y += 6;
    }
    // 文字超出 y 右边 边界
    if (title1Size.width + startPointX >= rect.size.width) {
        titleRect1.origin.x -= (title1Size.width + 6);
    }else
    {
        titleRect1.origin.x += 6;
    }
    
    if (startPointX + _contentInset.left >= self.origin.x && startPointY <= _origin.y)
    {
        [text drawInRect:titleRect1 withAttributes:[NSDictionary dictionaryWithObjectsAndKeys:self.detailTextFont,NSFontAttributeName,nil]];
    }
}

#pragma makr -
#pragma mark 手势系统

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
//    NSLog(@"654131");
    if (touches.count == 1)
    {
        lastTouch = [touches anyObject];
    }
/*
    NSArray * touchesArr=[[event allTouches] allObjects];
    if (touchesArr.count == 2) {

//        s_p1 = [[touchesArr objectAtIndex:0] locationInView:self];
//        s_p2 =[[touchesArr objectAtIndex:1] locationInView:self];
        CGPoint p1 =[[touchesArr objectAtIndex:0] locationInView:self];
        CGPoint p2 =[[touchesArr objectAtIndex:1] locationInView:self];
        
        touchCenter = CGPointMake((p1.x + p2.x)/2, (p1.y + p2.y)/2);
        //        CGFloat xDiff = fabs(p1.x-s_p1.x) + fabs(p2.x-s_p2.x);
        //        CGFloat yDiff = fabs(p1.y-s_p1.y) + fabs(p2.y-s_p2.y);
        t_x_distance = fabs(p2.x - p1.x);
        t_y_distance = fabs(p2.y - p1.y);
        
//        NSLog(@"touchesBegan x_distance：%f",x_distance);
//        NSLog(@"touchesBegan y_distance：%f",y_distance);

    }
     */

}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSArray * touchesArr=[[event allTouches] allObjects];
    if (touchesArr.count == 1) {
        
        CGPoint touchLocation=[[touches anyObject] locationInView:self];
        CGPoint prevouseLocation=[[touches anyObject] previousLocationInView:self];
        float xDiffrance=touchLocation.x-prevouseLocation.x;
        float yDiffrance=touchLocation.y-prevouseLocation.y;
        
        _contentOffset.x+=xDiffrance;
        _contentOffset.y+=yDiffrance;
        
//        if (_contentOffset.x >_Scale_X *(self.endX + self.begainX) - 20) {
//            _contentOffset.x = _Scale_X *(self.endX + self.begainX) - 20 ;
//        }
/*
        if(_contentOffset.y<0)
        {
            _contentOffset.y=0;
        }
*/
        // 左划
//        if (-_contentOffset.x > (_Scale_X * (self.endX - self.begainX)*_x_PX_Scale_Value - self.frame.size.width + _contentInset.left + _contentInset.right) + _origin.x)
//        {
//            _contentOffset.x = -(_Scale_X * (self.endX - self.begainX)*_x_PX_Scale_Value - self.frame.size.width + _contentInset.left + _contentInset.right +  _origin.x);
//        }
//        
        // 右划
//        if (_contentOffset.x > 0 /* self.frame.size.width - _contentInset.right - _contentInset.left*/) {
//            _contentOffset.x = 0/* self.frame.size.width - _contentInset.right - _contentInset.left*/;
//        }


//        if (-_contentOffset.x > (_Scale_X * (self.endX - self.begainX) + _contentInset.left- _contentInset.right))
//        {
//            _contentOffset.x = -(_Scale_X * (self.endX - self.begainX) + _contentInset.left - _contentInset.right);
//        }
        /*
        if (_contentOffset.y>self.frame.size.height) {
            _contentOffset.y=self.frame.size.height;
        }*/
        
//        NSLog(@"(%f,%F)",self.contentOffset.x,self.contentOffset.y);
        [self setContentOffset:_contentOffset];
        [self setNeedsDisplay];
//        NSLog(@"%f",(touchLocation.x -prevouseLocation.x));
        return;
    }
    /* 缩放
    if (touchesArr.count == 2) {
        
        CGFloat len = 100-20, offset = 80-20;
        CGPoint p1 =[[touchesArr objectAtIndex:0] locationInView:self];
        CGPoint p2 =[[touchesArr objectAtIndex:1] locationInView:self];
        
        CGPoint p_1 = [[touchesArr objectAtIndex:0] previousLocationInView:self];
        CGPoint p_2 = [[touchesArr objectAtIndex:1] previousLocationInView:self];

//        CGFloat xDis = fabs(p1.x-p_1.x) + fabs(p2.x-p_2.x);
//        CGFloat yDis = fabs(p1.y-p_1.y) + fabs(p2.y-p_2.y);
        CGFloat xDis = fabs(p1.x-p_1.x) + fabs(p2.x-p_2.x);
        CGFloat yDis = fabs(p1.y-p_1.y) + fabs(p2.y-p_2.y);


//        NSLog(@"捏合长度x：%f",xDis);
//        NSLog(@"捏合长度y：%f",yDis);

        CGFloat xDistance = fabs(p2.x - p1.x);
        CGFloat yDistance = fabs(p2.y - p1.y);
//        NSLog(@"xDistance：%f",xDistance);
//        NSLog(@"yDistance：%f",yDistance);
        double scale = (xDistance)/t_x_distance;
        if ((scale*_Scale_X)>= 0.0001) {
            
            _contentOffset.x = scale *(_contentOffset.x) + (scale -1)* (touchCenter.x - 0/*视图左边界*/  /*);

            
            self.Scale_X = scale*_Scale_X;
            
             NSLog(@"scal：%f",scale);
        }


        if (xDis >= len && yDis <= offset) { //认为是水平捏合手势
            NSLog(@"是水平捏合手势");
            if (xDistance - t_x_distance > 0) { //双指向外
                NSLog(@"水平双指向外");
//                [self zoomHorizontalUp];
            }
            else { //双指向内
//                NSLog(@"水平双指向内");
//                [self zoomHorizontalDown];
            }
        }

    */
//        else if (xDiff <= offset && yDiff >= len) { //认为是垂直捏合手势
//            NSLog(@"是垂直捏合手势");
//            if (yDistance - s_yDistance > 0) { //双指向外
//                NSLog(@"垂直双指向外");
//                [self zoomVerticalUp];
//            }
//            else { //双指向内
//                NSLog(@"垂直双指向内");
//                [self zoomVerticalDown];
//            }
//        }
//        else  { //认为捏合手势
//            NSLog(@"是捏合手势");
//            if (xDistance - s_xDistance > 0 || yDistance - s_yDistance > 0) { //双指向外
//                NSLog(@"捏合手势双指向外");
//                [self zoomUp];
//            }
//            else { //双指向内
//                NSLog(@"捏合手势双指向内");
//                [self zoomDown];
//            }
//        }

/*
        }
        */
        [self setNeedsDisplay];
    
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
//    NSLog(@"END_ %f",event.timestamp);
    t_x_distance = 0;
    t_y_distance = 0;
    touchCenter = CGPointZero;
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

#pragma makr -
#pragma mark 工具类
- (UIButton *)getButton
{
    UIButton *reusableBtn = [reusableButtonSet anyObject];
    if (!reusableBtn) {
        reusableBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [reusableBtn addTarget:self action:@selector(pointBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        reusableBtn.backgroundColor = [UIColor clearColor];
        reusableBtn.bounds = CGRectMake(0, 0, 20, 20);
        [reusableButtonSet addObject:reusableBtn];
    }
    [self addSubview:reusableBtn];
    [visableButtonSet addObject:reusableBtn];
    [reusableButtonSet removeObject:reusableBtn];
    return reusableBtn;
}

- (void)pointBtnClick:(UIButton *)sender
{
//    sender.tag = ;/
    textLocation.x = CGRectGetMidX(sender.frame);
    textLocation.y = CGRectGetMaxY(sender.frame);
    HHPoint *point = [self.dataSourceArray objectAtIndex:sender.tag];
    text = [NSString stringWithFormat:@"%@ %@\n%@ 血糖值：%.1f",point.date,point.time,point.state,point.yValue];
    
//    CGFloat startPointX = _Scale_X * (point.xValue  - _begainX)*_x_PX_Scale_Value + _origin.x + _contentOffset.x;// 向手势X方向挪动
//    CGFloat startPointY = (_origin.y - point.yValue * _y_PX_Scale_Value);// － _contentOffset.y; // 向手势Y方向（下）挪动
    
//    textLocation = CGPointMake(startPointX, startPointY);
    textLocation = CGPointMake(point.xValue, point.yValue);
    [self setNeedsDisplay];
}

- (UIColor *)colorForPoint:(HHPoint *)point
{
    if (point.yValue >self.maxValueY)
    {// 高于
        return DEF_P_COLOR_MAX;
    }
    else if (point.yValue <self.minValueY)
    {// 低于
        return DEF_P_COLOR_MIN;
    }
    else //if (point1.yValue <=self.maxY &&point1.yValue >=self.minY)
    {// 正常
        return DEF_P_COLOR_NOMAL;
    }
}


/** <p>判断线段是否在矩形内 </p>
 * 先看线段所在直线是否与矩形相交，
 * 如果不相交则返回false，
 * 如果相交，
 * 则看线段的两个点是否在矩形的同一边（即两点的x(y)坐标都比矩形的小x(y)坐标小，或者大）,
 * 若在同一边则返回false，
 * 否则就是相交的情况。
 * @param linePointX1 线段起始点x坐标
 * @param linePointY1 线段起始点y坐标
 * @param linePointX2 线段结束点x坐标
 * @param linePointY2 线段结束点y坐标
 * @param rectangleLeftTopX 矩形左上点x坐标
 * @param rectangleLeftTopY 矩形左上点y坐标
 * @param rectangleRightBottomX 矩形右下点x坐标
 * @param rectangleRightBottomY 矩形右下点y坐标
 * @return 是否相交
 */
static bool isLineIntersectRectangle(CGFloat linePointX1,
                                     CGFloat linePointY1,
                                     CGFloat linePointX2,
                                     CGFloat linePointY2,
                                     CGFloat rectangleLeftTopX,
                                     CGFloat rectangleLeftTopY,
                                     CGFloat rectangleRightBottomX,
                                     CGFloat rectangleRightBottomY)
{
    CGFloat  lineHeight = linePointY1 - linePointY2;
    CGFloat lineWidth = linePointX2 - linePointX1;  // 计算叉乘
    CGFloat c = linePointX1 * linePointY2 - linePointX2 * linePointY1;
    if ((lineHeight * rectangleLeftTopX + lineWidth * rectangleLeftTopY + c >= 0 && lineHeight * rectangleRightBottomX + lineWidth * rectangleRightBottomY + c <= 0)
        || (lineHeight * rectangleLeftTopX + lineWidth * rectangleLeftTopY + c <= 0 && lineHeight * rectangleRightBottomX + lineWidth * rectangleRightBottomY + c >= 0)
        || (lineHeight * rectangleLeftTopX + lineWidth * rectangleRightBottomY + c >= 0 && lineHeight * rectangleRightBottomX + lineWidth * rectangleLeftTopY + c <= 0)
        || (lineHeight * rectangleLeftTopX + lineWidth * rectangleRightBottomY + c <= 0 && lineHeight * rectangleRightBottomX + lineWidth * rectangleLeftTopY + c >= 0))
    {
        
        if (rectangleLeftTopX > rectangleRightBottomX) {
            CGFloat temp = rectangleLeftTopX;
            rectangleLeftTopX = rectangleRightBottomX;
            rectangleRightBottomX = temp;
        }
        if (rectangleLeftTopY < rectangleRightBottomY) {
            CGFloat temp1 = rectangleLeftTopY;
            rectangleLeftTopY = rectangleRightBottomY;
            rectangleRightBottomY = temp1;   }
        if ((linePointX1 < rectangleLeftTopX && linePointX2 < rectangleLeftTopX)
            || (linePointX1 > rectangleRightBottomX && linePointX2 > rectangleRightBottomX)
            || (linePointY1 > rectangleLeftTopY && linePointY2 > rectangleLeftTopY)
            || (linePointY1 < rectangleRightBottomY && linePointY2 < rectangleRightBottomY)) {
            return false;
        } else {
            return true;
        }
    } else {
        return false;
    }
}

@end
