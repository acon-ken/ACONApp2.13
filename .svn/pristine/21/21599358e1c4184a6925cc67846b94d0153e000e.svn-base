//
//  CycleScrollView.m
//  PagedScrollView
//
//  Created by 陈政 on 14-1-23.
//  Copyright (c) 2014年 Apple Inc. All rights reserved.
//

#import "CycleScrollView.h"
#import "NSTimer+Addition.h"
#import "UIView+FLKAutoLayout.h"

@interface CycleScrollView () <UIScrollViewDelegate>

@property (nonatomic , assign) NSInteger currentPageIndex;
@property (nonatomic , assign) NSInteger totalPageCount;
@property (nonatomic , strong) NSMutableArray *contentViews;
@property (nonatomic , strong) UIScrollView *scrollView;
@property (nonatomic , strong) NSTimer *animationTimer;
/**
 *  @author HYM, 15-02-12 10:02:21
 *
 *  公有化
 */
//@property (nonatomic , assign) NSTimeInterval animationDuration;

@end

@implementation CycleScrollView

- (void)setTotalPagesCount:(NSInteger (^)(void))totalPagesCount
{
    _totalPageCount = totalPagesCount();
    if (_totalPageCount > 0) {
        self.scrollView.scrollEnabled = YES;
        self.scrollView.contentSize = CGSizeMake(3 * CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
        self.scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.scrollView.frame), 0);
        
        [self configContentViews];
//        [self.animationTimer resumeTimerAfterTimeInterval:self.animationDuration];
    }else
    {
        self.scrollView.scrollEnabled = NO;
        self.scrollView.contentSize = CGSizeZero;
        self.scrollView.contentOffset = CGPointZero;
    }
}

- (void)setTheTotalPageCount:(NSInteger)totalPageCount
{
    _totalPageCount = totalPageCount;
    if (_totalPageCount > 0) {
        self.scrollView.scrollEnabled = YES;
        self.scrollView.contentSize = CGSizeMake(3 * CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
        self.scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.scrollView.frame), 0);
        
        [self configContentViews];
        //        [self.animationTimer resumeTimerAfterTimeInterval:self.animationDuration];
    }else
    {
        self.scrollView.scrollEnabled = NO;
        self.scrollView.contentSize = CGSizeZero;
        self.scrollView.contentOffset = CGPointZero;
    }
}

- (id)initWithFrame:(CGRect)frame animationDuration:(NSTimeInterval)animationDuration
{
    self = [self initWithFrame:frame];
    if (animationDuration > 0.0) {
        self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:(self.animationDuration = animationDuration)
                                                               target:self
                                                             selector:@selector(animationTimerDidFired:)
                                                             userInfo:nil
                                                              repeats:YES];
        [self.animationTimer pauseTimer];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.autoresizesSubviews = YES;
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        self.scrollView.autoresizingMask = 0xFF;
        self.scrollView.contentMode = UIViewContentModeCenter;
        self.scrollView.contentSize = CGSizeMake(3 * CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
        self.scrollView.delegate = self;
        self.scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.scrollView.frame), 0);
        self.scrollView.pagingEnabled = YES;
        [self addSubview:self.scrollView];
        self.currentPageIndex = 0;
    }
    return self;
}

/**
 *  @author HYM, 15-02-12 10:02:29
 *
 *  设置 从xib加载
 */
- (void)awakeFromNib
{

    self.autoresizesSubviews = YES;
    self.scrollView = [[UIScrollView alloc] init];
    [self addSubview:self.scrollView];
    [self.scrollView alignTop:@"0" leading:@"0" bottom:@"0" trailing:@"0" toView:self];
    self.scrollView.delegate = self;
    
    self.scrollView.autoresizingMask = 0xFF;
    self.scrollView.contentMode = UIViewContentModeCenter;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
//    self.scrollView.contentSize = CGSizeMake(3 * CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
//    self.scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.scrollView.frame), 0);
    self.scrollView.pagingEnabled = YES;
    self.currentPageIndex = 0;
    
}
/**
 *  @author HYM, 15-02-12 10:02:49
 *
 *  设置时间间隔
 *
 *  @param animationDuration 时间间隔
 */
- (void)setAnimationDuration:(NSTimeInterval)animationDuration
{
    if ([self.animationTimer isValid]) {
        [self.animationTimer pauseTimer];
        return;
    }
    
    self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:(_animationDuration = animationDuration)
                                                               target:self
                                                             selector:@selector(animationTimerDidFired:)
                                                             userInfo:nil
                                                              repeats:YES];
    [self.animationTimer pauseTimer];
   
}

