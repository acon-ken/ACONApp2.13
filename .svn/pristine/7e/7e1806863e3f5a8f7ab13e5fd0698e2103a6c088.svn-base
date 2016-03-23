//
//  AppHelper.h
//  ACONApp
//
//  Created by fyf on 14/12/3.
//  Copyright (c) 2014年 zw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"
@interface AppHelper : NSObject
@property (nonatomic,retain)MBProgressHUD *hud;

+ (void)showHUD:(NSString *)msg;
+ (void)removeHUD;

/**
 *  @author HYM, 15-01-19 14:01:21
 *
 *   单例模式
 *
 */
+ (instancetype)shareInstance;
- (void)showHUD_H:(NSString *)msg;
- (void)showHUD_H:(NSString *)msg view:(UIView *)view;
- (void)removeHUD_H;
@end
