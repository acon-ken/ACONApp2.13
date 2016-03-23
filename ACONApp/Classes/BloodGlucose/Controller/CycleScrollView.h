//
//  CycleScrollView.h
//  PagedScrollView
//
//  Created by 陈政 on 14-1-23.
//  Copyright (c) 2014年 Apple Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CycleScrollView : UIView

@property (nonatomic , readonly) UIScrollView *scrollView;
/**
 *  @author HYM, 15-02-12 10:02:43
 *
 *  轮播时间间隔 只能初始化一次 公有化
 */
@property (nonatomic , assign) NSTimeInterval animationDuration;

/**
 *  @author HYM, 15-02-12 14:02:33
 *
 *  是否开启定时器
 */
@property (nonatomic , assign) BOOL fireTimer;



/**
 *  初始化
 *
 *  @param frame             frame
 *  @param animationDuration 自动滚动的间隔时长。如果<=0，不自动滚动。
 *
 *  @return instance
 */
- (id)initWithFrame:(CGRect)frame animationDuration:(NSTimeInterval)animationDuration;

/**
 数据源：获取总的page个数
 **/
@property (nonatomic , copy) NSInteger (^totalPagesCount)(void);
/**
 数据源：获取第pageIndex个位置的contentView
 **/
@property (nonatomic , copy) UIView *(^fetchContentViewAtIndex)(NSInteger pageIndex);
/**
 当点击的时候，执行的block
 **/
@property (nonatomic , copy) void (^TapActionBlock)(NSInteger pageIndex);



/**
 *  @author HYM, 15-02-13 11:02:04
 *
 *  手动翻页
 */
- (void)lastPage;
- (void)nestPage;

- (void)setcurPages:(NSUInteger)page;

/**
 *  @author HYM, 15-02-13 17:02:41
 *
 *  刷新数据
 *
 */
- (void)setTheTotalPageCount:(NSInteger)totalPageCount;

/**
 *  @author HYM, 15-02-12 12:02:12
 *
 *  当前pageindex
 */
@property (nonatomic , copy) void (^currentPageBlock)(NSInteger currentPage);
/**
 *  @author HYM, 15-02-12 13:02:49
 *
 *  强制布局
 */
- (void)setUp;
@end