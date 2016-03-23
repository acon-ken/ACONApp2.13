//
//  GuideViewController.m
//  ACONApp
//
//  Created by 朱红轻飞溅 on 14/11/25.
//  Copyright (c) 2014年 zw. All rights reserved.
//

#import "GuideViewController.h"
#import "UIView+FLKAutoLayout.h"
#import "LoginViewController.h"


#define KEY_HAS_LAUNCHED_ONCE   @"HasLaunchedOnce"



@interface GuideViewController ()<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    UIImageView *_page1View;
    UIImageView *_page2View;
    UIImageView *_page3View;
    UIImageView *_page4View;
    UIImageView *_page5View;
    UIButton    *_btnEnter;
    
    
}

@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden=YES;
    self.view.backgroundColor=[UIColor whiteColor];
    [[UIApplication sharedApplication] setStatusBarHidden:TRUE];
    
    [self initViews];
    [self layoutViews];
    
}

- (void)initViews
{
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    
    /**
     *  添加引导页
     */
    _page1View = [[UIImageView alloc] init];
    _page1View.userInteractionEnabled = YES;
    _page1View.image = [UIImage imageNamed:@"引导页-01.jpg"];
    [_scrollView addSubview:_page1View];
    
    _page2View = [[UIImageView alloc] init];
    _page2View.userInteractionEnabled = YES;
    _page2View.image = [UIImage imageNamed:@"引导页-02.jpg"];
    [_scrollView addSubview:_page2View];
    
    _page3View = [[UIImageView alloc] init];
    _page3View.userInteractionEnabled = YES;
    _page3View.image = [UIImage imageNamed:@"引导页-03.jpg"];
    [_scrollView addSubview:_page3View];
    
    _page4View = [[UIImageView alloc] init];
    _page4View.userInteractionEnabled = YES;
    _page4View.image = [UIImage imageNamed:@"引导页-04.jpg"];
    [_scrollView addSubview:_page4View];
 
    _page5View = [[UIImageView alloc] init];
    _page5View.userInteractionEnabled = YES;
    _page5View.image = [UIImage imageNamed:@"引导页-05.jpg"];
    [_scrollView addSubview:_page5View];
    
    
    _btnEnter = [[UIButton alloc] init];
        _btnEnter.backgroundColor = [UIColor redColor];
    _btnEnter.titleLabel.font = [UIFont systemFontOfSize:12];
    [_btnEnter setTitle:@"" forState:UIControlStateNormal];
    [_page5View addSubview:_btnEnter];
    [_btnEnter addTarget:self action:@selector(enterAction) forControlEvents:UIControlEventTouchUpInside];
 
    _scrollView.userInteractionEnabled =YES;
    //手势识别
    UISwipeGestureRecognizer *recognizer;
    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    recognizer.delegate = self;
    [_page5View addGestureRecognizer:recognizer];
}


#pragma mark 多手势识别
- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return  YES;
    
}

-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer{
    if(recognizer.direction==UISwipeGestureRecognizerDirectionLeft) {
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:KEY_HAS_LAUNCHED_ONCE];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        LoginViewController *VC = [[LoginViewController alloc] init];
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:VC];
        self.view.window.rootViewController = nav;

    }
}



- (void)layoutViews
{
    [_scrollView alignToView:self.view];
    
    
    float screenWidth = self.view.frame.size.width;
    float screenHeight = self.view.frame.size.height;
    
    [_page1View constrainWidth:@(screenWidth).stringValue];
    [_page1View constrainHeight:@(screenHeight).stringValue];
    
    [_page1View alignTop:@"0" leading:@"0" toView:_scrollView];
    
    
    [_page2View constrainWidth:@(screenWidth).stringValue];
    [_page2View constrainHeight:@(screenHeight).stringValue];
    [_page2View alignTop:@"0" leading:@(screenWidth).stringValue toView:_scrollView];
    
    
    
    [_page3View constrainWidth:@(screenWidth).stringValue];
    [_page3View constrainHeight:@(screenHeight).stringValue];
    [_page3View alignTop:@"0" leading:@(screenWidth*2).stringValue toView:_scrollView];
    
    
    [_page4View constrainWidth:@(screenWidth).stringValue];
    [_page4View constrainHeight:@(screenHeight).stringValue];
    [_page4View alignTop:@"0" leading:@(screenWidth*3).stringValue toView:_scrollView];
//     [_page4View alignTrailingEdgeWithView:_scrollView predicate:@"0"];
    
    [_page5View constrainWidth:@(screenWidth).stringValue];
    [_page5View constrainHeight:@(screenHeight).stringValue];
    [_page5View alignTop:@"0" leading:@(screenWidth*4).stringValue toView:_scrollView];
    [_page5View alignTrailingEdgeWithView:_scrollView predicate:@"0"];
    
    _btnEnter.backgroundColor = [UIColor clearColor];
    [_btnEnter alignLeading:nil trailing:@"-200" toView:_page5View];
    [_btnEnter alignBottomEdgeWithView:_page5View predicate:@"-250"];
    [_btnEnter constrainWidth:@"100" height:@"100"];
    
}

#pragma mark - page control
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}


- (void)enterAction
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:KEY_HAS_LAUNCHED_ONCE];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    LoginViewController *VC = [[LoginViewController alloc] init];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:VC];
    self.view.window.rootViewController = nav;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
