//
//  AppDelegate.h
//  ACONApp
//
//  Created by 朱红轻飞溅 on 14/11/25.
//  Copyright (c) 2014年 zw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AGViewDelegate.h"
#import <TencentOpenAPI/TencentOAuth.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+ (AppDelegate *)shareAppDelegate;

@property (nonatomic,readonly) AGViewDelegate *viewDelegate;

@property (nonatomic) SSInterfaceOrientationMask interfaceOrientationMask;

@property (nonatomic,strong)  MBProgressHUD* progressTest;

@end

