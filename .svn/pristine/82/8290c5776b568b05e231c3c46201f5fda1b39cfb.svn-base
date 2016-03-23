//
//  PopoverView.m
//  Embark
//
//  Created by Oliver Rickard on 20/08/2012.
//
//

#import "BMPopView.h"
#import <QuartzCore/QuartzCore.h>

@implementation BMPopView

+(BMPopView *)shareInstance
{
    static BMPopView *_sharedBMPopView;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedBMPopView = [[BMPopView alloc]init];
    });
    return _sharedBMPopView;
}


- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5f];

        self.contentView = nil;
    }
    return self;
}

- (void)dealloc {
    
    self.contentView = nil;

}


+ (BMPopView *)showWithContentView:(UIView *)cView delegate:(id<BMPopViewDelegate>)delegate {
//    BMPopView *popoverView = [[BMPopView alloc] initWithFrame:CGRectZero];
    BMPopView *popoverView = [BMPopView shareInstance];
    [popoverView showWithContentView:cView];
    popoverView.delegate = delegate;
    return popoverView;
}

- (void)showWithContentView:(UIView *)cView delegate:(id<BMPopViewDelegate>)delegate {
    //    BMPopView *popoverView = [[BMPopView alloc] initWithFrame:CGRectZero];
    BMPopView *popoverView = [BMPopView shareInstance];
    [popoverView showWithContentView:cView];
    popoverView.delegate = delegate;
    //    [popoverView release];
}

- (void)showWithContentView:(UIView *)cView {
    
    self.contentView = cView;
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if(!window) {
        window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    }
    UIView *topView = [[window subviews] objectAtIndex:0];
    
    
    
    CGRect topViewBounds = topView.bounds;
    
    
    _contentView.center = topView.center;
    [self addSubview:_contentView];
    
    self.frame = topViewBounds;
    
    [self setNeedsDisplay];
    
    [window addSubview:self];
//    [topView addSubview:self];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    [self addGestureRecognizer:tap];
    
    self.userInteractionEnabled = YES;
    
    self.alpha = 0.f;
//    self.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
    self.contentView.transform = CGAffineTransformMakeScale(0.1f, 0.1f);

    [UIView animateWithDuration:0.2f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 1.f;
        self.transform = CGAffineTransformMakeScale(1.05f, 1.05f);
        self.contentView.transform = CGAffineTransformMakeScale(1.05f, 1.05f);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.08f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.transform = CGAffineTransformIdentity;
            self.contentView.transform = CGAffineTransformIdentity;
        } completion:nil];
    }];
}


#pragma mark - User Interaction

- (void)tapped:(UITapGestureRecognizer *)tap {
    
    CGPoint point = [tap locationInView:_contentView];
    
    BOOL found = NO;

    if(!found && CGRectContainsPoint(_contentView.bounds, point)) {
        found = YES;
    }
    
    if(!found) {
        [self dismiss];
    }
    
}

- (void)dismiss {
    [UIView animateWithDuration:0.2f animations:^{
        self.alpha = 0.1f;

        self.contentView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if(self.delegate && [self.delegate respondsToSelector:@selector(popViewDidDismiss:)]) {
            [_delegate popViewDidDismiss:self];
        }
        if (_contentView&&[_contentView superview]) {
            [_contentView removeFromSuperview];
        }
       
    }];
}



#pragma mark - Drawing Routines

- (void)adrawRect:(CGRect)rect
{
    CGRect frame = self.frame;
    
    float xMin = CGRectGetMinX(frame);
    float yMin = CGRectGetMinY(frame);
    
    float xMax = CGRectGetMaxX(frame);
    float yMax = CGRectGetMaxY(frame);
    
    float radius = 0;
    
 
    UIBezierPath *popoverPath = [UIBezierPath bezierPath];
    [popoverPath moveToPoint:CGPointMake(CGRectGetMinX(frame), CGRectGetMinY(frame) + radius)];//LT1
    [popoverPath addCurveToPoint:CGPointMake(xMin + radius, yMin) controlPoint1:CGPointMake(xMin, yMin + radius ) controlPoint2:CGPointMake(xMin + radius , yMin)];//LT2
    
    [popoverPath addLineToPoint:CGPointMake(xMax - radius, yMin)];//RT1
    [popoverPath addCurveToPoint:CGPointMake(xMax, yMin + radius) controlPoint1:CGPointMake(xMax - radius, yMin) controlPoint2:CGPointMake(xMax, yMin + radius )];//RT2
    [popoverPath addLineToPoint:CGPointMake(xMax, yMax - radius)];//RB1
    [popoverPath addCurveToPoint:CGPointMake(xMax - radius, yMax) controlPoint1:CGPointMake(xMax, yMax - radius ) controlPoint2:CGPointMake(xMax - radius , yMax)];//RB2

    
    [popoverPath addLineToPoint:CGPointMake(xMin + radius, yMax)];//LB1
    [popoverPath addCurveToPoint:CGPointMake(xMin, yMax - radius) controlPoint1:CGPointMake(xMin + radius , yMax) controlPoint2:CGPointMake(xMin, yMax - radius )];//LB2
    [popoverPath closePath];
    
    //// General Declarations
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Shadow Declarations
    UIColor* shadow = [UIColor colorWithWhite:0.f alpha:0.7];
    CGSize shadowOffset = CGSizeMake(0, 1);
    CGFloat shadowBlurRadius = 10;
    
    //// Gradient Declarations
    NSArray* gradientColors = [NSArray arrayWithObjects:
                               (id)[UIColor colorWithWhite:0.f alpha:0.4f].CGColor,
                               (id)[UIColor colorWithWhite:0.f alpha:0.9f].CGColor, nil];
    CGFloat gradientLocations[] = {0,1};
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)gradientColors, gradientLocations);
    
    
    //These floats are the top and bottom offsets for the gradient drawing so the drawing includes the arrows.
    float bottomOffset = 0;
    float topOffset = 0;
    
    //Draw the actual gradient and shadow.
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
    CGContextBeginTransparencyLayer(context, NULL);
    [popoverPath addClip];
    CGContextDrawLinearGradient(context, gradient, CGPointMake(CGRectGetMidX(frame), CGRectGetMinY(frame) - topOffset), CGPointMake(CGRectGetMidX(frame), CGRectGetMaxY(frame) + bottomOffset), 0);
    CGContextEndTransparencyLayer(context);
    CGContextRestoreGState(context);
    
    // Cleanup
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    
}


@end