/**
 *  @author HYM, 15-02-12 13:02:30
 *
 *  强制布局
 */
- (void)setUp
{
//    [self setNeedsUpdateConstraints];
//    [self updateConstraintsIfNeeded];
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.frame)*3, 0);
    _scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.frame), 0);
    
}
/**
 *  @author HYM, 15-02-12 13:02:32
 *
 *  设置当前页 调block返回当前页
 *
 */
- (void)setCurrentPageIndex:(NSInteger)currentPageIndex
{
    _currentPageIndex = currentPageIndex;
    if (self.currentPageBlock) {
        self.currentPageBlock(currentPageIndex);

    }
}

- (void)setFireTimer:(BOOL)fireTimer
{
    _fireTimer = fireTimer;
    _fireTimer?[self.animationTimer resumeTimer]:[self.animationTimer pauseTimer];
}



#pragma mark -
#pragma mark - 私有函数

- (void)configContentViews
{
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

    [self setScrollViewContentDataSource];
    
    NSInteger counter = 0;
    for (UIView *contentView in self.contentViews) {
        contentView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentViewTapAction:)];
        [contentView addGestureRecognizer:tapGesture];
        CGRect rightRect = contentView.frame;
        /**
         *  @author HYM, 15-02-12 12:02:18
         *
         */
//        if (self.scrollView.frame.size.width<=0) {
//            
//        }
        rightRect.origin = CGPointMake(CGRectGetWidth(_scrollView.frame) * (counter ++), 0);
//        rightRect.origin = CGPointMake(CGRectGetWidth(contentView.frame) * (counter ++), 0);
        
        contentView.frame = rightRect;
        [self.scrollView addSubview:contentView];
    }
    [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0)];
}

/**
 *  设置scrollView的content数据源，即contentViews
 */
- (void)setScrollViewContentDataSource
{
    if (self.totalPageCount<=0) {
        return;
    }
    NSInteger previousPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex - 1];
    NSInteger rearPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex + 1];
    if (self.contentViews == nil) {
        self.contentViews = [@[] mutableCopy];
    }
    [self.contentViews removeAllObjects];
    
    if (self.fetchContentViewAtIndex) {
        [self.contentViews addObject:self.fetchContentViewAtIndex(previousPageIndex)];
        [self.contentViews addObject:self.fetchContentViewAtIndex(_currentPageIndex)];
        [self.contentViews addObject:self.fetchContentViewAtIndex(rearPageIndex)];
    }
}

- (NSInteger)getValidNextPageIndexWithPageIndex:(NSInteger)currentPageIndex;
{
    if(currentPageIndex == -1) {
        return self.totalPageCount - 1;
    } else if (currentPageIndex == self.totalPageCount) {
        return 0;
    } else {
        return currentPageIndex;
    }
}

#pragma mark -
#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.animationTimer pauseTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.animationTimer resumeTimerAfterTimeInterval:self.animationDuration];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{

    CGFloat contSizeW = scrollView.contentSize.width;
    if (contSizeW<=0) {
        return;
    }
    int contentOffsetX = scrollView.contentOffset.x;
    
    if(contentOffsetX >= (2 * CGRectGetWidth(scrollView.frame))) {
        self.currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex + 1];
        NSLog(@"next，当前页:%ld",(long)self.currentPageIndex);
        [self configContentViews];
    }
    if(contentOffsetX <= 0) {
        self.currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex - 1];
        NSLog(@"previous，当前页:%ld",(long)self.currentPageIndex);
        [self configContentViews];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [scrollView setContentOffset:CGPointMake(CGRectGetWidth(scrollView.frame), 0) animated:YES];
}


- (void)lastPage
{
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}
- (void)nestPage
{

    [self.scrollView setContentOffset:CGPointMake(2*CGRectGetWidth(_scrollView.frame), 0) animated:YES];
}

- (void)setcurPages:(NSUInteger)page
{
    self.currentPageBlock(page);
    
    _currentPageIndex = page;
    [self configContentViews];
}


#pragma mark -
#pragma mark - 响应事件

- (void)animationTimerDidFired:(NSTimer *)timer
{
    CGPoint newOffset = CGPointMake(self.scrollView.contentOffset.x + CGRectGetWidth(self.scrollView.frame), self.scrollView.contentOffset.y);
    [self.scrollView setContentOffset:newOffset animated:YES];
}

- (void)contentViewTapAction:(UITapGestureRecognizer *)tap
{
    if (self.TapActionBlock) {
        self.TapActionBlock(self.currentPageIndex);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
