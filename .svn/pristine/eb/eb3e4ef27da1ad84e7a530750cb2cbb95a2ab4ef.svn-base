//
//  AppHelper.m
//  ACONApp
//
//  Created by fyf on 14/12/3.
//  Copyright (c) 2014年 zw. All rights reserved.
//

#import "AppHelper.h"

@implementation AppHelper
static MBProgressHUD *HUD;
//MBProgressHUD 的使用方式，只对外两个方法，可以随时使用(但会有警告！)，其中窗口的 alpha 值 可以在源程序里修改。
+ (void)showHUD:(NSString *)msg{
    
    HUD = [[MBProgressHUD alloc] initWithWindow:[UIApplication sharedApplication].keyWindow];
    [[UIApplication sharedApplication].keyWindow addSubview:HUD];
    HUD.dimBackground = YES;
    HUD.labelText = msg;
    [HUD show:YES];
}
+ (void)removeHUD{
    
    [HUD hide:YES];
    [HUD removeFromSuperViewOnHide];
    //	[HUD release];
}

+ (instancetype)shareInstance
{
    static AppHelper *_appHelper;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _appHelper = [[AppHelper alloc]init];
    });
    return _appHelper;
}



- (void)showHUD_H:(NSString *)msg{
    
    if (!_hud) {
        _hud = [[MBProgressHUD alloc] initWithWindow:[UIApplication sharedApplication].keyWindow];
        
    }
    [[UIApplication sharedApplication].keyWindow addSubview:_hud];
    _hud.dimBackground = YES;
    _hud.labelText = msg;
    [_hud show:YES];
}

- (void)showHUD_H:(NSString *)msg view:(UIView *)view{
    
    if (!_hud) {
        //        _hud = [[MBProgressHUD alloc] initWithWindow:[UIApplication sharedApplication].keyWindow];
        _hud = [[MBProgressHUD alloc] initWithView:view];
        
    }
    //    [[UIApplication sharedApplication].keyWindow addSubview:_hud];
    [view addSubview:_hud];
    _hud.dimBackground = YES;
    _hud.labelText = msg;
    [_hud show:YES];
}

- (void)removeHUD_H{
    _hud.removeFromSuperViewOnHide = YES;

    [_hud hide:YES];
    //	[HUD release];
}

- (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    if (!_hud) {
        _hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    }
    _hud.labelText = message;
    // 隐藏时候从父控件中移除
    _hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    _hud.dimBackground = YES;
    return _hud;
}

@end
