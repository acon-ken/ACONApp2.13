//
//  LoadingViewController.m
//  ACONApp
//
//  Created by 朱红轻飞溅 on 14/11/25.
//  Copyright (c) 2014年 zw. All rights reserved.
//

#import "LoadingViewController.h"
#import "GuideViewController.h"
#import "LoginViewController.h"

/**
 *  定义是否第一次访问的key
 */
#define KEY_HAS_LAUNCHED_ONCE   @"HasLaunchedOnce"

@interface LoadingViewController ()

@end

@implementation LoadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    /**
     *  渐隐动画
     */
    [UIView animateWithDuration:2 animations:^{
        _imageView.alpha = 0;
    }];
    
    [self performSelector:@selector(initContentView) withObject:nil afterDelay:2];
    
}


- (void)initContentView
{
    [self checkFirshTimeLaunch];
}

/**
 *  检查是否第一次登陆
 */
- (void)checkFirshTimeLaunch
{
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:KEY_HAS_LAUNCHED_ONCE])
    {
        LoginViewController *VC = [[LoginViewController alloc] init];
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:VC];
        self.view.window.rootViewController = nav;
        
    }
    else
    {
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        [self presentIntro];
    }
}

/**
 *  引导页
 */
-(void)presentIntro {
    
    GuideViewController *vc=[[GuideViewController alloc] init];
    [self.navigationController pushViewController:vc animated:NO];
    
}
@end
