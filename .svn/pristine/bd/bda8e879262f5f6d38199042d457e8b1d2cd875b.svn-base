//
//  AKNavigationController.m
//  ACONApp
//
//  Created by suhe on 14/11/25.
//  Copyright (c) 2014年 zw. All rights reserved.
//

#import "AKNavigationController.h"

@implementation AKNavigationController

+ (void)initialize
{
    // 1.设置导航栏主题
    UINavigationBar *navBar = [UINavigationBar appearance];

    // 设置背景图片
    NSString *bgName = nil;
    if (iOS7) { // 至少是iOS 7.0
        bgName = @"daohangbeijing.png";
        navBar.tintColor = [UIColor whiteColor];
    } else { // 非iOS7
        bgName = @"daohangbeijing.png";
    }
    [navBar setBackgroundImage:[UIImage imageNamed:bgName] forBarMetrics:UIBarMetricsDefault];
    
    // 设置标题文字颜色
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:18];
    [navBar setTitleTextAttributes:attrs];
    
    // 2.设置BarButtonItem的主题
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    // 设置文字颜色
    NSMutableDictionary *itemAttrs = [NSMutableDictionary dictionary];
    itemAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    itemAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:iOS7 ? 15 : 12];;
    [item setTitleTextAttributes:itemAttrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:itemAttrs forState:UIControlStateHighlighted];
    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionary];
    disableTextAttrs[NSForegroundColorAttributeName] =  [UIColor lightGrayColor];
    [item setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
    
    // 设置背景
    if (!iOS7) {
        [item setBackgroundImage:[UIImage imageNamed:@"aaa"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [item setBackgroundImage:[UIImage imageNamed:@"aaa"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
        [item setBackgroundImage:[UIImage imageNamed:@"aaa"] forState:UIControlStateDisabled barMetrics:UIBarMetricsDefault];
    }
}

/**
 *  重写这个方法,能拦截所有的push操作
 *
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    viewController.hidesBottomBarWhenPushed = YES;
    [super pushViewController:viewController animated:YES];
}



@end
